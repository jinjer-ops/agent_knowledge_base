[CmdletBinding()]
param(
    # このリポジトリの根。既定はこのスクリプトの 1 つ上のフォルダ。
    [string]$RepoRoot,
    # 共有しない指示ファイル（社内・個人）。Claude は読み込み、Codex と Antigravity は末尾に連結する。
    [string[]]$PrivateOverlay = @(),
    # Antigravity にも入れる。公式の置き場へつなぐが、リンクを辿るかは公式の文書に書かれていない。
    [switch]$Antigravity,
    # 既にあるコピーをリンクへ置き換える。コピーは消さず、退避フォルダへ移す。
    [switch]$ReplaceCopies,
    # 何も書き込まずに、今の状態だけを報告する。
    [switch]$Check,
    # 入れる先のホーム。既定は実行した利用者のホーム（試験では一時フォルダを渡す）。
    [string]$HomeRoot,
    # 門に使う版を固定する一覧（JSON）。渡すと、作業用の clone ではなく、読むだけの固定の置き場から入れる。
    [string]$GateManifest,
    # 固定の置き場を新しくする（設定のリポジトリは fast-forward だけ、道具のリポジトリは設定が指す SHA へ）。
    [switch]$Update,
    # 一覧の environment を書く先。User = 利用者の環境変数、Process = この実行の中だけ、None = 書かない。
    [ValidateSet('User', 'Process', 'None')]
    [string]$EnvironmentTarget = 'User'
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = Split-Path -Parent $PSScriptRoot
}
$RepoRoot = (Resolve-Path -LiteralPath $RepoRoot).Path
$userHome = if ([string]::IsNullOrWhiteSpace($HomeRoot)) { [Environment]::GetFolderPath('UserProfile') } else { [System.IO.Path]::GetFullPath($HomeRoot) }
$onWindows = [Environment]::OSVersion.Platform -eq [PlatformID]::Win32NT
$problems = New-Object System.Collections.Generic.List[string]
$actions = New-Object System.Collections.Generic.List[string]
$gateEnvironment = [ordered]@{}

# ---------------------------------------------------------------- 門の版の固定
# 作業用の clone は、そのとき載っている枝で中身が変わる。門（skill の検査と組織の設定）がそれに
# 引きずられないよう、読むだけの clone を別に持ち、版は設定のリポジトリの pins ファイルで決める。
# 設定のリポジトリは既定の枝に fast-forward だけで付いていき、道具のリポジトリは pins の SHA に detach する。
function Invoke-Git([string]$Dir, [string[]]$GitArgs) {
    # Windows PowerShell 5.1 は、Stop のままだと git の標準エラーの 1 行目で止まる。終了コードで判断する。
    $ErrorActionPreference = 'Continue'
    $output = & git -C $Dir @GitArgs 2>&1
    return [pscustomobject]@{ Code = $LASTEXITCODE; Text = (($output | ForEach-Object { "$_" }) -join "`n").Trim() }
}

