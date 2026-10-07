---
id: FOUNDATION-HEAVY-READ-DELEGATION
title: Deciding whether to delegate heavy reads
type: foundation-guide
status: draft
created_at: 2026-10-06
updated_at: 2026-10-07
owners: [knowledge-stewards]
source_ids: [ART-023, ART-024, ART-037, REF-017, REF-020, REF-023, REF-024, REF-025, REF-026, REF-030, REF-044, REF-045, REF-086]
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

## 要約だけ返す構成の、既知の失敗様式

**短くしたのに高くなることがあります。** 別の提供元の実測では、ツールの応答を圧縮したところ、
1 回の応答は短くなったのに平均ではタスクの消費が増え、時間も延びました。要約で落ちた詳細を
取り戻すためにモデルが読み直しや再実行を行い、ターンが増え、増えた文脈が以降の要求に持ち回られた
からです（`REF-030`）。

ここで扱う委譲は、まさに「要点だけ返す」構成です。したがって次の 2 つを条件にします。

- **効果は 1 回あたりではなくタスク単位で測る。** 1 回の応答が短くなったことは、安くなった証拠に
  なりません。
- **復元の経路を残す。** 要約の元を必要なときに開けるようにしておきます。圧縮の対象は繰り返しの
  ノイズに限り、構造のある出力はそのまま残します（`REF-030`）。

判定の手順は [../cost-change-evaluation/](../cost-change-evaluation/) にまとめてあります。

### 費用の前に、内容として何が落ちるか

前の項は費用の話でした。要約には、費用とは別に**内容の側の失敗様式**があり、こちらは測られています。
複数の資料をまとめさせた出力を 5 つのモデルで分類・計測した査読済みの研究（`REF-044`）から、
委譲の設計に効く点を 2 つ採ります。

- **誤りの型には「正しいが、新しい情報を足さない」が含まれる。** 事実として誤っていないのに
  価値が無い、という失敗は、正しさだけを見る検査では捕まりません。返ってきた要約が
  「もっともらしいが、元を開いても得るものがない」形になっていないかは、別に見ます。
- **まとめる資料を増やしても誤り率はほとんど変わらない（±5%）。落ちるのは再現率のほうです。**
  つまり広く読ませるほど「間違いが増える」のではなく、**「触れられないものが増える」**。
  委譲で広い範囲を安く読ませた場合、警戒すべきは誤りより**取りこぼし**です。

ここから、委譲の形に対する条件が 1 つ増えます。

> **要約を束ねて、さらに要約させる段を作らない。** 二段目は一段目の共通部分だけを残すため、
> 個別の資料に固有の情報が落ちます。

圧縮が下流の判断を変えうることは、別の査読済みの報告（`REF-045`）でも扱われています。流暢で
事実としては妥当な圧縮であっても、**証拠が文脈的な条件から切り離される**ことで、元の資料が支持して
いた判断とは別の判断になりうる、というものです。同じ報告は、エージェントの構成では**この損失が
途中の段で繰り返され、増幅しうる**と指摘しています。これは測定された値ではなく著者らの指摘として
読みますが、段を重ねないという条件を支える向きにあります。

実務上の対処は、要約の形を指定することです。**固有名詞・数値・出典の位置は要約に残させ、
判断は元に戻ってから行う**ようにします。これは上の「復元の経路を残す」と同じ要求を、
返させる側から書いたものです。

## 逃がせないもの

提供元の著者自身が挙げている限界です（`REF-023`）。

- **読んで直す作業は委譲できない。** 要約には信頼できる行番号が無いため、分析結果をそのまま編集に
  つなげられない。
- **推論は落ちる。** 著者の試行では、安いモデルは表面的なパターンは見つけたが並行処理の安全性に関わる
  不具合を見落とし、主モデルは即座に見つけている。デバッグ・設計判断・安全性に関わるコードは、
  意図的に委譲の対象から外されている。
- **小さい読み取りは逆効果。** 往復の手間が削減分を上回る。

### 逃がす対象が「判断」のとき

上の 3 つは読み取りを前提にしています。**判断そのもの（レビュー、安全性の評価）を安いモデルへ
逃がす構成**も実際に行われていますが（`ART-037`）、条件が 2 つ増えます。

- **出力を機械で読める厳密な形式に縛ると、判断の質が落ちます。** 読み取りの委譲なら整形は害に
  なりませんが、判断が成果である仕事では形式の制約が推論能力を下げることが測られています。
- **「指摘なし」が、見ていないことと区別できません。** 入力が文脈長を超えると黙って落ちる経路が
  あり、切り詰められた対象を見たモデルは「問題なし」を返します。合格の出力を使うなら、
  送った量と処理された量を突き合わせ、入りきらなければ止めます。

そして**費用の側**。同じ目的に対して、モデルの段を落とすのではなく、対象の選別と道具を
決定論的に絞るほうが、品質と費用の両方で良い結果が報告されています（`REF-086`、査読前）。
上の「分母を先に見る」と同じで、**何を読ませたかのほうが単価より効く**という形です。

条件と根拠は [../review-design/](../review-design/) にまとめてあります。

## 限界

- `ART-024` は単一の環境の 14 日分の記録で、査読のある比較ではありません。採るのは方向（既定の閾値を
  そのまま使わない、分母を確かめる）だけで、数値は自分の環境で測り直します。
- `REF-023` は提供元自身による報告で、比較の条件も提供元の構成に沿っています。
- ここで測るのは読み取りだけです。文脈の再送や出力の割合は別に見る必要があります（`REF-017`）。
- 送信された入口記事（`ART-023`）は配信ページで、内容は一次情報の紹介です。数値や限界はすべて一次情報
  側で確認しています。
- `REF-044` は 2024 年世代の 5 モデルを、ニュースと会話の資料で評価したものです。コードやログを
  読ませた場合の割合は測られていません。採るのは誤りの型と、誤り率ではなく再現率が落ちるという
  向きだけです。
- `REF-045` は金融の資料を対象にした報告で、段を重ねたときの増幅は測定値ではなく著者らの指摘です。
  この環境では、どちらも再現していません。
- `ART-037` は実測を伴わない個人の構成の記録で、機材にも依存します。採ったのは「判断を逃がす場合が
  ある」という場面の提示だけです。
- `REF-086` は査読前で、指標も比較の設定も提案側が選んだものです。採ったのは梃子の位置だけで、
  倍率や削減率は移していません。
