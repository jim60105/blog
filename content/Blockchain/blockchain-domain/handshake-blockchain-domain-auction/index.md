+++
title = "Handshake domain 區塊鏈網域 —— 購買HNS、網域競標"
description = "在前篇我比較了三種不同的區塊鏈網域專案，各位對它們有了基本認識。這篇我將詳細聊聊Handshake，如何購買HNS幣、如何競標。"
date = 2022-01-15T07:18:00.097Z
updated = 2023-11-06T23:05:21.890Z
draft = false
aliases = [ "/2022/01/handshake-blockchain-domain-auction.html" ]

[taxonomies]
tags = [ "區塊鏈", "Blockchain Domain" ]

[extra]
card = "preview.png"
iscn = "iscn://likecoin-chain/q70w15kLnLQmvfUdXjgNgdNQpV2H2c6t1_7GJhv0LBA/11"

  [extra.comments]
  id = "109433206136042137"
+++
![preview](preview.png)

> 前篇\
> [區塊鏈網域簡介 —— Handshake 、 Unstoppable Domains 、 Ethereum Name Service](/Blockchain/blockchain-domain/blockchain-domains-handshake-unstoppable-domains-ethereum-name-service)

## 前言

在前篇我比較了三種不同的區塊鏈網域專案，各位對它們有了基本認識。這篇我將詳細聊聊 Handshake，如何購買 HNS 幣、如何競標。

不過在開始前，一定有人想知道我得標這 20 個 Handshake 網域花了多少錢?