function Expand-HomePath([string]$Path) {
    if ($Path -eq '~') { return $userHome }
    if ($Path.StartsWith('~/') -or $Path.StartsWith('~\')) { return Join-Path $userHome $Path.Substring(2) }
    return [System.IO.Path]::GetFullPath($Path)
}

function Test-Clean([string]$Dir, [string]$Label) {
    $status = Invoke-Git $Dir @('status', '--porcelain')
    if ($status.Code -ne 0) { $problems.Add("gate: ${Label}: cannot read status: $($status.Text)"); return $false }
    if ($status.Text) { $problems.Add("gate: ${Label}: $Dir has local changes; the pinned copy must stay read-only"); return $false }
    return $true
}

function Sync-PolicyRepository($Spec, [string]$Dir) {
    $branch = if ($Spec.branch) { [string]$Spec.branch } else { 'main' }
    if (-not (Test-Path -LiteralPath (Join-Path $Dir '.git'))) {
        if ($Check) { $problems.Add("gate: $Dir is missing"); return $false }
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Dir) | Out-Null
        $r = Invoke-Git (Split-Path -Parent $Dir) @('clone', '--quiet', '--branch', $branch, [string]$Spec.url, $Dir)
        if ($r.Code -ne 0) { $problems.Add("gate: clone failed: $($Spec.url): $($r.Text)"); return $false }
        $actions.Add("cloned: $($Spec.url) -> $Dir ($branch)")
        return $true
    }
    if (-not (Test-Clean $Dir $Spec.name)) { return $false }
    $head = (Invoke-Git $Dir @('rev-parse', 'HEAD')).Text
    if ($Check) {
        # 書き込まずに、送り元の既定の枝の先と比べる。
        $remote = Invoke-Git $Dir @('ls-remote', 'origin', "refs/heads/$branch")
        if ($remote.Code -ne 0 -or -not $remote.Text) { $problems.Add("gate: cannot reach origin of $Dir"); return $true }
        $tip = ($remote.Text -split '\s+')[0]
        if ($tip -ne $head) { $problems.Add("gate: $Dir is at $($head.Substring(0, 12)), origin/$branch is $($tip.Substring(0, 12)) (rerun with -Update)") }
        return $true
    }
    if ($Update) {
        $r = Invoke-Git $Dir @('fetch', '--quiet', 'origin', $branch)
        if ($r.Code -ne 0) { $problems.Add("gate: fetch failed in ${Dir}: $($r.Text)"); return $false }
        $r = Invoke-Git $Dir @('merge', '--ff-only', '--quiet', "origin/$branch")
        if ($r.Code -ne 0) { $problems.Add("gate: $Dir cannot fast-forward to origin/${branch}: $($r.Text)"); return $false }
        $now = (Invoke-Git $Dir @('rev-parse', 'HEAD')).Text
        if ($now -ne $head) { $actions.Add("updated: $Dir $($head.Substring(0, 12)) -> $($now.Substring(0, 12))") }
    }
    return $true
}

function Sync-ToolRepository($Spec, [string]$Dir, [string]$Sha) {
    $fresh = $false
    if (-not (Test-Path -LiteralPath (Join-Path $Dir '.git'))) {
        $fresh = $true
        if ($Check) { $problems.Add("gate: $Dir is missing"); return $false }
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Dir) | Out-Null
        $r = Invoke-Git (Split-Path -Parent $Dir) @('clone', '--quiet', '--no-checkout', [string]$Spec.url, $Dir)
        if ($r.Code -ne 0) { $problems.Add("gate: clone failed: $($Spec.url): $($r.Text)"); return $false }
        $actions.Add("cloned: $($Spec.url) -> $Dir")
    } elseif (-not (Test-Clean $Dir $Spec.name)) {
        return $false
    }
    $head = (Invoke-Git $Dir @('rev-parse', '--verify', '--quiet', 'HEAD')).Text
    # --no-checkout の直後は HEAD が既定の枝を指していても、作業ツリーは空。必ず取り出す。
    if ($head -eq $Sha -and -not $fresh) { return $true }
    if ($Check) {
        $shown = if ($head) { $head.Substring(0, 12) } else { 'nothing' }
        $problems.Add("gate: $Dir is at $shown, the pin is $($Sha.Substring(0, 12)) (rerun with -Update)")
        return $true
    }
    $has = Invoke-Git $Dir @('cat-file', '-e', "$Sha^{commit}")
    if ($has.Code -ne 0) {
        $r = Invoke-Git $Dir @('fetch', '--quiet', 'origin', $Sha)
        if ($r.Code -ne 0) { $problems.Add("gate: cannot fetch pinned commit $Sha into ${Dir}: $($r.Text)"); return $false }
    }
    $r = Invoke-Git $Dir @('checkout', '--quiet', '--detach', $Sha)
    if ($r.Code -ne 0) { $problems.Add("gate: cannot check out $Sha in ${Dir}: $($r.Text)"); return $false }
    $actions.Add("pinned: $Dir -> $($Sha.Substring(0, 12))")
    return $true
}

