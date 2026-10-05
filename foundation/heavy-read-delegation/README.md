---
id: FOUNDATION-HEAVY-READ-DELEGATION
title: Deciding whether to delegate heavy reads
type: foundation-guide
status: draft
created_at: 2026-10-06
updated_at: 2026-10-06
owners: [knowledge-stewards]
source_ids: [ART-023, ART-024, REF-017, REF-020, REF-023, REF-024, REF-025, REF-026]
tags: [context, cost, delegation, hooks, subagents, claude-code]
---

# 重い読み取りを別のモデルへ逃がす前に

**この手引きは未検証です。** 下の測り方はこの環境で一度も実行していません。実行ファイルとしては置いて
いないので、使うなら自分のところへ写し、「確かめる手順」を通してから使います。状態は `experiment` で、
特定の構成の導入を勧めるものではありません。

## 何の問題を扱うか

[instruction-upkeep/](../instruction-upkeep/) と [claude-code/hooks/always-on-budget/](../claude-code/hooks/always-on-budget/)
が扱うのは**常時載るもの**です。ここで扱うのは別の層、**1 回の作業のたびに入ってくる大きい読み取り**
（大きなファイルの中身、コマンドの出力）です。起動条件も違います。前者は指示が膨らんできたとき、
後者は読み取りが費用や文脈を押し上げていると感じたときです。

報告されている手法は単純です。大きい読み取りと予測可能なコード生成を安いモデルに回し、要約または
生成物だけを戻す。守らせるために、**実行前のイベントで閾値を超える読み取りを拒否**し、委譲の手順へ
誘導する（`REF-023`、`REF-024`）。提供元は Java のモノレポで、大量読み取りの場面で平均約 90% の削減を
報告しています。

## まずやることは、真似ではなく測定

**公開された閾値をそのまま持ち込まない。** 同じ仕組みを別の環境の記録で測り直した報告（`ART-024`）は、
14 日分・1,099 セッション・Read 1,446 件を集計し、次の値を出しています。

| 閾値 | 逃がせる読み取りバイトの割合 |
| --- | --- |
| 100 行 | 84.6% |
| 350 行 | 14.0% |
| 1,000 行 | 0.5% |

読み取り結果の行数の中央値は 158 行でした。既定の 350 行は、この環境では読み取りの大半を素通りさせます。
さらに同じ集計で、**読み取りは入力トラフィック全体の 0.02%**（約 2.7M に対し約 11.4B）にすぎず、
支配的なのは文脈の再送でした。

ここから 2 つ。

1. **「90%」は場面の中の率であって、セッション全体の費用ではない。** 分母を取り違えると、効果の
   ほとんど無い仕組みを入れることになります。
2. **閾値は自分の分布から決める。** 中央値の近くに閾値を置くかどうかで、効く範囲が数倍変わります。

## 測り方（charter）

- **用途**: 読み取りの委譲や閾値による遮断を入れるかどうかを、推測ではなく自分の記録で決める。
- **入力**: 自分の環境に残っているセッションの記録ファイル（JSON Lines）。中身は読み取りの**大きさ**
  だけを使い、本文は集計しない。
- **安全境界**: 集計は手元で行い、ファイルの中身・パス・業務データを外へ出さない。出力は分布の数値だけ。
- **検証方法**: 下の参考実装を、まず 1 ファイルだけに対して動かし、拾えた件数が目で数えた件数と合うかを
  確認する。記録ファイルの形式は公開された契約ではないので、合わなければ拾い方を直す。製品側の
  context 表示が正本です（`REF-017`）。
- **終了条件**: 閾値ごとの割合と、読み取りが全体に占める割合が出たら終わり。割合が小さければ、
  **何も入れない**のが結論になる。

## 参考実装（未検証）

