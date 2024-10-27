+++
title = "Handshake domain 區塊鏈網域 —— 如何訪問網域"
description = "區塊鏈網域和其它常見的NFT可不一樣，它不只是個所有權憑證，它寫在鏈上的資訊還能導向我們的伺服器位置。這篇將講解如何設定訪問方，使自己能訪問Handshake網域，並且在文末探討有關憑證驗證的議題。"
date = 2022-01-15T19:24:00.006Z
updated = 2022-12-15T20:23:49.754Z
draft = false
aliases = [ "/2022/01/handshake-blockchain-domain-how-to-access.html" ]

[taxonomies]
tags = [ "區塊鏈", "Blockchain Domain" ]

[extra]
card = "preview.png"
iscn = "iscn://likecoin-chain/dIW1ALSDI9yVxlh8an4X9uOzlwB7bp2gBPPWMPz6--8/1"

  [extra.comments]
  id = "109447655356992717"
+++
![preview](preview.png)

> 前篇  
> [Handshake domain 區塊鏈網域 —— 購買 HNS、網域競標](/Blockchain/blockchain-domain/handshake-blockchain-domain-auction)

在前篇我們成功把網域給標到手了！區塊鏈網域和其它常見的 NFT 可不一樣，它不只是個所有權憑證，它寫在鏈上的資訊還能導向我們的伺服器位置。Handshake domain 是個已經有實作的專案，整個架構是能運行的。要把它使用起來，我們有兩個面向要設定，一邊是伺服器方；一邊是訪問方 —— 伺服器方要起動一台 DNS 主機，並由鏈上指向它；訪問方要把自己的解析器替換為 Handshake resolver。

這篇將講解如何設定**訪問方**，使自己能訪問 Handshake 網域，並且在文末探討有關憑證驗證的議題。<!--more-->

## 如何訪問 Handshake 網域