if (-not [string]::IsNullOrWhiteSpace($GateManifest)) {
    if (-not (Test-Path -LiteralPath $GateManifest)) { throw "Gate manifest not found: $GateManifest" }
    $gate = Get-Content -Raw -Encoding UTF8 -LiteralPath $GateManifest | ConvertFrom-Json
    foreach ($key in 'policy_repository', 'tool_repository') {
        if ($null -eq $gate.$key -or -not $gate.$key.name -or -not $gate.$key.url) { throw "Gate manifest needs $key.name and $key.url" }
    }
    $pinnedRoot = Expand-HomePath $(if ($gate.pinned_root) { [string]$gate.pinned_root } else { '~/.agent-environment/pinned' })
    $policyDir = Join-Path $pinnedRoot ([string]$gate.policy_repository.name)
    $toolDir = Join-Path $pinnedRoot ([string]$gate.tool_repository.name)

    $policyReady = Sync-PolicyRepository $gate.policy_repository $policyDir
    $sha = $null
    if ($policyReady) {
        $pinsFile = Join-Path $policyDir $(if ($gate.policy_repository.pins_file) { [string]$gate.policy_repository.pins_file } else { 'config/gate-pins.json' })
        if (-not (Test-Path -LiteralPath $pinsFile)) {
            $problems.Add("gate: pins file not found: $pinsFile")
        } else {
            $pinKey = if ($gate.tool_repository.pin_key) { [string]$gate.tool_repository.pin_key } else { [string]$gate.tool_repository.name }
            $pins = Get-Content -Raw -Encoding UTF8 -LiteralPath $pinsFile | ConvertFrom-Json
            $sha = [string]$pins.$pinKey.sha
            if ($sha -notmatch '^[0-9a-f]{40}$') { $problems.Add("gate: $pinsFile has no full SHA for '$pinKey'"); $sha = $null }
        }
    }
    $toolReady = $false
    if ($sha) { $toolReady = Sync-ToolRepository $gate.tool_repository $toolDir $sha }
    if (-not ($policyReady -and $toolReady) -and -not (Test-Path -LiteralPath (Join-Path $toolDir 'skills'))) {
        # 固定の置き場が無いまま、作業用の clone へ黙って戻らない。
        foreach ($line in $actions) { Write-Host $line }
        foreach ($line in $problems) { Write-Warning $line }
        if ($Check) { exit 1 }
        exit 2
    }
    $RepoRoot = (Resolve-Path -LiteralPath $toolDir).Path
    if ($gate.environment) {
        foreach ($prop in $gate.environment.PSObject.Properties) {
            $value = ([string]$prop.Value).Replace('{policy}', $policyDir).Replace('{tool}', $toolDir).Replace('{home}', $userHome)
            $gateEnvironment[$prop.Name] = [System.IO.Path]::GetFullPath($value)
        }
    }
}

$sharedRules = Join-Path (Join-Path $RepoRoot 'environment') 'AGENTS.md'
$skillsRoot = Join-Path $RepoRoot 'skills'
$claudeAgentsRoot = Join-Path (Join-Path (Join-Path $RepoRoot 'environment') 'claude') 'agents'
$marker = '# GENERATED FILE'
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backupRoot = Join-Path (Join-Path $userHome '.agent-environment-backup') $stamp
$utf8 = New-Object System.Text.UTF8Encoding($false)

if (-not (Test-Path -LiteralPath $sharedRules)) { throw "Shared rules not found: $sharedRules" }
$overlays = @()
foreach ($path in $PrivateOverlay) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Private overlay not found: $path" }
    $overlays += (Resolve-Path -LiteralPath $path).Path
}

