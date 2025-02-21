+++
title = "如何在 OBS Studio 錄製和匯入透明背景影片"
description = "想在 OBS Studio 中使用透明背景影片嗎？本文深入探討如何在 OBS 中錄製和匯入帶有 Alpha 通道的影片。從基本概念到實際操作，一步步揭開這個有趣技術的神秘面紗。你將學到 Alpha 通道的原理、OBS Studio 的錄製設定，以及如何輕鬆匯入透明背景影片。"
date = "2024-12-22T16:00:03.816Z"
updated = "2024-12-22T16:00:04.169Z"

[taxonomies]
tags = [ "Livestream" ]
licenses = [ "All Rights Reserved" ]

[extra]
iscn = "iscn://likecoin-chain/8353EziYokYoeU6oc8fSCwbGsqDcI8ZsGBSWK2R-EX4/1"
withAI = "本篇文章透過「[筆韻智匠 Quill Sage🖋️✨](https://www.coze.com/s/Zs8k6GASu/)」和 Claude 3.5 Sonnet 聯合創作"
hot = true

  [extra.comments]
  id = "113698906788022929"
+++
<figure>
{{ video(url="transparent_vp9.webm", alt="A video without background", controls=true, loop=true, muted=true, autoplay=true) }}
<figcaption> 一個使用 OBS 錄製的無背景的影片，<a href="transparent_vp9.webm" target="_blank">右鍵下載回去試試?</a> </figcaption>
</figure>

## 前言

在直播圈中，創新的視覺效果總是能為觀眾帶來驚喜。前幾天在 Discord 的一位朋友說想要「在直播中播放一個去背的字幕影片」，這個問題勾起了我的好奇心。

他的需求是**唱歌直播時，在畫面前方同步播放去背的歌詞字幕動畫**，他抱怨說{{cr(body="「OBS Studio 的綠幕功能去背效果不好」。")}}

我過往沒有試過使用去背影片，對這個技術的現狀也不了解，於是我決定來試試如何在 OBS Studio 中實現這個功能。由於我手邊沒有去背影片素材，我的目標就變成了：**「在 OBS 中錄製無背景的影片，並且能夠順利地在 OBS 中匯入播放。」**

在研究過程中，我意外發現這種去背影片不僅適用於直播，在網頁上也能播放！  
對我一個網頁工程師來說，這部份的應用其實更有趣 😀

接下來，讓我們一起探索如何在 OBS Studio 中玩轉透明背景影片，從基本概念到實際操作，一步步揭開這個有趣技術的神秘面紗。