```python
#!/usr/bin/env python3
"""Summarise how large this environment's file reads actually are.

Reads local session transcripts (JSON Lines), pairs Read tool calls with their
results, and prints only size statistics -- never file content. Standard
library only. The transcript layout is not a published contract, so verify the
counts against a single file before trusting the aggregate.

Usage: python measure_reads.py <transcript-dir> [threshold ...]
"""

import json
import sys
from pathlib import Path

DEFAULT_THRESHOLDS = (100, 200, 350, 1000)


def walk(node):
    """Yield every dict nested anywhere inside node."""
    if isinstance(node, dict):
        yield node
        for value in node.values():
            yield from walk(value)
    elif isinstance(node, list):
        for item in node:
            yield from walk(item)


def collect(directory):
    """Return [(lines, bytes), ...] for Read results found in the transcripts."""
    reads, results = {}, {}
    for path in sorted(Path(directory).rglob("*.jsonl")):
        for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
            try:
                record = json.loads(line)
            except ValueError:
                continue
            for block in walk(record):
                kind, call_id = block.get("type"), block.get("tool_use_id") or block.get("id")
                if not call_id:
                    continue
                if kind == "tool_use" and block.get("name") == "Read":
                    reads[call_id] = True
                elif kind == "tool_result":
                    text = block.get("content")
                    if not isinstance(text, str):
                        text = "".join(
                            part.get("text", "")
                            for part in walk(text)
                            if part.get("type") == "text"
                        )
                    results[call_id] = text
    return [
        (len(text.splitlines()), len(text.encode("utf-8")))
        for call_id, text in results.items()
        if call_id in reads
    ]


def main(argv):
    if len(argv) < 2:
        print(__doc__.strip().splitlines()[-1])
        return 2
    thresholds = [int(a) for a in argv[2:]] or list(DEFAULT_THRESHOLDS)
    sizes = collect(argv[1])
    if not sizes:
        print("no paired Read results found -- check the transcript layout first")
        return 1

    sizes.sort()
    total_bytes = sum(size for _, size in sizes)
    median = sizes[len(sizes) // 2][0]
    print("reads: %d, median lines: %d, total bytes: %s"
          % (len(sizes), median, format(total_bytes, ",")))
    for threshold in sorted(thresholds):
        over = sum(size for lines, size in sizes if lines >= threshold)
        print("  >= %5d lines: %5.1f%% of read bytes" % (threshold, 100.0 * over / total_bytes))
    print("read bytes are not the whole bill; compare them with the session's own "
          "context breakdown before changing anything")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
```

## 逃がすと決めたときの選択肢

| 手段 | 何が要るか | 注意 |
| --- | --- | --- |
| 製品に内蔵の下位エージェント（`REF-026`） | 追加の基盤も鍵も不要。宣言でモデルを個別に指定できる | 独自の context で動き、親へ戻るのは要約だけ。委譲の判断は呼ぶ側に残る |
| 外部の実行基盤へ回す（`REF-023`、`REF-024`） | 認証、モード定義、`jq` などの前提 | 1 往復あたり 10〜30 秒の遅延。単発の実行に時間上限がある |
| 実行前のイベントで閾値超えを拒否（`REF-020`） | hook の設定 | 指示と違い実際に止まる。止めた先の代替手順を必ず示す |

**公式の仕様では、下位エージェントは自分の context で動き、親の会話へ戻るのは結果の要約だけ**です
（`REF-026`）。つまり「大きい読み取りを別の文脈でやらせて要約だけ受け取る」という中心の仕組みは、
外部の基盤を入れなくても手元にあります。外部基盤を選ぶ理由は、分離そのものではなく、モデルの単価や
社内の実行環境の都合に限られます。

**既製の hook を入れるときは、出力形式が今の版で受け付けられるかを先に確かめる。** 上の仕組みの配布物でも、
古い形式の最上位フィールドを出していたために現行版に拒否され、**毎回エラーになったまま誘導が働かなく
なっていた**という報告があります（`REF-025`、2026-09-25 報告、対応予定なしとして閉じられている）。
拒否と理由の渡し方は公式の hook 仕様が正本です（`REF-020`）。黙って効かなくなる種類の故障なので、
入れた直後に「意図した場面で実際に止まるか」を 1 回確かめます。

## 逃がせないもの

提供元の著者自身が挙げている限界です（`REF-023`）。

- **読んで直す作業は委譲できない。** 要約には信頼できる行番号が無いため、分析結果をそのまま編集に
  つなげられない。
- **推論は落ちる。** 著者の試行では、安いモデルは表面的なパターンは見つけたが並行処理の安全性に関わる
  不具合を見落とし、主モデルは即座に見つけている。デバッグ・設計判断・安全性に関わるコードは、
  意図的に委譲の対象から外されている。
- **小さい読み取りは逆効果。** 往復の手間が削減分を上回る。

## 限界

- `ART-024` は単一の環境の 14 日分の記録で、査読のある比較ではありません。採るのは方向（既定の閾値を
  そのまま使わない、分母を確かめる）だけで、数値は自分の環境で測り直します。
- `REF-023` は提供元自身による報告で、比較の条件も提供元の構成に沿っています。
- ここで測るのは読み取りだけです。文脈の再送や出力の割合は別に見る必要があります（`REF-017`）。
- 送信された入口記事（`ART-023`）は配信ページで、内容は一次情報の紹介です。数値や限界はすべて一次情報
  側で確認しています。
