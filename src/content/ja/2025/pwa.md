---
#See https://github.com/HTTPArchive/almanac.httparchive.org/wiki/Authors'-Guide#metadata-to-add-at-the-top-of-your-chapters
title: PWA
description: 2025年版Web AlmanacのPWAチャプターでは、サービスワーカー（使用状況と機能）、ウェブアプリマニフェスト、Fugu API、Webプッシュ通知を取り上げます。
hero_alt: Web Almanacのキャラクターがウェブページをモバイルウェブアプリに変換しているヒーロー画像。
authors: [diekus, MichaelSolati]
reviewers: [webmaxru, Schweinepriester, aarongustafson]
analysts: [onurglr]
editors: [tunetheweb]
translators: [ksakae1216]
diekus_bio: Diego GonzalezはMicrosoft Edgeブラウザのウェブプラットフォーム機能に取り組むコスタリカ出身のエンジニアです。
MichaelSolati_bio: MichaelはAmplicationのデベロッパーアドボケートで、開発者がAPIを構築するのを支援することとIPAを飲むことに注力しています。また、Web GDEでもあり、ウェブ上での魅力的なエクスペリエンスの創造とウェブの神秘的な世界に情熱を見出しています。
results: https://docs.google.com/spreadsheets/d/1mEbm1NTrqy8B4l5zY3gPgbKWxyNdWOPfVmi1pDIyMus/edit
featured_quote: PWAのコンセプトは10年前に生まれました。構想から10年経った今、この技術群の現状を誇りを持って振り返ります。
featured_stat_1: 10x
featured_stat_label_1: サービスワーカー使用率のおおよその急増倍率。
featured_stat_2: 78
featured_stat_label_2: デスクトップクライアントで無視された通知の割合（%）。
featured_stat_3: 2
featured_stat_label_3: ウェブアプリをサポートするようになった新しいエンジンの数。
doi: 10.5281/zenodo.18246631
---

## はじめに

2015年、私たちは初めて<a hreflang="en" href="https://infrequently.org/2015/06/progressive-apps-escaping-tabs-without-losing-our-soul/">プログレッシブウェブアプリケーションについて読みました</a>。レスポンシブ、接続独立性、アプリライクなインタラクション、常に最新、安全、発見可能、再エンゲージ可能、インストール可能、リンク可能という9つの属性が、当時ウェブ技術で達成できる最先端を定義していました。 _PWAのコンセプトは10年前に生まれ_ 、構想から10年経った今、この技術群の現状を誇りを持って振り返ります。

PWAのコンセプトはこの10年で大きく進化し、異なるブラウザがさまざまなバリエーションと異なる名称でサポートしています。モバイルブラウザで「ホーム画面に追加」を通じてウェブアプリへのアクセスを可能にする方法として始まったアイデアは、今や複数のプラットフォームとデバイスで存在感を示しています。これらの技術群はウェブコンテンツを基盤となるプラットフォームに直接統合し、高度なケイパビリティとよりネイティブに近いルック＆フィールを同時に実現します。ここ数年でPWAにもたらされた変化を見ていきましょう。

## PWA/ウェブアプリの変化

ここ数年、ウェブアプリにはさらなるカスタマイズ、アプリケーション動作の高度な制御、パフォーマンス向上を可能にする新機能が追加されてきました。何より、複数のエンジンでウェブアプリのサポートが進展しています！

Chromiumベースのブラウザは、最小要件が満たされるとアプリケーションのインストールを促します。かつてはマニフェストファイル、サービスワーカー、セキュアな接続を持つアプリが対象でした。しばらくの間、これがPWAインストール可能性の「3要素」でした。これが変わり、現在はマニフェストのみが必要です（HTTPS接続は引き続き必要ですが）。サービスワーカーはEdgeやChromeなどのブラウザがインストールプロンプトを表示するための要件ではなくなりました。

一方、Safariはウェブアプリのインストールプロンプトを表示しません。ただし、macOS 14では<a hreflang="en" href="https://support.apple.com/en-us/104996">Dockに追加する</a>ことで任意のウェブページをアプリとしてインストールできます。