> ~~朋友使用 Wondershare Filmora 14 & Adobe Premiere 製作字幕影片，這兩款軟體我都沒有，所以這部份不在本篇討論範圍內。~~
> 見 [後日談](#afterword)

<!-- more -->

## 影片/圖片是怎麼能「去背」的?

在深入探討 OBS Studio 的操作之前，讓我們先來了解一下「去背」這個概念的本質。

當我聽到朋友的需求時，我立刻花了 30 秒 Google 了一下 <mark>alpha channel video format</mark>。

這位朋友的專業並不在資訊工程，他對於「去背影片」的概念侷限在綠幕或是黑幕，但從我的角度來看這個需求的關鍵其實是「Alpha channel」才對。

### Alpha 通道

Alpha 通道是除了{{color(body="紅 (R)", color="red", halo="true")}}、{{color(body="綠 (G)", color="green", halo="true")}}、{{color(body="藍 (B)", color="blue", halo="true")}} 之外的第四個顏色通道。它專門用來定義影像中每個像素的透明度。想像一下，如果 RGB 決定了一個像素的顏色，那麼 Alpha 就決定了你能透過這個像素看到多少背後的內容。

概念上來說，

- Alpha 值為 0：完全透明
- Alpha 值為 255 (8 位元) 或 65535 (16 位元)：完全不透明
- 中間值：部分透明

當影片或圖片的某些區域被設定為透明或半透明時，背後的內容就會透出來，這就是為什麼我們能看到「去背」的效果。

傳統的綠幕技術是透過軟體將特定顏色 (通常是綠色或藍色) 替換為透明，這種方法有其局限性，容易受到光線變化和邊緣細節的影響。

相比之下，直接使用支援 Alpha 通道的影片格式，可以更精確地控制每個像素的透明度。這不僅能創造出更自然、更細緻的去背效果，還能實現部分透明等複雜效果，大大提升了視覺表現的可能性。

了解了這個概念就能更好地理解為什麼有些影片格式能夠「去背」，而有些不能。

> 這個表格翻譯自 [pixelbakery.com](https://pixelbakery.com/recipes/video-image-formats)

| 檔案格式 / 編碼         | 最大透明度位深度 | 瀏覽器支援          | 媒體類型           | 優缺點 / 備註                                           |
|-------------------------|------------------|---------------------|--------------------|-------------------------------------------------------|
| **Apple ProRes 4444**      | 16-bit           | 無支援              | 影片 / .mov        | 龐大的未壓縮影片，通常用於儲存母版。                  |
| **HEVC / h.265**           | 10-bit           | 僅限 Safari 支援    | 影片 / .HEVC       | 被設計為 h.264 的繼任者。                             |
| **WebM (VP8 或 VP9 編碼)** | 12-bit           | 支援良好            | 影片 / .WebM       |    |
| OpenEXR                | 32-bit           | 無支援              | 圖像 / .exr        | 具有最大的 HDR 動態範圍。                              |
| PNG                    | 16-bit           | 完全支援            | 圖像 / .png        | 有趣的是，PNG 也可以用來製作動畫。                     |
| TIFF                   | 32-bit           | 無支援              | 圖像 / .tiff       | 有失真壓縮。                                           |
| 動畫 PNG               | 24-bit           | 支援良好            | 圖像 / .apng       | 比 GIF 更好的選擇。                                   |
| GIF                    | 8-bit            | 廣泛支援            | 圖像 / .gif        | 注意：瀏覽器通常不支援 GIF 的透明層，且壓縮效果不佳，檔案笨重。 |

> 注意：h.264 AKA MP4 不支持透明通道。

> FLV 不包含在此列表中。它是一種舊的、已被淘汰的格式，充滿了安全問題和漏洞。

## 影片去背的方法

了解了 Alpha channel 的概念之後，要如何製作出一個去背的影片就很清晰了：**想辦法從你的錄影軟體或影片製作軟體匯出一個支援 Alpha channel 的影片格式。**

我不是影片軟體專家，其它的軟體操作此文略過不談。如果你使用其他軟體，可以嘗試問問 ChatGPT：

```
我使用 Wondershare Filmora 14 和 Adobe Premiere，請告訴我如何匯出帶有透明通道的編碼格式
```

之類的，我相信 AI 知道怎麼做。

在本文中，我將專注於如何在 OBS Studio 中錄製一個支援 Alpha channel 的影片。這是一個相對直接且實用的方法，特別適合已經在使用 OBS 進行直播或錄影的使用者。

## OBS Studio 錄製支援 Alpha channel 的影片

<figure>
{{ youtube(id="xXTWRO8XVlA", autoplay=false) }}
<figcaption> 我拍的操作說明影片 </figcaption>
</figure>

{% alert(warning=true) %}
以這個設定錄製出來的影片檔案會非常大，日常使用可能不太合適...
{% end %}

要在 OBS Studio 中錄製支援 Alpha channel 的影片，需要進行一些特定的設定。

1. 在 OBS Studio 的右下角找到並點擊設定按鈕。

   {{ image(url="OBS設定.png", alt="OBS設定", transparent=true) }}

2. 在設定視窗中，選擇「進階」頁。
   - 色彩格式：BGRA
   - 色彩空間：Rec. 709
   - 色彩範圍：完整

   {{ image(url="進階.png", alt="進階", transparent=true) }}

3. 接下來，切換到「輸出」頁。在這裡，你需要：
   - 將輸出模式設定為「進階」
   - 來到「錄影」頁籤
   - 選擇「自訂 FFmpeg」
   - 封裝格式選擇 「mov」
   - 影像編碼器選擇 「prores_aw」

   {{ image(url="輸出.png", alt="輸出", transparent=true) }}

完成這些設定後，你就可以開始錄製了。使用這些設定錄製出來的影片將會包含 Alpha channel，實現透明背景的效果。

值得注意的是，{{cr(body="這個設定下錄製的影片檔案大小會相當大。")}}對於日常使用，可能需要權衡檔案大小和無背景需求之間的平衡。

## OBS Studio 匯入 Alpha channel 影片

經過前面一連串的折騰，終於成功錄製出了帶有 Alpha Channel 的影片。我懷著激動的心情，準備迎接這個研究的本命環節 —— 在 OBS Studio 中匯入這個來之不易的透明背景影片。

深吸一口氣，我打開了 OBS Studio，準備大顯身手......

然後?

<span class="spoiler" style="font-size: xx-large;">
那就是普普通通的匯入影片來源就行了，完全不用做什麼設定。
{{ image(url="三小.jpg", alt="三小", no_hover=true) }}
</span>

沒錯，就是這麼簡單。你沒看錯，我也沒寫錯。那些複雜的設定? 那些特殊的步驟? 在匯入時統統不需要。OBS Studio 聰明得很，它會自動識別並正確處理帶有 Alpha Channel 的影片。

抱歉了我的朋友，問題不是出在 OBS Studio，而是在你身上。檢查一下你的影片格式，確保它支援 Alpha Channel，然後再試一次吧。

## 附錄: 如何將這無背景的影片轉檔成更小的檔案

差點忘了還要寫這個附錄。  
前面說了這有 Alpha channel 的影片檔案會非常大對吧，那我是怎麼把它放到部落格網頁上的呢?

<figure>
{{ video(url="transparent_vp9.webm", alt="A video without background", controls=true, loop=true, muted=true, autoplay=true) }}
<figcaption> 剛才那個使用 OBS 錄製的無背景的影片，其實是轉檔完的影片 </figcaption>
</figure>

不賣關子，指令在這裡:

```bash
INPUT="in.mov" OUTPUT="out.webm" CRF=45 EFFORT="good" bash -c 'ffmpeg -y -i "$INPUT" -pix_fmt yuva420p -an -c:v libvpx-vp9 -crf "$CRF" -b:v 0 -deadline "$EFFORT" -threads 4 -lag-in-frames 25 -row-mt 1 -pass 1 -f null /dev/null && ffmpeg -y -i "$INPUT" -pix_fmt yuva420p -an -c:v libvpx-vp9 -crf "$CRF" -b:v 0 -deadline "$EFFORT" -threads 4 -lag-in-frames 25 -row-mt 1 -pass 2 "$OUTPUT"'
```

這個 ffmpeg 指令會將 `in.mov` 轉檔成 `out.webm`，然後神奇的事情就發生了 —— {{cg(body="113 MB 的影片檔案瞬間縮小到了 635 KB！")}}這簡直就是數位減肥的奇蹟😆

這個強大的指令來自[這篇文章](https://jakearchibald.com/2024/video-with-transparency/#encoding-vp9)，這位大神從另一個角度探討了透明背景影片的主題，絕對值得每個前端工程師一讀。

至於能不能直接用 libvpx-vp9 錄影呢？說實話，我也不知道。我試過在 OBS 中使用 libvpx-vp9，結果每次按下錄影鍵，OBS 就像是遇到了什麼可怕的事情一樣立刻崩潰。

不過，鑑於我是在比較冷門的 [Fedora Toolbox](https://github.com/jim60105/toolbx?tab=readme-ov-file#video-toolbox) 中運行 OBS Studio，這個問題可能只是我個人環境的特殊情況。如果你有不同的經驗，或是成功使用 libvpx-vp9 直接錄製的話，歡迎在下方的 Mastodon 留言告訴我。我很樂意聽到你的經驗分享！

## 參考資料

- [Video with alpha transparency on the web - JakeArchibald.com](https://jakearchibald.com/2024/video-with-transparency/)
- [List of Video/Image Formats Supporting Alpha Channels | pixelbakery.com](https://pixelbakery.com/recipes/video-image-formats)
- [Encode/VP9 - FFmpeg](https://trac.ffmpeg.org/wiki/Encode/VP9)
- [Media | Google for Developers](https://developers.google.com/media/vp9/bitrate-modes)

> 延伸閱讀
>
> ---
> [影片下載轉檔筆記 (Youtube、Twitch、TwitCasting、Twitter Spaces 音訊空間、fc2 live、ffmpeg、yt-dlp)](@/Livestream/youtube-download-ytdlp-ffmpeg/index.md)

## 後日談 {#afterword}

朋友讀了這篇文章之後把他的字幕搞定了。

並且他說

> 你可以改一下筆記  
> 拯救一下其他人  
> W軟體不支援  
> PR有  
> 每個月繳的錢不一樣  
> ADOBE比較厲害!!!

這樣😆
