---
id: ENVIRONMENT
title: Agent environment to install
type: setup-guide
status: active
created_at: 2026-10-15
updated_at: 2026-10-15
owners: [knowledge-stewards]
tags: [environment, agents-md, skills, install]
---

# 入れる環境（environment）

このリポジトリのうち、そのまま自分の端末に入れて使う部分です。共通の指示ファイル（AGENTS.md）と skill を、Claude Code・Codex・Antigravity へつなぎます。なぜこの形になっているかと、その出典は [../foundation/](../foundation/) と [../knowledge/](../knowledge/) にあります。

## 何が入るか

| もの | 置き場（このリポジトリ） | 入る先 |
| --- | --- | --- |
| 共通の作業合意 | [AGENTS.md](AGENTS.md) | Claude Code: `~/.claude/CLAUDE.md` から読み込む／Codex: `~/.codex/AGENTS.md`／Antigravity: `~/.gemini/AGENTS.md` |
| skill | [../skills/](../skills/) | Claude Code: `~/.claude/skills/`／Codex: `~/.agents/skills/`／Antigravity: `~/.gemini/config/skills/` と `~/.gemini/antigravity-cli/skills/` |
| Claude Code の subagent | [claude/agents/](claude/agents/) | `~/.claude/agents/` |

skill はリンクで入るので、このリポジトリを `git pull` すると、入った先も新しくなります。subagent の定義はコピーで入ります（Windows では利用者の権限でファイルのリンクを作れないため）。更新したら導入をもう一度実行します。

Codex には `codex-implement` を入れません。設計側（Codex）が書いたブリーフに従って実装する側の契約なので、設計側と同じ所に置くと、役割の分離が設定の上で表せなくなるためです。

Antigravity がリンクされた skill のフォルダを辿るかは、公式の文書に書かれていません（2026-10-15 確認）。入れたら一度、skill が見えるかを確かめてください。

## 入れ方

前提は Git と PowerShell です。Windows は標準の Windows PowerShell 5.1 でも動きます。macOS・Linux は PowerShell 7 を使います。

```powershell
git clone https://github.com/jinjer-ops/agent_knowledge_base.git
cd agent_knowledge_base
pwsh -File environment/install.ps1 -Check   # 何も書かずに、今の状態を見る
pwsh -File environment/install.ps1          # 入れる
```

Windows PowerShell 5.1 では `powershell -ExecutionPolicy Bypass -File environment\install.ps1` と打ちます。

| 指定 | 意味 |
| --- | --- |
| `-Check` | 書き込まずに、入っていない・古い・違うものを報告する。違いがあれば終了コード 1 |
| `-PrivateOverlay <path>` | 共有しない自分の指示ファイルを足す。Claude Code は読み込み、Codex と Antigravity は末尾に連結する。複数を渡せる |
| `-ReplaceCopies` | 既にあるコピーや、別の所へのリンクを置き換える。コピーは消さず `~/.agent-environment-backup/<日時>/` へ移す |
| `-Antigravity` | Antigravity にも入れる |

| `-GateManifest <path>` | 門に使う版を固定して入れる（下の「門の版を固定する」） |
| `-Update` | 固定の置き場を新しくする。設定のリポジトリは fast-forward だけ、道具のリポジトリは設定が指す SHA へ |
| `-EnvironmentTarget User\|Process\|None` | 一覧の `environment` を書く先。既定は `User`（利用者の環境変数。Windows だけ） |

自分で書いた `CLAUDE.md`・`AGENTS.md` が既にあるときは上書きせず、足す行を表示します。書き換えるのは、導入スクリプトが作ったファイル（先頭が `# GENERATED FILE`）だけです。

入れたら、各エージェントのセッションを開き直してください。

## 門の版を固定する

公開前の検査（`skills/git-publish`）のような「門」として使う skill は、このリポジトリの作業用の clone から入れると、その clone がそのとき載っている枝で中身が変わります。`-GateManifest` を渡すと、作業用の clone とは別の、読むだけの clone から入れます。

- 版を決めるのは、組織の設定を置くリポジトリ（以下、設定のリポジトリ）の pins ファイルです。このリポジトリのどのコミットを使うかを、40 桁の SHA で書きます。
- 設定のリポジトリは、既定の枝に fast-forward だけで付いていきます。このリポジトリは、pins の SHA に detach して取り出します。
- 固定の置き場に手を入れると、`-Check` が知らせ、`-Update` は止まります（上書きしません）。