PWAにとって大きなニュースとして、<a hreflang="en" href="https://support.mozilla.org/en-US/kb/web-apps-firefox-windows">Firefoxがバージョン143からウェブアプリをサポートするようになりました</a>！これは現在WindowsのPWAのみで利用可能で、<a hreflang="en" href="https://connect.mozilla.org/t5/discussions/how-can-firefox-create-the-best-support-for-web-apps-on-the/m-p/60561/highlight/true#M21220">「Mozilla Connectコミュニティからのトップリクエスト」</a>に応えるものです。

_ウェブ_ ベースのウェブアプリにおいて、サービスワーカーを持たないことへの懸念の一つはオフラインサポートです。サービスワーカーを使用することで、開発者はウェブアプリのUIを構成するリソースをキャッシュして優れたオフライン体験を提供できます。要件の変更（Chromium）またはデフォルト動作の変更（SafariとFirefox）により、ブラウザは接続不足からユーザーを守るデフォルトのオフライン体験を提供するようになっています。

<aside class="note">最高のオフラインUXにはサービスワーカーが依然として必要です。ウェブアプリのインストール可能性の最新情報は[MDN記事](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Guides/Making_PWAs_installable)を参照してください。</aside>

この概要を踏まえ、データに踏み込んで現在のPWAの状態を理解しましょう。可能な限り、今年のデータを[3年前のデータ](../2022/pwa)（最後にPWAチャプターが存在した時）と比較します。

## サービスワーカー

サービスワーカーは、バックグラウンド同期、オフラインサポート、プッシュ通知などの高度なケイパビリティをウェブアプリに提供するうえで引き続き不可欠な存在です。今年のデータによると、ウェブプロパティの約5分の1がサービスワーカーを使用しています。

{{ figure_markup(
  image="pwa-sw-control-ranking.png",
  caption="ランク別のサービスワーカー制御ページ。",
  description="ウェブサイトの人気度とサービスワーカー技術の使用との相関を示す棒グラフ。上位サイトでの採用率が著しく高く、上位10,000ランクではデスクトップ29.4%、モバイル27.5%と最高の実装率を示しています。サンプルサイズが広がり人気の低いサイトも含まれるにつれ、採用率は着実に低下し、全ウェブサイトを対象にすると20.0%まで下がります。全体として、デスクトッププラットフォームはすべてのランクカテゴリでモバイルよりわずかに高いサービスワーカー使用率を維持しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1868664844&format=interactive",
  sheets_gid="374256727",
  sql_file="sw_adoption_over_time_ranking.sql"
  )
}}

まず、ランク別のサービスワーカー制御ページを見ていきましょう。上位1,000ページでは、30.3%（デスクトップ）と28.9%（モバイル）がサービスワーカーによって管理されています。これは3年前のデータと比べて約20%の増加です。

全体的に、すべてのランクグループで強い増加が見られ、 _全_ PWAウェブサイトの割合は2022年の1.4%（デスクトップとモバイル）から20.5%（デスクトップ）と20.0%（モバイル）へと上昇しました。

以下では、イベント、メソッド、オブジェクト別のサービスワーカーのケイパビリティ使用データを示します。

### サービスワーカーのイベント

{{ figure_markup(
  image="pwa-sw-events.png",
  caption="もっとも使用されているサービスワーカーのイベント。",
  description="もっとも使用されているサービスワーカーのイベントを示す棒グラフ。ライフサイクルイベントがデータを支配しており、`activate`イベントはPWAサイトの96%に、`install`イベントは64%に登場しています。機能的なイベントは低めながら注目すべき採用率で、`fetch`はネットワークリクエストの傍受に12%、`push`と`notificationclick`はともに7%です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1621146621&format=interactive",
  sheets_gid="577288813",
  sql_file="sw_events.sql"
  )
}}

サービスワーカーで最も使用されているイベントは`activate`（アクティベーション）で、ほぼすべてのサービスワーカー（PWAの約96%）が使用しています。`install`イベントは約64%の使用率で2位を占めています。`install`と`activate`はともにコアライフサイクルイベントであるため、これらの数字は驚くべきものではありません。アプリケーションがロード時間を短縮するためにリソースをキャッシュし、サービスワーカーの管理を行っていることを示唆しています。