Handshake 的解析器有不少實作，[完整清單在此](https://learn.namebase.io/starting-from-zero/how-to-access-handshake-sites)。以下介紹幾個不錯的方案。

> 請用 [welcome.nb/](http://welcome.nb/) 進行測試  
> **輸入時注意最後方的斜槓**，以免某些瀏覧器啟動搜尋功能

### HNS↗TO - 不用做任何設定

網址: [hns.to](http://hns.to)

![](/Blockchain/blockchain-domain/handshake/HNS_to.gif)

hns.to 是一個 Handshake 的網關服務，**它能以傳統 DNS 訪問，並代理 Handshake 網域的內容給你**。在瀏覧器直接訪問 "hns.to/"+Handshake 網域，例如 "[hns.to/welcome.nb/](http://hns.to/welcome.nb/)"，它會自動導向至 <http://welcome.nb.hns.to/>，並返回 [welcome.nb/](http://welcome.nb/) 的內容給你。它很方便，但<span class="danger">這一定不安全</span>，所有流量都會經過它們家的伺服器。

這適用在暫時提供未設定 Handshake domain 環境的圈外人使用，請不要把它視為正式用途。

### Bob Extension (Chrome Extension)

網址: <https://chrome.google.com/webstore/detail/bob-extension/ogcmjchbmdichlfelhmceldndgmgpcem>

![](/Blockchain/blockchain-domain/handshake/bob_extension.png)

它是一個瀏覧器內錢包，[由社群維護](https://github.com/kyokan/bob-extension)。除了常見的和 dapps 互動以外，它還提供瀏覧器內 proxy 功能 —— 將 Chrome 的 DNS 查詢導向到 HNSD 解析器。預設它會使用公開的 HNSD 主機，你可以在設定中改成指向你自己的解析器。

我不推薦使用這個 Extension 做 Proxy。猜也知道，[Let's Encrypt 不支援發行 Handshake domain 的 TLS 證書](https://community.letsencrypt.org/t/lets-encrypt-for-handshake-domains/159544)，所以我在個人主機上使用自簽憑證。當訪問網頁時會出現 `ERR_CERT_AUTHORITY_INVALID`，按「繼續」或輸入 `thisisunsafe` 以訪問，這還算能接受。但是經過 Extension Proxy 後，此錯誤會變為 `ERR_PROXY_CERTIFICATE_INVALID`，並且無法手動允許。無法訪問是要我怎麼用..

### NextDNS - 內建 Handshake 域名解析的 DNS 提供商

網址: <https://nextdns.io/zht>

![](handshake/nextdns_logo.png)

NextDNS 公司是一家 DNS 解析器提供商，允許用戶設定 DNS Filter 以過濾 DNS 查詢。NextDNS 每月提供 30 萬筆查詢次數的免費額度，如果你需要更多流量，訂閱制為 NT$70 / 月、NT$700 / 年。他們內建非常多的 DNS 過濾清單、追蹤清單，甚至有 AdGuard 的清單。最重要的，它們可以解析 Handshake 域名。

![](/Blockchain/blockchain-domain/handshake/nextdns_handshake.png)

<span class="success">如果你不自己架設解析器，那麼 NextDNS 是最理想的選擇了</span>，若你的用量不會超出免費額度的話。NextDNS 網站有完整的設定教學，你可以把它設定在瀏覧器層級；電腦 OS 層級；或是路由器層級。NextDNS 是一家頂尖的 DNS 提供商，而它們支援 Handshake 這件事，無疑是給 Handshake 社群帶來很大的肯定。

> 題外話，我個人目前使用 NextDNS 做手機的 DNS Filter  
> 不愧是小米手機，追蹤數據一半送美國、一半送大陸  
> 中美大數據我兩邊都參與到了耶┌(。Д。)┐
>
> ![](/Blockchain/blockchain-domain/handshake/nextdns_mi.png)

### HNSD - SPV light node

網址: <https://github.com/handshake-org/hnsd>

![](/Blockchain/blockchain-domain/handshake/preview.png)

HNSD 由社群維護，是 Handshake 網路的 SPV 解析器。它會和其它 HSD full node 建立 P2P 網路，向其它 full node 詢問網域解析，並驗證獲得的回應。HNSD 本身不儲存任何資料，只在 DNS cache 滿載時使用 12MB 的 memory。

自行架設 HNSD 時，能夠<span class="success">保證你的瀏覧不經過其它第三方外部主機</span>。HNSD 的優點在於<span class="success">它的運行成本很低</span>，並不是每個人的環境都有足夠強大的機器，儲存 20GB 且持續增長的區塊鏈以運行完整的 HSD 節點。但<span class="danger">由於它依賴外部的 full node 查詢區塊鏈，它不是一個安全的解決方案</span>。

你可以在本機電腦運行它，並把瀏覧器 DNS 指向它；或是在內網的 NAS 上運行它，把電腦的 DNS 指向它。

### Fingertip - HNSD + letsdane + go-ethereum 的 Proxy server

網址: <https://impervious.com/fingertip.html>

**這是一個[開源](https://github.com/imperviousinc/fingertip)的 Proxy 伺服器**，<span class="success">內建 HNSD </span>以解析 handshake 網域，整合了 [letsdane](https://github.com/buffrr/letsdane) 以<span class="success">驗證 DANE 憑證</span>，還整合 [go-ethereum](https://github.com/ethereum/go-ethereum) 以<span class="success">解析.eth 域名 (ENS 域名)</span>。安全性考量請參考上方 HNSD 的描述，除了 Proxy Server 和 DNS Server 差別外，其餘在定位上差不多。

### HSD - full node

網址: <https://github.com/handshake-org/hsd>

![](/Blockchain/blockchain-domain/handshake/preview.png)

自行運行 HSD 完整節點當然是<span class="success">完全分散式、最隱私、且最安全</span>的做法。你持有完整的區塊鏈，並且直接在上頭查找網域資訊。

## 探討關於 Handshake 的憑證信任驗證機制

> 在 Namebase 的說明文件上有探討這個主題  
> <https://learn.namebase.io/about-handshake/about-handshake#a-more-secure-internet>

> CA 憑證的介紹，請見外站連結  
> HTTPS/SSL/TLS 概述，整體流程、憑證、數位簽章 - iT 邦幫忙  
> <https://ithelp.ithome.com.tw/articles/10193095>

你的電腦上出廠就安裝了數百個 CA —— 微軟有 390 個證書，而 Mac OS X 有 170 個證書。為了「安全」地瀏覽網頁，你必須信任所有這些 CA 以及它們委託的許多中介機構。如果這些機構中哪怕任何一個有惡意行為或被駭客攻擊，那麼你所有的 HTTPS 互聯網瀏覽流量都會受到影響，容易受到 MITM 中間人攻擊。**在 [DigiNotar 事件](https://www.hkcert.org/tc/blog/trust-of-website-certificate-questioned-reflection-of-the-comodo-and-diginotar-incidents)中，伊朗政府駭掉了一個荷蘭 CA，並利用它對 30 萬伊朗公民進行 MITM 攻擊。**這又是一個中心化架構的缺陷，而 Handshake 能解決這個問題。

Handshake 網域以區塊鏈作為自己的信任根，並將其 TLS 密鑰釘在自己身上。

Handshake 不是依靠「由數百個證書頒發機構組成的任意集中式列表」來驗證公鑰的真實性，而是通過「將信任根轉移到一個有密碼支持的分佈式信任根」也就是區塊鏈，使任何人都可以驗證密鑰的真實性。與傳統網域不同的是，只需要一個壞的證書頒發機構就可以破壞你的安全，而在 Handshake，駭客得要造假整個 Handshake 區塊鏈。

CA 驗證的主要目標是「讓客戶端確定其取得的網頁，是由被權威驗證過的伺服器所發出」。「**申請人被權威驗證過**」，並且因為只有該伺服器能送得出憑證，「<span class="success">網頁沒有在中途被調包</span>」。區塊鏈網域的本質就是要脫離權威審察，在這裡並沒有被信任的權威，也沒有人能審察你的網域註冊。「申請人被權威驗證過」不一定是好事，因為<span class="danger">權威可能不被信任</span>，尤其這些機構都在各大政府的掌控之下。再說，現在<span class="danger">由 Let's Encrypt 可以很簡單的取得被瀏覧器信任的憑證</span>。若看到一家正規公司的憑證由 Let's Encrypt 簽發當然是件不正常的事，但它一樣都會顯示綠色鎖頭🔒。

在區塊鏈的世界中，鏈上的資訊是不可能假的。我們使用自簽憑證，將此憑證的雜湊寫到 Handshake 鏈上，並在網頁上提供此憑證。客戶端將憑證和鏈上寫的資訊作比對，以查覈此網頁是由網域擁有者所送出，「<span class="success">網頁沒有在中途被調包</span>」。**整個信任基礎由「權威認證的信任樹」改為「網頁確實來自網域所有者」**。今天你來到 `blog.maki0419/` 看到了綠色鎖頭，你想知道的是這確實是我的網頁，而不是我有向權威繳保護費。DANE 驗證的是更合理的信任基礎。

> DNS-based Authentication of Named Entities (DANE) 是一項網際網路安全協議，允許使用 DNSSEC 將通常用於 TLS 的 X.509 數位證書與域名綁定。它是在 RFC6698 中提出的，是一種在沒有 CA 的情況下驗證 TLS 客戶端和服務器實體的方法。
>
> 詳細探討請見外站連結  
> DANE 的過去、現在與未來 - 財團法人台灣網路資訊中心部落格 | TWNIC Blog  
> <https://blog.twnic.tw/2021/04/15/17961/>

> 要在 Handshake 實作 DANE 驗證請讀以下這篇文章，文內講得非常詳細  
> [Building a secure website on your Handshake TLD | by Matthew Zipkin | Medium](https://matthewzipkin.medium.com/building-a-secure-website-on-your-handshake-tld-a8922a950a4f)  
> 對，真有夠複雜

此文撰文時點，<span class="danger">主流瀏覧器都不支援 DANE 驗證</span>，客戶端要[另起一台 Proxy 來驗](https://github.com/buffrr/letsdane)。這讓我覺得，在 Handshake 尚未流行的現階段配置 DANE 的意義還不夠大。**目前我個人只使用簡單的自簽憑證，確保連線有透過 TLS 加密而已。**

## 結語

你可能很高興的設定好了，但我得在這裡說句實話 —— <span class="danger">就個人體驗來說，上鏈查資料比傳統 DNS 系統要慢上數百倍。</span>當 resolver 中沒有 cache 時，你可能要重覆 F5 個 20 秒才能成功查回 ip，視你的機器效能和網路速度而定。沒有辦法，不像傳統 DNS 是以速度和串串樂為中心的設計，Handshake 是以區塊鏈為中心的設計。只要上鏈就會扯到機器效能，而其結果就是慢。

**現在我個人使用 NextDNS，並在平常不使用的 Browser 上設定 DoH**，以免超出免費方案。當我要訪問 Handshake 站點，我就打開該 Browser，並多 F5 個幾次讓 NextDNS 建立 cache。目前我的使用量小到不值得我在本地配置 node，並且我也沒有什麼機敏資訊害怕洩漏。以上心得提供給各位參考。

下一篇講講我們身為伺服器方，如何來設定第一個 Handshake domain，實際操作架設一個站點起來。

> 下篇  
> [Handshake domain 區塊鏈網域 —— 如何設定網域](/Blockchain/blockchain-domain/handshake-blockchain-domain-how-to-setup)