# 指示ファイルの置き場と、skill の置き場。Codex の利用者全体の置き場は ~/.agents/skills。
$runtimes = [ordered]@{
    'claude' = @{ Instructions = '.claude/CLAUDE.md'; Mode = 'import'; SkillDirs = @('.claude/skills') }
    'codex'  = @{ Instructions = '.codex/AGENTS.md'; Mode = 'concat'; SkillDirs = @('.agents/skills') }
}
if ($Antigravity) {
    $runtimes['antigravity'] = @{ Instructions = '.gemini/AGENTS.md'; Mode = 'concat'
        SkillDirs = @('.gemini/config/skills', '.gemini/antigravity-cli/skills') }
}

# runtime ごとの除外。codex-implement は「ブリーフに従って実装する側」の契約で、設計・引き継ぎ側の
# 契約（codex-claude-handoff）と同じ runtime に置くと、役割の分離が設定の上で表現されなくなる。
$skillRuntimeExclusions = @{
    'claude'      = @()
    'codex'       = @('codex-implement')
    'antigravity' = @()
}

function Write-Text([string]$Path, [string]$Content) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Path) | Out-Null
    [System.IO.File]::WriteAllText($Path, $Content, $utf8)
}

function Get-LinkTarget($Item) {
    if ($Item.LinkType -ne 'Junction' -and $Item.LinkType -ne 'SymbolicLink') { return $null }
    $target = @($Item.Target)[0]
    if ([string]::IsNullOrEmpty($target)) { return '' }
    return [System.IO.Path]::GetFullPath($target)
}

function Move-Aside([string]$Path, [string]$Relative) {
    # 退避先はホームからの相対の形をそのまま写す（同じ名前の skill が別の置き場にあっても衝突しない）。
    $dest = Join-Path $backupRoot $Relative
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dest) | Out-Null
    Move-Item -LiteralPath $Path -Destination $dest
    $actions.Add("moved aside: $Path -> $dest")
}

function Sync-Instructions([string]$Runtime, $Spec) {
    $path = Join-Path $userHome $Spec.Instructions
    $header = "$marker — edit the files named below, not this one."
    if ($Spec.Mode -eq 'import') {
        # Claude Code の読み込み（@パス）は「\」区切りのパスを解決しない（2026-10-15 に確かめた）。「/」で書く。
        $lines = @($header, "@$($sharedRules -replace '\\', '/')") +
            @($overlays | ForEach-Object { "@$($_ -replace '\\', '/')" })
        $content = ($lines -join "`n") + "`n"
    } else {
        $parts = @($header, "<!-- source: $sharedRules -->", '', (Get-Content -Raw -LiteralPath $sharedRules))
        foreach ($overlay in $overlays) {
            $parts += @('', "<!-- source: $overlay -->", '', (Get-Content -Raw -LiteralPath $overlay))
        }
        $content = (($parts -join "`n") -replace "`r`n", "`n").TrimEnd() + "`n"
    }
    if (Test-Path -LiteralPath $path) {
        $current = [System.IO.File]::ReadAllText($path).TrimStart([char]0xFEFF)
        if (-not $current.StartsWith($marker)) {
            $problems.Add("${Runtime}: $path is your own file; add these lines yourself:`n$content")
            return
        }
        if ($current -eq $content) { return }
    }
    if ($Check) { $problems.Add("${Runtime}: $path is missing or outdated"); return }
    Write-Text $path $content
    $actions.Add("wrote: $path")
}