`fetch`、`notificationclick`、`push`などの高度なイベントの使用はかなり低く、これらがネットワークリクエストの傍受、デフォルトのオフラインUXのバイパス、プッシュサービスからの通知配信といったより高度なシナリオに該当するケイパビリティであることが原因と考えられます。

### サービスワーカーのメソッド

{{ figure_markup(
  image="pwa-sw-methods.png",
  caption="もっとも使用されているサービスワーカーのメソッド。",
  description="サービスワーカーメソッドの人気を示す棒グラフで、`skipWaiting`はデスクトップPWAページの約68%、モバイルPWAページの63%で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=628466183&format=interactive",
  sheets_gid="1005909719",
  sql_file="sw_methods.sql"
  )
}}

最も使用されているサービスワーカーメソッドを見ると、`skipWaiting()`が顕著な使用率を示しており、デスクトップで68%、モバイルで63%の利用率です。ブラウザはサービスワーカーを即座にアクティブにして古いものと置き換えます。これは開発者がユーザーが古いアセットのままになることを防ぎたいということを意味しています。ダッシュボードやメッセージングアプリのような頻繁なアップデートが必要なアプリケーションに有益で、ユーザーがアプリケーションの最新バージョンをすぐに入手できるよう助けます。

### サービスワーカーのオブジェクト

{{ figure_markup(
  image="pwa-sw-objects.png",
  caption="もっとも使用されているサービスワーカーのオブジェクト。",
  description="デスクトップとモバイルプラットフォームにおけるさまざまなサービスワーカーオブジェクトの採用率を示す棒グラフ。`clients.claim`が最も広く使用されているオブジェクトで、デスクトップPWAページの約67%、モバイルPWAページの63%に登場しています。`caches.open`や`caches.delete`なども一般的なオブジェクトで、デスクトップよりモバイルデバイスで顕著に普及しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1490213107&format=interactive",
  sheets_gid="928442900",
  sql_file="sw_objects.sql"
  )
}}

最も使用されているサービスワーカーオブジェクトは`clients`、`caches`、`cache`です。`clients`については、`clients.claim()`を呼び出してサービスワーカーがすべての開いているページを制御する方法として期待通りの結果です。`caches`については管理メソッドがトップに登場しており、開発者がアセットを最新の状態に保って高速なページロードを実現するために使用するメソッドであることを考えると、これも驚くべきことではありません。

先に示唆したように、これらの主要なメソッドは`claim`、`open`/`delete`/`keys`/`match`、`add`に対応しています。

### 登録プロパティ

{{ figure_markup(
  image="pwa-sw-reg-properties.png",
  caption="もっとも登録されているサービスワーカープロパティ。",
  description="デスクトップとモバイルのプログレッシブウェブアプリにおけるさまざまなサービスワーカー登録機能の採用を示す棒グラフ。`pushManager.subscribe`と`pushManager.getSubscription`が最も活用されているプロパティで、それぞれ両プラットフォームのPWAウェブサイトの約7%に登場しています。対照的に、`sync.register`や`navigationPreload.enable`などの高度な同期・パフォーマンスプロパティは実装率がはるかに低く、1〜2%程度にとどまっています。全体として、プッシュ通知ケイパビリティはバックグラウンド同期やナビゲーションプリロード機能よりPWAエコシステムで大幅に一般的であることを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=304535758&format=interactive",
  sheets_gid="1703056951",
  sql_file="sw_registration_properties.sql"
  )
}}

サービスワーカーの機能をさらに掘り下げると、データはPWAが使用している高度なケイパビリティに光を当てています。デスクトップとモバイル全体でサービスワーカーを使用しているすべてのPWAのうち、約7%がpushManagerに登録し、2%がsyncに登録し、2%がnavigationPreloadに登録しています。

## ウェブアプリマニフェスト

ウェブアプリマニフェストは今や、これまで以上にウェブアプリの最も重要な部分です。ルック＆フィールを定義し、インストール後に利用可能な高度なケイパビリティを有効にし、ウェブアプリケーション全体を識別する不可欠な要素になりつつあります。ただし、有効に機能するためにはマニフェストファイルが正しく形成されている必要があります。

