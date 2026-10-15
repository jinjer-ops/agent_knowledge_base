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
    [string]$HomeRoot
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($RepoRoot)) {
    $RepoRoot = Split-Path -Parent $PSScriptRoot
}
$RepoRoot = (Resolve-Path -LiteralPath $RepoRoot).Path
$userHome = if ([string]::IsNullOrWhiteSpace($HomeRoot)) { [Environment]::GetFolderPath('UserProfile') } else { [System.IO.Path]::GetFullPath($HomeRoot) }
$onWindows = [Environment]::OSVersion.Platform -eq [PlatformID]::Win32NT
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

$problems = New-Object System.Collections.Generic.List[string]
$actions = New-Object System.Collections.Generic.List[string]

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