一覧（JSON）の形は次のとおりです。URL や置き場は各自の値にします。`environment` の値には `{policy}`（設定のリポジトリの置き場）・`{tool}`（このリポジトリの固定の置き場）・`{home}` が使えます。

```json
{
  "pinned_root": "~/.agent-environment/pinned",
  "policy_repository": {"name": "org-config", "url": "https://github.com/<org>/<config-repo>.git",
                        "branch": "main", "pins_file": "config/gate-pins.json"},
  "tool_repository": {"name": "agent_knowledge_base", "url": "https://github.com/<owner>/agent_knowledge_base.git",
                      "pin_key": "agent_knowledge_base"},
  "environment": {"GIT_PUBLISH_POLICY": "{policy}/config/git-publish-policy.json",
                  "PREFLIGHT": "{home}/.claude/skills/git-publish/scripts/preflight.py"}
}
```

pins ファイルの形は `{"agent_knowledge_base": {"sha": "<40 桁>"}}` です。版を上げるときは、設定のリポジトリへの PR にします。

固定の置き場から入れると、skill を `~/.claude/skills` から直すことはできなくなります。直すときは作業用の clone で直して PR にし、マージの後に pins を上げます。

## 共有するものと、しないもの

このリポジトリには、誰に渡してもよいものだけを置きます。

| 置く（共有する） | 置かない（各自の手元に置く） |
| --- | --- |
| どのエージェントにも共通の作業合意、汎用の skill、Claude Code の汎用の subagent | 組織の資料の書き方・ブランド・人物の情報、社内のシステムの手順、権限の許可（`settings.json`）、エージェントの記憶（memory）、認証情報 |

手元の層は、`-PrivateOverlay` で渡すファイルと、各エージェントの置き場に自分で置いたもの（Claude Code なら `~/.claude/rules/` や `~/.claude/skills/`）です。導入スクリプトは、このリポジトリに無い skill には触れず、「自分の skill」として一覧に出すだけです。

## 直すとき

`-GateManifest` を使わずに入れた場合、入った先はこのリポジトリを指しているので、skill を直すと、このリポジトリの変更として現れます。共有してよい変更は PR にします（公開前の手順は [../skills/git-publish/SKILL.md](../skills/git-publish/SKILL.md)）。組織に固有の内容が混ざる変更は、共有の skill を直さず、手元の層に置きます。

- 新しい skill は `skills/<名前>/SKILL.md` に作る。`name` はフォルダ名と同じにし、`description` に起動条件を書く。書き方は [../foundation/skill-authoring/README.md](../foundation/skill-authoring/README.md)
- 常に効かせたい短い決まりは [AGENTS.md](AGENTS.md) に足す。長い手順は skill か文書にする（[../foundation/agents-md/README.md](../foundation/agents-md/README.md)）
- 確かめは、`tests` フォルダで `python -m unittest discover -s .` と、`pwsh -File environment/install.ps1 -Check`

## 各部分の根拠

| 部分 | なぜこの形か |
| --- | --- |
| AGENTS.md を正本にし、各ツールは読み込むだけにする | [../foundation/agents-md/README.md](../foundation/agents-md/README.md) |
| Claude Code の置き場の使い分け（CLAUDE.md・rules・skills・hooks） | [../foundation/claude-code/README.md](../foundation/claude-code/README.md) |
| skill の書き方と確かめ方 | [../foundation/skill-authoring/README.md](../foundation/skill-authoring/README.md) |
| 指示ファイルを小さく保つ | [../foundation/instruction-upkeep/README.md](../foundation/instruction-upkeep/README.md) |
| 運用で得た教訓（評価・分析・道具の癖・配る道具の設計） | [../knowledge/practices/](../knowledge/practices/) |
| この形にした判断と、採らなかった案 | [../knowledge/decisions/2026-10-15-environment-consolidation.md](../knowledge/decisions/2026-10-15-environment-consolidation.md) |

各ガイドの出典は、ガイドの frontmatter にある `source_ids` から、[../knowledge/sources/articles.yml](../knowledge/sources/articles.yml) と [../knowledge/reading-guide.md](../knowledge/reading-guide.md) で引けます。

## ライセンス

`environment/` と `skills/` は MIT License です（[LICENSE](LICENSE)）。