{{ figure_markup(
  caption="デスクトップで解析可能なモバイルマニフェストファイルの割合。",
  content="94.9%",
  classes="big-number",
  sheets_gid="1641154337",
  sql_file="manifests_not_json_parsable.sql"
)
}}

今年はデスクトップサイトの94.5%、モバイルサイトの94.9%が解析可能です。[前回のデータセットから変化はなく](../en/2022/pwa#fig-9)、前回同様、マニフェストファイルが解析可能であることは機能の完全性や最低限の利用可能性を意味するわけではありません。マニフェストの多くの値は重要に見えても、適切なフォールバックが用意されています。

これらの解析可能なマニフェストから、個々のフィールドを見ていきましょう。これにより開発者がマニフェストファイルをどのように使用しているか、また2022年以降に変化があったかどうかを理解できます。

### マニフェストプロパティ

{{ figure_markup(
  image="pwa-manifest-properties.png",
  caption="もっとも使用されているマニフェストプロパティ。",
  description="デスクトップとモバイルの両プラットフォームにおけるウェブアプリマニフェストファイル内で最も頻繁に使用されるフィールドを示す棒グラフ。コアの識別と視覚的プロパティが結果を支配しており、`name`と`icons`はマニフェストの90%以上に登場し、`short_name`、`display`、`theme_color`は約80%でそれに続いています。モバイルPWAはすべてのリストされたプロパティでデスクトップよりわずかに高い採用率を示しており、特に`start_url`や`scope`などの機能的フィールドで顕著です。全体として、データは基本的なPWA識別の高い標準化レベルを示す一方、`description`や`orientation`などのより説明的または制限的なプロパティは依然として大幅に少ないことを示しています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1634923260&format=interactive",
  sheets_gid="2030078867",
  sql_file="top_manifest_properties.sql"
  )
}}

最もよく使用されているPWAマニフェストプロパティは`name`、`icons`、`short_name`、`display`、`background_color`です。上位4つの最も使用されているプロパティは[2022年と同じ](../2022/pwa#マニフェストのプロパティ)で、順序にわずかな変化があります。

Web Almanacがスキャンしたマニフェストファイル全体で個々のメンバーがどのような評価を受けているかを見ていきましょう。特に注記がない限り、値はモバイルとデスクトップで非常に似ているため、両方を合わせて言及します。

<figure>
  <table>
    <thead>
      <tr>
        <th>マニフェストフィールド</th>
        <th>デスクトップ</th>
        <th>モバイル</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>`name`</td>
        <td class="numeric">92%</td>
        <td class="numeric">93%</td>
      </tr>
      <tr>
        <td>`icons`</td>
        <td class="numeric">90%</td>
        <td class="numeric">91%</td>
      </tr>
      <tr>
        <td>`short_name`</td>
        <td class="numeric">82%</td>
        <td class="numeric">85%</td>
      </tr>
      <tr>
        <td>`display`</td>
        <td class="numeric">82%</td>
        <td class="numeric">85%</td>
      </tr>
      <tr>
        <td>`background_color`</td>
        <td class="numeric">80%</td>
        <td class="numeric">82%</td>
      </tr>
      <tr>
        <td>`theme_color`</td>
        <td class="numeric">80%</td>
        <td class="numeric">82%</td>
      </tr>
      <tr>
        <td>`start_url`</td>
        <td class="numeric">61%</td>
        <td class="numeric">68%</td>
      </tr>
      <tr>
        <td>`scope`</td>
        <td class="numeric">31%</td>
        <td class="numeric">35%</td>
      </tr>
      <tr>
        <td>`description`</td>
        <td class="numeric">25%</td>
        <td class="numeric">27%</td>
      </tr>
      <tr>
        <td>`orientation`</td>
        <td class="numeric">17%</td>
        <td class="numeric">21%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="マニフェストプロパティ。", sheets_gid="2030078867", sql_file="top_manifest_properties.sql") }}</figcaption>
</figure>

`categories`メンバーを指定しているマニフェストでは、トップカテゴリは以下の通りです：

