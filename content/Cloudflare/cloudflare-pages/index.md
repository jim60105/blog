+++
title = "[個人專案] 以 Cloudflare Pages 打造低成本高流量的即時投票系統 (Cloudflare Pages, Pages Functions, Cloudflare D1)"
description = "[個人專案] 以 Cloudflare Pages 打造低成本高流量的即時投票系統 (Cloudflare Pages, Pages Functions, Cloudflare D1)"
date = 2024-01-04T03:49:00.034Z
updated = 2024-01-04T05:12:13.483Z
draft = false
aliases = [ "/2024/01/cloudflare-pages.html" ]

[taxonomies]
tags = [ "JavaScript", "Cloudflare" ]
licenses = [ "GFDL 1.3" ]

[extra]
card = "preview.jpg"
+++
Image Generated with Microsoft Bing Designer

元旦假期做了一個新的專案 —— <mark>Simple Poll System 簡易投票系統</mark>  
<https://github.com/jim60105/simple-poll-system>

我為什麼寫這個呢?  
上週薬袋アルマ舉辦[Vtuber 紅白活動](https://youtu.be/qCrihRF4wvM)，前兩天的[會限直播](https://youtu.be/J6XPHfcUIgY)在和大家測試投票系統。當時發現現成的問卷服務都不合用，不是要<span class="spoiler">很多</span>錢就是不即時，而最後用了 Google Form。 雖然 Google Form 是當下最好的選擇，但它不夠客製化，像是直播當下的[紅組被顯示為藍色，而白組被顯示為紅色](https://youtu.be/qCrihRF4wvM?t=20455)、[無法內嵌投票結果在活動網頁上](https://kouhaku2023.wixsite.com/kouhaku2023/vote)等等。

我就在想，要以這個需求來規劃一個小專案的話我會使用什麼技術實現它。然後就當作練練手...

這是一個以概念驗證和學習為目的而做的專案，目標是建構一個<span class="success">低成本、高流量</span>的<span class="success">即時</span>投票系統。投票只是一種簡單的應用，你可以把它代換為任何使用**網頁前後端和資料庫**的應用場景。

<!-- more -->

我選用了[Cloudflare Pages](https://developers.cloudflare.com/pages)、[Cloudflare Page Functions](https://developers.cloudflare.com/pages/functions/)、以及[Cloudflare D1](https://developers.cloudflare.com/d1/) 來達到這個目標。

> 特別提醒
>
> ---
>
> 撰文時 Cloudflare D1 正在進行公開測試。  
> 即便它在體驗上運行良好，仍不建議在 production 上使用測試產品。

<span class="success">由 Cloudflare 處理網頁本身的流量</span>，且在 Cloudflare Pages 並不以網頁流量計價。[Cloudflare Pages 的主要限制是建置頻率和檔案大小](https://developers.cloudflare.com/pages/platform/limits/)，這兩者在正常使用情況下不太可能超過免費額度。我在文件中沒有找到關於頁面承載能力的任何限制；然而，這是 Cloudflare。我不認為他們會在靜態網頁訪問上遇到流量瓶頸。

[對 Cloudflare Functions 的 request 是被計算為 Cloudflare Workers request](https://developers.cloudflare.com/pages/functions/pricing/)。 Cloudflare 提供<span class="success">免費層每**天** 10 萬次 request</span>；而 5 美元的付費層有<span class="success">每**月** 1000 萬次</span>額度，超過的每 100 萬次 0.30 美元。與其他的後端解決方案相比是另人驚訝的便宜，而且它[幾乎沒有冷啟動](https://blog.cloudflare.com/eliminating-cold-starts-with-cloudflare-workers)！

[Cloudflare D1 計價](https://developers.cloudflare.com/d1/platform/pricing/#billing-metrics)包括<span class="success">每**天** 10 萬次免費寫入和 500 萬次免費讀取</span>。此額度是否足夠取決於請求量以及你的資料表設計和系統設計。至於付費層是<span class="success">每**月** 250 億次讀取和 5000 萬次寫入</span>，和上面提到的是同一個 5 美元方案！

在規劃系統時，需要重點考量 API 訪問頻率以及對資料庫的讀寫操作，特別是當你的網站流量大的時候。

> 專案程式碼和詳細的設定步驟請見 GitHub:  
> <https://github.com/jim60105/simple-poll-system>

> 延伸閱讀
>
> ---
>
> * [\[個人專案\] 網頁計數器徽章 View Counter Badge —— 瀏覧數別再送人啦！以 Cloudflare Workers D1 實作適合純前端網頁的計數器](/SideProject/view-counter-badge-cloudflare-workers-d1)
> * [\[經驗分享\] 我的 Cloudflare Worker 被進行外部壓力測試，俗稱DDOS 😠](/Cloudflare/cloudflare-worker-ddos)