function Sync-Link([string]$Runtime, [string]$Source, [string]$Relative) {
    $Target = Join-Path $userHome $Relative
    $source = [System.IO.Path]::GetFullPath($Source)
    if (Test-Path -LiteralPath $Target) {
        $item = Get-Item -LiteralPath $Target -Force
        $current = Get-LinkTarget $item
        if ($null -ne $current -and $current.TrimEnd('\', '/') -eq $source.TrimEnd('\', '/')) { return }
        if ($Check -or -not $ReplaceCopies) {
            $kind = if ($null -eq $current) { 'a copy' } else { "a link to $current" }
            $problems.Add("${Runtime}: $Target is $kind (rerun with -ReplaceCopies to link it to $source)")
            return
        }
        if ($null -eq $current) { Move-Aside $Target $Relative } else { $item.Delete() }
    } elseif ($Check) {
        $problems.Add("${Runtime}: $Target is missing"); return
    }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Target) | Out-Null
    $linkType = if ($onWindows) { 'Junction' } else { 'SymbolicLink' }
    New-Item -ItemType $linkType -Path $Target -Target $source | Out-Null
    $actions.Add("linked: $Target -> $source")
}

function Sync-File([string]$Runtime, [string]$Source, [string]$Relative) {
    $Target = Join-Path $userHome $Relative
    # Windows では利用者の権限でファイルの symlink を作れないため、subagent の定義はコピーで置く。
    $wanted = [System.IO.File]::ReadAllText($Source)
    if (Test-Path -LiteralPath $Target) {
        if ([System.IO.File]::ReadAllText($Target) -eq $wanted) { return }
        if ($Check -or -not $ReplaceCopies) {
            $problems.Add("${Runtime}: $Target differs from $Source (rerun with -ReplaceCopies to replace it)")
            return
        }
        Move-Aside $Target $Relative
    } elseif ($Check) {
        $problems.Add("${Runtime}: $Target is missing"); return
    }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Target) | Out-Null
    Copy-Item -LiteralPath $Source -Destination $Target
    $actions.Add("copied: $Source -> $Target")
}

$skills = @(Get-ChildItem -LiteralPath $skillsRoot -Directory |
    Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') } |
    Sort-Object Name)

foreach ($runtime in $runtimes.Keys) {
    $spec = $runtimes[$runtime]
    Sync-Instructions $runtime $spec
    foreach ($dir in $spec.SkillDirs) {
        $skillDir = Join-Path $userHome $dir
        foreach ($skill in $skills) {
            if ($skillRuntimeExclusions[$runtime] -contains $skill.Name) { continue }
            Sync-Link $runtime $skill.FullName "$dir/$($skill.Name)"
        }
        if (Test-Path -LiteralPath $skillDir) {
            $shared = @($skills | ForEach-Object { $_.Name })
            $own = @(Get-ChildItem -LiteralPath $skillDir -Directory -Force |
                Where-Object { $shared -notcontains $_.Name -and -not $_.Name.StartsWith('.') } |
                ForEach-Object { $_.Name })
            if ($own.Count -gt 0) {
                Write-Host "${runtime}: skills kept as your own (not in this repository): $($own -join ', ')"
            }
        }
    }
}

if (Test-Path -LiteralPath $claudeAgentsRoot) {
    foreach ($agent in Get-ChildItem -LiteralPath $claudeAgentsRoot -Filter '*.md' -File) {
        Sync-File 'claude' $agent.FullName ".claude/agents/$($agent.Name)"
    }
}

foreach ($name in $gateEnvironment.Keys) {
    $wanted = $gateEnvironment[$name]
    if ($EnvironmentTarget -eq 'None') { continue }
    $current = [Environment]::GetEnvironmentVariable($name, $EnvironmentTarget)
    if ($current -eq $wanted) { continue }
    if ($Check) { $problems.Add("environment: $name is '$current', expected '$wanted'"); continue }
    if ($EnvironmentTarget -eq 'User' -and -not $onWindows) {
        $problems.Add("environment: set $name=$wanted in your shell profile (user variables are Windows only)"); continue
    }
    [Environment]::SetEnvironmentVariable($name, $wanted, $EnvironmentTarget)
    $actions.Add("environment: $name=$wanted ($EnvironmentTarget)")
}

foreach ($line in $actions) { Write-Host $line }
if ($problems.Count -gt 0) {
    foreach ($line in $problems) { Write-Warning $line }
    if ($Check) { exit 1 }
    exit 2
}
if ($Check) {
    Write-Host 'Environment is in sync with this repository.'
} else {
    Write-Host 'Installed. Restart each agent session to reload global guidance.'
}