{{ figure_markup(
  image="pwa-manifest-categories.png",
  caption="もっとも使用されているマニフェストカテゴリ値。",
  description="デスクトップとモバイルプラットフォームで特定のアプリケーションカテゴリを指定しているプログレッシブウェブアプリマニフェストの割合を示す棒グラフ。`shopping`と`business`が圧倒的に支配的なカテゴリで、それぞれ両クライアントタイプのマニフェストの約2.4〜2.5%で表されています。対照的に、`education`、`entertainment`、`games`、`productivity`を含む他のすべてのリストされたカテゴリは採用率が大幅に低く、それぞれマニフェストの0.3%未満にしか登場していません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=991806108&format=interactive",
  sheets_gid="848602015",
  sql_file="top_manifest_categories.sql"
  )
}}

[マニフェストキー`categories`](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Manifest/Reference/categories)は多くのPWAで使用されていませんが、これらの結果はウェブアプリがより人気のあるトップの縦型市場を示唆しています。

### マニフェストの`display`値

displayメンバーはウェブアプリの優先表示モードを指定するために使用されます。ブラウザによってこれらの値の解釈は異なりますが、全体的にブラウザのUXをどれだけ表示/非表示にするかをUAに示します。

{{ figure_markup(
  image="pwa-manifest-displays.png",
  caption="マニフェストで最も使用されているdisplay値（standalone）。",
  description="デスクトップとモバイルプラットフォームのウェブアプリマニフェストで定義されたdisplayモードの分布を示す棒グラフ。`standalone`値は圧倒的に支配的な選択肢で、モバイルPWAマニフェストの78%で使用され、デスクトップでも同様の高い割合でアプリライクなエクスペリエンスを提供しています。`minimal-ui`、`fullscreen`、`browser`などの他の標準化されたdisplay値は採用率が非常に低く、それぞれ合計の3%以下にとどまっています。また、マニフェストの注目すべき割合（約15%）はdisplay値が設定されていません。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=364018981&format=interactive",
  sheets_gid="1096790994",
  sql_file="top_manifest_display_values.sql"
  )
}}