我在 2021/7/9 買了 200 HNS，沒有其它入金，現在錢包裡剩餘 171 HNS。換成台幣的話，因為 HNS 升值，賺了等值 NT 129 元。[在 Coinbase 上可以查詢 HNS 的歷史價格](https://www.coinbase.com/price/handshake)。

> 2022/11/28 更新: HNS 跌到爆，一顆剩 <span class="success">NT0.6 元</span>🤣\
> 這是好事，你現在可以用很便宜的價格買到一大堆 HNS！\
> **區塊鏈專案不會因為價格下跌而失敗，反而會因為價格高昂無人使用而死去**\
> 請放心的買下你需要的數量，我們購買 HNS 不是為了投資，而是為了競標網域

## HNS 的交易所 {#hns-exchange}

* Namebase: <https://www.namebase.io/pro>
* Gate.io: <https://www.gate.io/tw/trade/HNS%5FUSDT>
* Bittrex: <https://global.bittrex.com/Market/Index?MarketName=USDT-HNS>
* CoinEx: <https://www.coinex.com/zh-hant/swap/usdt-hns>

> 2023/11/07 更新: 新增 CoinEx 交易所，他們的 **HNS 出金手續費**是<span class="success">超便宜的 0.1 HNS</span>。\
> **建議以其它低手續費幣種入金 CoinEx，交易為 HNS，然後轉帳至 Namebase 使用。**\
> 這樣比 BTC 轉帳要省得多！

HNS 就是這麼小，台灣人常用的交易所都沒有，你可以把它視為平台幣就好

~~如果 Gate.io 和 Bittrex 不是你的慣用交易所，我建議直接使用 Namebase。Namebase 是專為 Handshake 而設的交易所，它只提供 HNS/BTC 一種交易對。~~  
Namebase 同時是競標 Handshake 網域的兩個管道之一，它把所有東西都整合得很好，而且托管在 Namebase 的網域能夠免費使用它們提供的 Domain Name Server。真的是一條龍服務，把你伺候得好好的。

> 注意\
> 未實名驗證時，Namebase <span class="danger">不提供交易和 HNS 出金功能</span>，僅提供 HNS 入金和 BTC 購買 HNS 功能。

> 轉帳前請詳閱[相關規則](https://learn.namebase.io/about-namebase/verifying#permission-levels)

> 如果本文對你有價值，請使用我的 Namebase 推廣連結\
> <https://www.namebase.io/register/jtsubm>

## Handshake 網域的競標工具

目前，Handshake 網域競標工具有兩套，Namebase 和 Bob Wallet。本文實際在上面競標、截圖，以演示整個操作流程。

* Namebase <span class="success">方便很多</span>，但它是<span class="danger">中心化交易平台</span>
* Bob Wallet 是在 HSD 節點上套了一層 UI，它是<span class="success">直接往鏈上操作</span>
* 你也可以直接操作 HSD 節點，但這並不建議，除非你很清楚你要做什麼。

> 如果你決定直接操作 HSD cli 競標，你一定是個高級玩家\
> 今天在這裡遇到就算我們有緣，這本武功祕笈就送給你吧！\
> ༼ つ ◕\_◕ ༽つ\
> How to Participate in a Name Auction - Handshake Developer Documentation\
> <https://hsd-dev.org/guides/auctions.html>

| Namebase      | Bob Wallet                                             | HSD (full node)                        |                                        |
| ------------- | ------------------------------------------------------ | -------------------------------------- | -------------------------------------- |
| 性質            | 線上平台                                                   | 本機應用程式                                 | 區塊鏈完整節點                                |
| 維護者           | Namebase Inc.                                          | 社群維護                                   | 社群維護                                   |
| 入金方式          | BTC 入金、HNS 入金                                          | HNS 入金，它只是錢包                           | HNS 入金、挖礦所得                            |
| 網域錢包          | 儲存在 Namebase                                           | 儲存在應用程式                                | 儲存在本機                                  |
| 網域 C2C 交易平台   | 有                                                      | 有                                      | 無                                      |
| (已得標的) 網域管理功能 | 有指向外部 DNS 伺服器也可選用平台內建之 DNS 伺服器                         | 有指向外部 DNS 伺服器                          | 有指向外部 DNS 伺服器                          |
| 附加價值          | 內建域名伺服器 自動在 Open Auction 後出價 自動在揭示期披露 每兩年自動 Renewal 網域 | 可在應用程式內運行 HSD full node，或可使用外部的 node   | 擁有整個區塊鏈數據，同時是錢包、是 DNS 解析器、是 HNS 挖礦程式   |
| 連結            | <https://www.namebase.io/>                             | <https://github.com/kyokan/bob-wallet> | <https://github.com/handshake-org/hsd> |

## Handshake 網域的競標規則

> 原文規則說明\
> [Name minting auction - Namebase Learning Center](https://learn.namebase.io/about-handshake/handshake-auction)

競標規則是採用次價密封投標拍賣，即 [Vickrey auction](https://en.wikipedia.org/wiki/Vickrey%5Fauction)。

投標者在不知道其他人出價的情況下遞出標單，**出價最高的人得標，但只需付次高的出價**。Handshake 引入了鎖定和盲注的規則，這是為了防止有人出價超過他們的能力，以及防止對他們不想實際購買的名字進行垃圾競價。

> ![handshake bid](/Blockchain/blockchain-domain/handshake/bid.png)\
> 鎖定金額 = 出價 + 盲注

值得強調的是，只有出價決定了拍賣的贏家，盲注是完全可有可無的，最高的出價會贏得拍賣，而不是最高的鎖定。盲注隱藏了你的出價，使它在別人看來更高。只有你能看到你的出價金額，而其他人只能看到鎖定的金額。你會在揭示期開始時收到你的盲注退回，並在揭示期結束後收到多餘的出價退回。

依照個人經驗，**競標冷門網域時直接出價 ~~60 HNS~~ 以上，就很少會有人來亂**。如果出價過低會有機器人搶標，並在事後翻倍上架販售等你來買。有時可能會遇到路人出低價來碰運氣，此時就會需要付出第二高價。但通常都很低價，只要你的域名足夠冷門。\
(撰文時 60 HNS 約值 USD $15)

## Handshake 網域的競標週期

![](/Blockchain/blockchain-domain/handshake/DomainLifeCycle.png)

你可以用 HNS 對任何尚未鑄造的域名進行競標。這將觸發該域名爲期 720 個 blocks (**約 5 天**) 競價期的開始。競價期結束後，是 1440 個 blocks (**約 10 天**) 的揭示期，在此期間，競標者必須披露其競標的真實出價。出價最高的競標者 (不是最高的鎖定) 贏得拍賣，並獲得該域名。如果你下了盲注，當你披露你的出價時，它就會立即退回給你。需要注意的是，<span class="danger">如果你忘記披露你的出價，它將不會被計算在競標內，而且<b>你將永久失去你的整個鎖定 (包括你的出價和任何盲注)</b>。</span>

揭示期結束後，得標者只需支付第二高的出價金額 (而不是他們自己的得標金額) 並退還兩者之間的差額。失敗者會被退回他們全部的鎖定金額。如果只有一個競標者，<span class="success">唯一的競標者將免費獲得域名</span>，因為第二高的出價實際上是零。**沒有人會收到贏家支付的 HNS；它們會被從區塊鏈上銷毀**，對 HNS 價格產生通貨緊縮。

注意，Handshake 域名提供真正的所有權，這意味著沒有每年的租賃費用，但**域名所有者需要進行兩年一次的「心跳交易」(僅付出礦工費)**，以證明他們仍然可以使用自己的域名。

## Namebase 競標

* [註冊 Namebase](https://www.namebase.io/register/jtsubm)
* [入金](https://www.namebase.io/exchange/buy#btc)
  * **你要先在外部錢包持有 BTC**
  * 上方只是快速試算，並不重要。請在下方填入你的外部 BTC 錢包地址\
    ![](/Blockchain/blockchain-domain/handshake/namebase/1.png)
  * 取得 Namebase 的 BTC 轉帳地址
    > 請注意，<span class="danger">未完成身份認證的話無法出金</span>，請詳閱[相關規則](https://learn.namebase.io/about-namebase/verifying#permission-levels)\
    > ![](/Blockchain/blockchain-domain/handshake/namebase/2.png)
  * 將 BTC 轉帳至該地址
  * 過一會就能在[概覧 (Dashboard)](https://www.namebase.io/dashboard) 看到金額入帳為 HNS
* 來到[域名](https://www.namebase.io/domains)，在上方搜尋要競標的網域\
  在此，我以 [iroa🧸](https://www.namebase.io/domains/xn--iroa-3f24c)作示範\
  可以看到此網域已 Released，但並沒有人啟動過競標流程

  > 值得一提的是，Handshake 可以接受中文字和 emoji 網域，下標此類域名時務必讀過說明\
  > [Why do emoji domains begin with "xn--\*" strings?](https://help.namebase.io/article/6x9djbth9h-why-do-emoji-domains-begin-with-xn-strings)\
  > ![](/Blockchain/blockchain-domain/handshake/namebase/3.png)
  > ![](/Blockchain/blockchain-domain/handshake/namebase/4.png)

* 在右側出價，我出價 80 HNS，並不添加盲![](/Blockchain/blockchain-domain/handshake/namebase/5.png)
* 礦工費接近 0.1 HNS，撰文時約 NT 0.75 ![](/Blockchain/blockchain-domain/handshake/namebase/6.png)
* 使用 Namebase 時，不需要在進入 Bidding Period 後回來出價，這是由於它會在 Open Auction 完後自動幫你出價\
  在系統自動出價後，你會收到一封 email 告知\
  ![](/Blockchain/blockchain-domain/handshake/namebase/7.png)
* 然後**等 5 天**，截標前再回來確認免得翻車\
  ![](/Blockchain/blockchain-domain/handshake/SeveralDaysLater.jpg)
* 下圖顯示已進入揭示期，Namebase 會自動揭示，不需要任何操作\
  ![](/Blockchain/blockchain-domain/handshake/namebase/8.png)
* **等 10 天**，這段時間是要等所有競標者回來進行揭示，以決定誰是贏家

  > 如果出現平手的狀況，會以先揭示者為獲勝\
  > Namebase 是在進入揭示期的幾乎同時自動幫你揭示，所以不用擔心

  ![](/Blockchain/blockchain-domain/handshake/OneEternityLater.png)

* 過了 10 天，現在網域已得標，它被儲存在 Namebase 代管的 HNS 錢包裡
  * 來到 Dashboard，你可以注意到出價和第二高價價差已經自動歸還，Namebase 是全自動幫你處理的\
    請點擊左測的「Domain Manager」\
    ![](/Blockchain/blockchain-domain/handshake/namebase/10.png)
  * 在「Your domains」下會顯示你的所有得標域名\
    **點擊該域名右測的「Manage」，而不是域名名稱！**\
    ![](/Blockchain/blockchain-domain/handshake/namebase/11.png)
  * 往下拉，可以看到 Namebase 自動幫你寫了他們家的 Name Server 位置到鏈上，下方直接可以設定 DNS Records\
    就經驗來說，他們的 Server 在功能上沒有什麼問題，你可以直接使用\
    ![](/Blockchain/blockchain-domain/handshake/namebase/12.png)

競標過程用 Namebase 是真的很方便，由它代勞很不錯，但未來繼續把 DNS Server 託管在 Namebase 又變成了中心化部署。你可以考慮把網域給「轉帳」出來至外部錢包 (Bob 錢包)。

![](/Blockchain/blockchain-domain/handshake/namebase/9.png)

> 需要特別注意的是，<span class="danger">轉帳出來的網域需要每兩年手動 Renewal。</span>\
> [請在此確認 Namebase 網域轉帳的相關事項](https://learn.namebase.io/about-namebase/transferring-entities#transfer-in-handshake-names)。

## Bob Wallet 競標

* 下載安裝 [Bob Wallet 桌面版應用程式](https://github.com/kyokan/bob-wallet/releases/latest)
* 註冊新錢包
* 入金
  * Bob Wallet 只接受 HNS 入金，你必須在其它交易所購得 HNS，詳細請見 [HNS 的交易所](#hns-exchange)
  * 左方按下 Receive，右方會出現大大的警告： <span class="danger">請只轉帳 HNS 至此位址，轉入任何其它虛擬幣都將永久遺失！</span>\
    ![](/Blockchain/blockchain-domain/handshake/Bob/6.png)
    ![](/Blockchain/blockchain-domain/handshake/Bob/7.png)
  * 由你的交易所將 HNS 轉入此地址，我轉入了 90 HNS 進來
* 點左側 Browse Domains，在搜尋前，**請等待右上角的同步完成！**\
  Bob Wallet 會下載整個 Handshake blockchain，並起動 fullnode\
  <span class="danger">程式沒有阻擋，但只有在完成同步以後所有的查詢、操作才會正確！</span>\
  ![](/Blockchain/blockchain-domain/handshake/Bob/1.png)
  ![](/Blockchain/blockchain-domain/handshake/Bob/2.png)
* 在此，我以 chenchun 作示範 <span class="hide">(這是我名字護照拼音)</span>\
  可以看到此網域是 Available，但並沒有人啟動過競標流程，讓我來 Start Auction\
  ![](/Blockchain/blockchain-domain/handshake/Bob/3.png)
  ![](/Blockchain/blockchain-domain/handshake/Bob/4.png)
* 接下來要等待 Open Auction 完成，進入 Bidding Period 再回來下標\
  一個 Block 平均花費 10 分鐘，可以大略算下要等待多久<span class="hide">，這次我等了 6 小時多</span>\
  ![](/Blockchain/blockchain-domain/handshake/Bob/5.png)
* 進入 Bidding Period 後回來出價，我出價 80 HNS，並不添加盲注

> Namebase 沒有這個步驟是由於它會在 Open 完後自動幫你出價\
> 多麼的友好\
> ![](/Blockchain/blockchain-domain/handshake/Bob/8.png)

* 事後查詢，礦工費為 0.022 HNS，撰文時約 NT 0.16 元\
  ![](/Blockchain/blockchain-domain/handshake/Bob/9.png)
* 然後等 5 天，截標前再回來確認免得翻車\
  ![](/Blockchain/blockchain-domain/handshake/SeveralDaysLater.jpg)
* 揭示期期間，一定要回來披露你的出價。<span class="danger">如果你忘記披露你的出價，它將不會被計算在競標內，而且<b>你將永久失去你的整個鎖定 (包括你的出價和任何盲注)</b></span>

> Namebase 沒有這個步驟是由於它會自動幫你做披露\
> 又一次，多麼的友好

* 打開 Bob 時，它用紅色提醒我一定要來做揭示\
  ![](/Blockchain/blockchain-domain/handshake/Bob/10.png)
* 來到網域詳細頁面，按下右側的揭示鈕\
  ![](/Blockchain/blockchain-domain/handshake/Bob/11.png)
* **出現上面提示後，等約 5 分鐘**\
  狀態並不會立刻更新，要等它寫到鏈上才會顯示揭示完成\
  ![](/Blockchain/blockchain-domain/handshake/Bob/12.png)
* 揭示完成，等 10 天後回來確認結果\
  ![](/Blockchain/blockchain-domain/handshake/Bob/13.png)
* 等 10 天，這段時間是要等所有競標者回來進行揭示，以決定誰是贏家

> 如果出現平手的狀況，**會以先揭示者為獲勝**\
> 請盡可能地早回來做揭示\
> ![](/Blockchain/blockchain-domain/handshake/OneEternityLater.png)

* 過了 10 天，現在網域已得標，它被儲存在我們的 HNS 錢包裡\
  記得回來做得標程序，會退還你的出價和第二高價價差
  * 打開 Bob 時，它用黃色提醒我領取域名\
    ![](/Blockchain/blockchain-domain/handshake/Bob/14.png)
  * **出現上面提示後，等約 15 分鐘**\
    狀態並不會立刻更新，要等它寫到鏈上才會顯示完成\
    這次因為沒有第二位競標者，次高價實際為 0，我被退還所有出價\
    也就是說，這次的競標我只支出了幾毛錢的礦工費\
    ![](/Blockchain/blockchain-domain/handshake/Bob/15.png)
  * 點左側「Domain Manager」來到域名管理頁，並進入剛得標的域名設定\
    由下方的 Add Record 添加 DNS 伺服器位置，它會在 6 小時後生效\
    詳細操作預計在後續 blog 文中介紹\
    ![](/Blockchain/blockchain-domain/handshake/Bob/16.png)

## 結語

現在你已經競標到了人生第一個區塊鏈網域，而我為了寫這篇文又多標了兩個，我們已經脫離了中心化組織的掌控。只要每兩年記得做 Renewal，你就能終生使用它們，不用再多付任何租賃費用，也不用繳保護費以在 whois 隱藏自己。

下一篇將講解如何設定我們的新網域，讓它能夠和我們的 server 串在一起。

> 下篇\
> [Handshake domain 區塊鏈網域 —— 如何訪問網域](/Blockchain/blockchain-domain/handshake-blockchain-domain-how-to-access)
