+++
title = "[Chrome Extension] Youtube影片截選播放清單 (Youtube Clip Playlist)"
description = "[Chrome Extension] Youtube影片截選播放清單 (Youtube Clip Playlist)"
date = 2022-06-29T16:50:00.018Z
updated = 2024-04-08T14:52:45.753Z
draft = false
aliases = [ "/2022/06/chrome-extension-youtube-clip-playlist.html" ]

[taxonomies]
tags = [ "JavaScript", "Livestream" ]

[extra]
banner = "https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/preview.png"
+++
## 前言

![](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/preview.png)

  
![GitHub tag](https://img.shields.io/github/tag/jim60105/YoutubeClipPlaylist?style=for-the-badge) ![GitHub last commit (branch)](https://img.shields.io/github/last-commit/jim60105/YoutubeClipPlaylist?style=for-the-badge) ![LICENSE](https://img.shields.io/github/license/jim60105/YoutubeClipPlaylist?style=for-the-badge)  
[ ![Chrome Web Store](https://img.shields.io/chrome-web-store/v/kdlhjpdoaabhpolkaghkjklfcdfjapkh?style=for-the-badge) ![Chrome Web Store](https://img.shields.io/chrome-web-store/users/kdlhjpdoaabhpolkaghkjklfcdfjapkh?style=for-the-badge) ](https://chrome.google.com/webstore/detail/youtube-clip-playlist/kdlhjpdoaabhpolkaghkjklfcdfjapkh) ![Bootstrap](https://img.shields.io/static/v1?style=for-the-badge&message=Bootstrap&color=7952B3&logo=Bootstrap&logoColor=FFFFFF&label=) ![TypeScript](https://img.shields.io/static/v1?style=for-the-badge&message=TypeScript&color=3178C6&logo=TypeScript&logoColor=FFFFFF&label=) ![Webpack](https://img.shields.io/static/v1?style=for-the-badge&message=Webpack&color=222222&logo=Webpack&logoColor=8DD6F9&label=)  
![Google Chrome](https://img.shields.io/static/v1?style=for-the-badge&message=Google+Chrome&color=4285F4&logo=Google+Chrome&logoColor=FFFFFF&label=) ![YouTube](https://img.shields.io/static/v1?style=for-the-badge&message=YouTube&color=FF0000&logo=YouTube&logoColor=FFFFFF&label=) ![Microsoft OneDrive](https://img.shields.io/static/v1?style=for-the-badge&message=Microsoft+OneDrive&color=0078D4&logo=Microsoft+OneDrive&logoColor=FFFFFF&label=) ![Google Drive](https://img.shields.io/static/v1?style=for-the-badge&message=Google+Drive&color=4285F4&logo=Google+Drive&logoColor=FFFFFF&label=)  

這是截選播放清單擴充功能，在Youtube/Onedrive/GoogleDrive/TwitCasting上直接播放「起始\~結束時間」影片片段。  
此工具專門設計來聽Vtuber的歌枠，這是我對於歌回烤肉的程式解

和看烤肉或剪片相比的優點為

* 觀看數都會算在原始影片上
* 只要清單化起始/結束時間就完事，比剪片快得多
* 因為沒有轉載、修改原影片，不會有版權爭議

> 此專案曾是個[油猴腳本(UserScript)](/2020/12/userscript-youtube-clip-playlist.html)，現已重寫為擴充功能

## 安裝方法

參照[這篇文章](https://blog.maki0419.com/2022/01/media-autoplay-on-browser.html)，設定下方網域的允許自動播放
* `https://www.youtube.com:443`
* `https://onedrive.live.com:443`
* `https://gothuedutw-my.sharepoint.com:443`
* `https://twitcasting.tv:443`
* `https://drive.google.com:443`

[![](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/autoplay.png)](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/autoplay.png)

> 安裝瀏覧器擴充功能
>
> ---
>
> [Chrome Web Store](https://chrome.google.com/webstore/detail/kdlhjpdoaabhpolkaghkjklfcdfjapkh)

## 彈窗 UI 選單

### UI

瀏覧器右上角開啟擴充工具彈出式視窗
* 單擊左上角的隨機按鈕，切換是否隨機播放
* 單擊中間的紅色播放按鈕，播放**所有**播放清單
* 單擊播放清單列表，播放**單一**播放清單

[![](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/UI.png)](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/UI.png)

[![](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/UI2.png)](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/UI2.png)

  
### 禁用歌單功能

> 若你不聽廣播，可以把 RadioQTamaList 禁用，再使用全循序/隨機播放功能

點擊右上角進入「編輯」功能，此時在清單項單擊可以啟用、禁用該播放清單  
編輯完成後，請務必單擊右上角「儲存」按鈕寫入設定

## 歌單(Playlist)

目前內建[久遠たま](https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw)、[間取かける](https://www.youtube.com/channel/UCiLt4FLjMXszLOh5ISi1oqw)、[薬袋アルマ](https://www.youtube.com/channel/UCD1QOCJIAPsMKMvRSXjLahw)、[須多夜花](https://www.youtube.com/channel/UCuy-kZJ7HWwUU-eKv0zUZFQ)、[伊冬ユナ](https://www.youtube.com/channel/UCYbzeYnRZuw7fZKrgu2bgtw)、[YOSHIKA⁂Ch.](https://www.youtube.com/c/YOSHIKA-Ch)的歌單

如果想要編寫歌單，請參考[此repo](https://github.com/jim60105/Playlists)  
你也可以fork此repo，從頭寫你自己的！![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=for-the-badge)

### 歌單格式

歌單的格式是JSON with comment  
這裡有[總表](https://github.com/jim60105/Playlists/blob/master/Playlists.jsonc)，標示清單名稱、標籤、位置，並載入[個別歌單](https://github.com/jim60105/Playlists/blob/master/QuonTama/QuonTamaSongList.jsonc)

每個陣列中儲存以下項目: \[VideoID, StartTime, EndTime, Title?, SubSrc?\]

* VideoID: 必須用引號包住，為字串型態
* StartTime: 必須是非負數，為數字型態。如果要從頭播放，輸入0
* EndTime: 必須是非負數，為數字型態。如果要播放至尾，輸入0
* Title?: 必須用雙引號包住，為字串型態，可選
* SubSrc?: 必須用雙引號包住，為字串型態，可選

> 對於 Twitcasting 有密碼鎖的影片，請延伸閱讀  
> [TwitCasting每次播放都要求輸入密碼？不要一直問我！](/2022/01/twitcasting-cookie.html)

## 歌詞、字幕

### 自動歌詞功能

此專案有一支排程程式，自動從網路上蒐集歌詞，請在 UI 的 Settings 頁啟用。  
歌詞來源為 [網易雲音樂](https://music.163.com/)，以 Github Workflow 定時將播放清單使用的歌詞[轉存至 Github](https://github.com/jim60105/Lyrics/tree/lyrics)，然後再讓客戶端存取 Github。  
經過這層轉存，你不會直接存取網易雲音樂站台，請安心使用。

> 注意，這是附加功能！  
> 由於歌詞皆為自動化搜尋匹配，能預期會有大量的錯誤情況發生。  
> 若發現歌詞有錯誤，請在[這裡](https://github.com/jim60105/Lyrics/issues/new/choose)回報。  
> 請務必提供該歌曲的 Share 連結，以便我能夠快速修正錯誤歌曲

[![](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/lyric.png)](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/lyric.png)  

↓啟用後↓

[![](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/play.png)](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/play.png)

### ASS字幕功能

此工具支援載入WebVTT字幕(.vtt)、ASS字幕(.ass)、lrc歌詞(.lrc)，可將字幕直鏈傳入歌單之SubSrc欄位  

[![](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/Sub.png)](https://img.maki0419.com/blog/userscript-youtube-clip-playlist/ChromeWebStore/Sub.png)

## 參數說明

### 播放單一播放清單

> https://www.youtube.com/?  
> startplaylist &  
> playlist=QuonTamaSongList

### Youtube網址格式

> https://www.youtube.com/watch?  
> v=ETjgki1sSgc &  
> t=1591 &  
> end=1880 &  
> shuffle=1 &  
> playlistinclude=quon &  
> playlistexclude=member

### Google Drive網址格式

> https://drive.google.com/file/d/13LaALYNOmdN3GfD7aeKreyzshdKX-Tvz/view?  
> t=884 &  
> end=1166 &  
> shuffle=1 &  
> playlistinclude=quon &  
> playlistexclude=member

### 其它網址格式 (目前支援OneDrive、twitcasting)

其它格式是以原網址直接當做VideoID傳入

> https://twitcasting.tv/quon01tama/movie/688324697  
> t=1470 &  
> end=1653 &  
> shuffle=1 &  
> playlistinclude=twitcasting

### 參數

* VideoID: 在Youtube為原生`v`參數；Google Drive 是在路徑中；其它為原始網址
* `t`: 影片播放開始時間
* `end`: 在指定秒數停止播放影片
* `shuffle`: Playlist隨機播放，1為啟用；0為禁用(等同不傳入)
* `playlist`: 播放單一清單，不能和 `playlistinclude`、`playlistexclude` 同時傳入
* `playlistinclude`:讀入Playlist標籤，可以以「\_」底線分隔傳入多個標籤
* `playlistexclude`:排除Playlist標籤，可以以「\_」底線分隔傳入多個標籤

### 詳細功能描述

* 此工具是由網址參數驅動
* 傳入startplaylist時會啟動此工具，執行全清單循序播放
* 傳入end，會在指定秒數停止播放器
* 傳入playlist參數，會播放指定播放清單
* 使用「標籤篩選功能」，可以混合播放多個播放清單 (例如，以playlistinclude=tama播放久遠たま的所有類型播放清單)  
   * 傳入playlistinclude，則只會載入有該標籤的清單  
   * 傳入playlistexclude，則會排除有該標籤的清單，且**Exclude優先於Include**
* 「禁用歌單功能」將禁用指定歌單，即使透過標籤篩選也會被排除在外
* 「隨機功能」為建立亂序清單後播放，在所有歌曲都放過一輪後才會再循環
* 傳入startplaylist參數時會立刻重建亂序清單
* 支援以鍵盤的媒體按鍵(Media Keys)操作「**下一首**」
* 遮蔽「影片已暫停，要繼續觀賞嗎？」功能

## LICENSE

![LICENSE](https://img.shields.io/github/license/jim60105/YoutubeClipPlaylist?style=for-the-badge)  
此工具以 GPLv3 License 開源

iscn://likecoin-chain/2fdhShCP5c6UejXKF9ZOwwl4v1cZPyp8RrbzcYpjt\_o