ほとんどのウェブアプリ（78%）はdisplayメンバーに`standalone`値を選択しています。ドキュメントによると、[`standalone`](https://developer.mozilla.org/docs/Web/Progressive_web_apps/Manifest/Reference/display#standalone)は「スタンドアロンのネイティブアプリのようなルック＆フィールでアプリを開く」とされています。開発者がアプリをよりネイティブに見せたい、ブラウザのクロームや他のUXを取り除きたいというのがウェブアプリの一般的な意図であるため、これは驚くべきことではありません。最終的にはこれは実装によって異なり、例えばChromiumブラウザでは`...`メニューが表示され、FirefoxではインストールされたアプリにもURLバーなどのブラウザUIが残ります。

### マニフェストの`icons`サイズ値

{{ figure_markup(
  image="pwa-manifest-icons.png",
  caption="マニフェストで最も使用されているアイコンサイズ値。",
  description="デスクトップとモバイルプラットフォームのウェブアプリマニフェストで指定される最も一般的なアイコンサイズを示す棒グラフ。192x192と512x512が圧倒的に支配的なサイズで、それぞれマニフェストの約85%と75%に登場しています。144x144や96x96などの他のリストされたサイズは採用率が大幅に低く、それぞれプログレッシブウェブアプリの25%未満で使用されています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1792269416&format=interactive",
  sheets_gid="1340146193",
  sql_file="top_manifest_icon_sizes.sql"
  )
}}

トップサイズは192x192と512x512です。

### マニフェストの`orientation`値

{{ figure_markup(
  image="pwa-manifest-orientation.png",
  caption="マニフェストで最も使用されているorientation値。",
  description="デスクトップとモバイルプラットフォームのデフォルト画面向きを指定しているプログレッシブウェブアプリマニフェストの割合を示す棒グラフ。マニフェストの圧倒的多数（約80%）はorientationプロパティが設定されていないことが明らかになっています。設定している少数派の中では、`portrait`が約12%で最も一般的な選択肢で、モバイルアプリケーションはデスクトップバージョンよりも高い傾向でこの向きをロックしています。`any`、`natural`、`portrait-primary`などの特定のorientation値は採用率が非常に低く、それぞれマニフェストの5%未満にしか登場せず、`landscape`は0.1%と最も少ない利用率です。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=165636531&format=interactive",
  sheets_gid="701832198",
  sql_file="top_manifest_orientations.sql"
  )
}}

当然ながら、PWAの約79.2%はorientationを設定していません。レスポンシブデザインとモダンな開発により、アプリの向きを定義する必要性が低くなっていますが、portraitは約12.2%で2位を占めています。

## サービスワーカーとマニフェストの使用状況

最も使用されているサービスワーカーとマニフェストの機能に関する最新データを見てきました。2025年では、サイトの約5分の1がサービスワーカーを使用し、約10分の1がマニフェストを使用していることがわかります。

{{ figure_markup(
  image="pwa-manifest-sw-manifest-usage.png",
  caption="PWAサービスワーカーとマニフェストファイルの使用状況。",
  description="デスクトップとモバイルウェブサイトにおける主要なプログレッシブウェブアプリ技術の採用を示す棒グラフ。サービスワーカーはウェブアプリマニフェストよりも大幅に一般的で、前者は18.9%のサイトが実装し、後者は両プラットフォームで約9%が実装しています。全体的な採用率を見ると、ウェブサイトの24.5%が少なくとも1つのPWA機能を使用していますが、両方を同時に実装しているのはデスクトップで3.3%、モバイルで3.5%という少数にとどまっています。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=588231319&format=interactive",
  sheets_gid="1678838470",
  sql_file="manifests_and_service_workers.sql"
  )
}}

全体として、[2022年版Web Almanac](../2022/pwa#fig-10)のデータと比べると大きな変化があります。サービスワーカーの使用率は約1.7%から19.2%へと大幅に跳ね上がりました。これは採用率の約10倍増加です。マニフェストの使用率はわずかに高いものの、3年前とほぼ同じ水準に留まっています。

これをさらに掘り下げると、Google Tag Managerがサービスワーカーを有効にしたことが成長の大きな要因となっているようです。

## PWAとFugu API

2025年のPWAで使用されている高度なケイパビリティトップ10は以下の通りです。

<figure>
  <table>
    <thead>
      <tr>
        <th>ケイパビリティ</th>
        <th>モバイル</th>
        <th>デスクトップ</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Compression Streams</td>
        <td>18.4%</td>
        <td>20.9%</td>
      </tr>
      <tr>
        <td>Async Clipboard</td>
        <td>17.9%</td>
        <td>19.1%</td>
      </tr>
      <tr>
        <td>Device Memory</td>
        <td>10.7%</td>
        <td>10.6%</td>
      </tr>
      <tr>
        <td>Web Share</td>
        <td>9.6%</td>
        <td>9.8%</td>
      </tr>
      <tr>
        <td>Media Session</td>
        <td>6.8%</td>
        <td>7.8%</td>
      </tr>
      <tr>
        <td>Add to Home Screen</td>
        <td>6.8%</td>
        <td>7.3%</td>
      </tr>
      <tr>
        <td>Media Capabilities</td>
        <td>6.3%</td>
        <td>7.3%</td>
      </tr>
      <tr>
        <td>Cache Storage</td>
        <td>9.00%</td>
        <td>3.00%</td>
      </tr>
      <tr>
        <td>Service Worker</td>
        <td>3.7%</td>
        <td>3.3%</td>
      </tr>
      <tr>
        <td>Push</td>
        <td>1.7%</td>
        <td>1.6%</td>
      </tr>
    </tbody>
  </table>
  <figcaption>{{ figure_link(caption="PWAで使用されている高度なケイパビリティトップ10。", sheets_gid="220067822", sql_file="fugu.sql") }}</figcaption>
</figure>

2025年におけるこれらのAPIの採用状況をより深く掘り下げるための[ケイパビリティ](./capabilities)専用チャプターがあります。

## 通知とPWA

通知はアプリにとって理にかなった機能で、ユーザーがアプリケーションに再エンゲージできるようにします。これは物議を醸すケイパビリティで、ユーザーに承諾させようとする悪いUXやダークパターンが数多く存在します。データによると、デスクトップとモバイルの両方で、ユーザーが最も一般的にとる行動はこれらのリクエストを無視することです。

{{ figure_markup(
  image="pwa-manifest-notification-rates.png",
  caption="PWA通知の承諾率。",
  description="デスクトップユーザーが78%という割合で圧倒的に通知を無視しており、承諾するのはわずか6%であることを示す積み上げ棒グラフ。モバイルユーザーはプロンプトへの関与度が高く、16%という大幅に高い承諾率を示していますが、デスクトップと比べてリクエストを積極的に拒否または却下する可能性もはるかに高いです。",
  chart_url="https://docs.google.com/spreadsheets/d/e/2PACX-1vSptnOeENss_fXr9rsRy03DDysKKEz2BbZH52DQGEg745UaZVtTHKoy5qHiY8MHb-VAaEUlZCCcXX81/pubchart?oid=1327754740&format=interactive",
  sheets_gid="487663654",
  sql_file="pwa_notification_acceptance_rates.sql"
  )
}}

デスクトップの通知承諾は圧倒的に無視されており、78%が無視され、モバイルではわずかに低いものの依然として高い48%が無視されます。これはユーザーが日常的に経験している通知疲れを考えると驚くべきことではありません。

## 結論

PWAが誕生して10年が経ちました。技術とケイパビリティが成熟するにつれてランドスケープは少し変化し、現在はすべての主要ブラウザ（Edge、Chrome、Firefox、Safari）がある程度ウェブアプリをサポートしています。ウェブアプリは引き続き成長を示しており、クロールされたウェブサイトの約4分の1がサービスワーカーまたはマニフェストファイルを持っています。

新機能のペースが遅くなったと感じているなら、それは正しいです。数年前と比べると今日ローンチされるウェブアプリ機能は少なくなっています。これはプラットフォームがケイパビリティの面で、ウェブ技術スタックを使ってさまざまなユースケースを作成できる成熟度に達したという事実と関係していると思います。一方で、クロスエンジンのケイパビリティサポートと密接に結びついた採用の問題もあります。一部の主要ブラウザがいくつかの高度な機能をサポートし始めたのはごく最近のことで、ウェブアプリを取得またはインストールする可能性についてはなおさらです。

実装者のサポートが遅いためと思われる高度なケイパビリティの控えめな使用が続く中、Web Shareなどの古いケイパビリティも登場し始め、さらには`window-controls-overlay`のようなよりニッチなUX機能もデータに現れ始めています。ゆっくりと着実にこれらの機能はコモディティ化されつつあります。

PWAチャプターがあった最後のWeb Almanacを振り返ると、以下のことに気づきます：

- 2つの追加ブラウザ（SafariとFirefox）がウェブアプリをサポートするようになりました。
- サービスワーカー制御ページは2022年からすべてのPWAウェブサイトで約20%増加しました。
- 3年前と比べてサービスワーカーイベントの多様性が少なくなっています。`notificationclick`、`push`、`fetch`を使用しているPWAの割合が減少しています。
- `pushManager`登録の割合は2022年から低下しており、これは通知のプッシュよりもパフォーマンスに焦点を当てたサービスワーカーの使用（下記注記参照）が増加しているためと考えられます。
- 2022年から2025年の間にPWA技術の使用合計（デスクトップ1,250万、モバイル1,550万）は約2倍になりました（2022年はデスクトップ540万、モバイル790万）。サービスワーカーの使用率は約10倍に急増し、マニフェストは8〜9%の使用率とほぼ同水準を維持しています。
- 通知プロンプトを無視することが依然としてユーザーにとって最も一般的な行動です。

<aside class="note">これらはパーセンテージであるため、「呼び出しの多様性の低下」や「登録の減少」は特に拒否や不使用のサインではなく、コア技術の使用が _増加_ した結果であることに注意する価値があります。例えば、PWA登録プロパティにおける`pushManager.getSubscription`の合計は、過去3年間で52,000ページから約300万ページ未満へと増加しています。</aside>

2025年版Web AlmanacのPWAチャプターを締めくくるにあたり、インストール機能をプラットフォームに直接組み込むことでウェブアプリの配布を民主化する方法を模索する取り組みと合意が進行中です。次の10年間でPWA技術がレスポンシブデザインと同じ運命をたどり、コモディティ化されて、アプリケーションライフサイクル管理に優れたUXを持つウェブアプリが、ウェブアプリの可能性を再定義する新しいケイパビリティとともに標準になることを願っています。ウェブアプリの次の10年に乾杯！
