+++
title = "[Chrome Extension] Youtube影片截選播放清單 (Youtube Clip Playlist)"
description = "這是截選播放清單擴充功能，在 Youtube/Onedrive/GoogleDrive/TwitCasting 上直接播放「起始~結束時間」影片片段。此工具專門設計來聽 Vtuber 的歌枠。 (Chrome extension)"
date = 2022-06-29T16:50:00.018Z
updated = 2024-04-08T14:52:45.753Z
draft = false
aliases = [ "/2022/06/chrome-extension-youtube-clip-playlist.html" ]

[taxonomies]
tags = [ "JavaScript", "Livestream", "Youtube", "TwitCasting" ]
licenses = [ "GFDL 1.3" ]

[extra]
card = "preview.png"
iscn = "iscn://likecoin-chain/2fdhShCP5c6UejXKF9ZOwwl4v1cZPyp8RrbzcYpjt_o/1"
featured = true

  [extra.comments]
  id = "109500903202363504"
+++

{{ youtube(id="xuc4Buob22o") }}

![GitHub tag](https://img.shields.io/github/tag/jim60105/YoutubeClipPlaylist?style=for-the-badge#badge) ![GitHub last commit (branch)](https://img.shields.io/github/last-commit/jim60105/YoutubeClipPlaylist?style=for-the-badge#badge) ![LICENSE](https://img.shields.io/github/license/jim60105/YoutubeClipPlaylist?style=for-the-badge#badge)  
[![Chrome Web Store](https://img.shields.io/chrome-web-store/v/kdlhjpdoaabhpolkaghkjklfcdfjapkh?style=for-the-badge#badge)](https://chrome.google.com/webstore/detail/youtube-clip-playlist/kdlhjpdoaabhpolkaghkjklfcdfjapkh#badge) ![Chrome Web Store](https://img.shields.io/chrome-web-store/users/kdlhjpdoaabhpolkaghkjklfcdfjapkh?style=for-the-badge#badge) ![Bootstrap](https://img.shields.io/static/v1?style=for-the-badge\&message=Bootstrap\&color=7952B3\&logo=Bootstrap\&logoColor=FFFFFF\&label=#badge) ![TypeScript](https://img.shields.io/static/v1?style=for-the-badge\&message=TypeScript\&color=3178C6\&logo=TypeScript\&logoColor=FFFFFF\&label=#badge) ![Webpack](https://img.shields.io/static/v1?style=for-the-badge\&message=Webpack\&color=222222\&logo=Webpack\&logoColor=8DD6F9\&label=#badge)  
![Google Chrome](https://img.shields.io/static/v1?style=for-the-badge\&message=Google+Chrome\&color=4285F4\&logo=Google+Chrome\&logoColor=FFFFFF\&label=#badge) ![YouTube](https://img.shields.io/static/v1?style=for-the-badge\&message=YouTube\&color=FF0000\&logo=YouTube\&logoColor=FFFFFF\&label=#badge) ![Microsoft OneDrive](https://img.shields.io/static/v1?style=for-the-badge\&message=Microsoft+OneDrive\&color=0078D4\&logo=Microsoft+OneDrive\&logoColor=FFFFFF\&label=#badge) ![Google Drive](https://img.shields.io/static/v1?style=for-the-badge\&message=Google+Drive\&color=4285F4\&logo=Google+Drive\&logoColor=FFFFFF\&label=#badge)

## 前言

這是截選播放清單擴充功能，在 Youtube/OneDrive/GoogleDrive/TwitCasting 上直接播放「起始\~ 結束時間」影片片段。  
此工具專門設計來聽 Vtuber 的歌枠，這是我對於歌回烤肉的程式解

和看烤肉或剪片相比的優點為

* 觀看數都會算在原始影片上
* 只要清單化起始 / 結束時間就完事，比剪片快得多
* 因為沒有轉載、修改原影片，不會有版權爭議

> 此專案曾是個油猴腳本 (UserScript)，現已重寫為擴充功能
<!-- more -->
## 安裝方法

* 參照[這篇文章](@/Frontend/media-autoplay-on-browser/index.md)，設定下方網域的{{cg(body="允許自動播放")}}

  * `https://www.youtube.com:443`
  * `https://onedrive.live.com:443`
  * `https://gothuedutw-my.sharepoint.com:443`
  * `https://twitcasting.tv:443`
  * `https://drive.google.com:443`

  [![](autoplay.png)](autoplay.png)

* 安裝瀏覧器擴充功能

  <https://chrome.google.com/webstore/detail/kdlhjpdoaabhpolkaghkjklfcdfjapkh>

## 彈窗 UI 選單

### UI

瀏覧器右上角開啟擴充工具彈出式視窗

* 單擊左上角的隨機按鈕，切換是否隨機播放
* 單擊中間的紅色播放按鈕，播放**所有**播放清單
* 單擊播放清單列表，播放**單一**播放清單

[![](UI.png)](UI.png)

[![](UI2.png)](UI2.png)

### 禁用歌單功能

> 若你不聽廣播，可以把 RadioQTamaList 禁用，再使用全循序 / 隨機播放功能

點擊右上角進入「編輯」功能，此時在清單項單擊可以啟用、禁用該播放清單  
編輯完成後，請務必單擊右上角「儲存」按鈕寫入設定

## 歌單 (Playlist)

目前內建[久遠たま](https://www.youtube.com/channel/UCBC7vYFNQoGPupe5NxPG4Bw)、[間取かける](https://www.youtube.com/channel/UCiLt4FLjMXszLOh5ISi1oqw)、[薬袋アルマ](https://www.youtube.com/channel/UCD1QOCJIAPsMKMvRSXjLahw)、[須多夜花](https://www.youtube.com/channel/UCuy-kZJ7HWwUU-eKv0zUZFQ)、[伊冬ユナ](https://www.youtube.com/channel/UCYbzeYnRZuw7fZKrgu2bgtw)、[YOSHIKA⁂Ch.](https://www.youtube.com/c/YOSHIKA-Ch) 的歌單

如果想要編寫歌單，請參考[此 repo](https://github.com/jim60105/Playlists)  
你也可以 fork 此 repo，從頭寫你自己的！

![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen?style=for-the-badge#badge)

### 歌單格式

歌單的格式是 JSON with comment  
這裡有[總表](https://github.com/jim60105/Playlists/blob/master/Playlists.jsonc)，標示清單名稱、標籤、位置，並載入[個別歌單](https://github.com/jim60105/Playlists/blob/master/QuonTama/QuonTamaSongList.jsonc)

每個陣列中儲存以下項目: \[VideoID, StartTime, EndTime, Title?, SubSrc?]

* VideoID: 必須用引號包住，為字串型態
* StartTime: 必須是非負數，為數字型態。如果要從頭播放，輸入 0
* EndTime: 必須是非負數，為數字型態。如果要播放至尾，輸入 0
* Title?: 必須用雙引號包住，為字串型態，可選
* SubSrc?: 必須用雙引號包住，為字串型態，可選

<script src="https://emgithub.com/embed-v2.js?target=https%3A%2F%2Fgithub.com%2Fjim60105%2FPlaylists%2Fblob%2FDemo%2FDemo%2FDemoSongList.jsonc&amp;style=base16%2Ftomorrow-night&amp;type=code&amp;showBorder=on&amp;showLineNumbers=on&amp;showFileMeta=on&amp;showFullPath=on&amp;showCopy=on"></script>

## 歌詞、字幕

### 自動歌詞功能

此專案有一支排程程式，自動從網路上蒐集歌詞，請在 UI 的 Settings 頁啟用。  
歌詞來源為 [網易雲音樂](https://music.163.com/)，以 GitHub Workflow 定時將播放清單使用的歌詞[轉存至 GitHub](https://github.com/jim60105/Lyrics/tree/lyrics)，然後再讓客戶端存取 GitHub。  
經過這層轉存，{{cg(body="你不會直接存取網易雲音樂站台")}}，請安心使用。

> 注意，這是附加功能！  
> 由於歌詞皆為自動化搜尋匹配，能預期會有大量的錯誤情況發生。  
> 若發現歌詞有錯誤，請在[這裡](https://github.com/jim60105/Lyrics/issues/new/choose)回報。  
> 請務必提供該歌曲的 Share 連結，以便我能夠快速修正錯誤歌曲

[![](lyric.png)](lyric.png)

↓啟用後↓

[![](play.png)](play.png)

### ASS 字幕功能

此工具支援載入 WebVTT 字幕 (.vtt)、ASS 字幕 (.ass)、lrc 歌詞 (.lrc)，可將字幕直鏈傳入歌單之 SubSrc 欄位

[![](Sub.png)](Sub.png)

## 參數說明

### 播放單一播放清單

<pre style="text-align: left; width: 100%;">
  https://www.youtube.com/?<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #ff00fe;">startplaylist </span>&amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #ffa400;">playlist=QuonTamaSongList</span>
</pre>

### Youtube 網址格式

<pre style="text-align: left; width: 100%;">
  https://www.youtube.com/watch?<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #9fc5e8;">v=ETjgki1sSgc </span>&amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #b4a7d6;">t=1591 </span>&amp;<span style="color: #d5a6bd;"><br />
  &nbsp;&nbsp;&nbsp;&nbsp;end=1880</span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #93c47d;">shuffle=1</span> &amp;<span style="color: #ffd966;"><br />
  &nbsp;&nbsp;&nbsp;&nbsp;playlistinclude=quon</span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e06666;">playlistexclude=member</span>
</pre>

### Google Drive 網址格式

<pre style="text-align: left; width: 100%;">
  https://drive.google.com/file/d/<span style="color: #9fc5e8;">13LaALYNOmdN3GfD7aeKreyzshdKX-Tvz</span>/view?<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #b4a7d6;">t=884</span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #d5a6bd;">end=1166 </span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #93c47d;">shuffle=1</span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #ffd966;">playlistinclude=quon</span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #e06666;">playlistexclude=member</span>
</pre>

### 其它網址格式 (目前支援 OneDrive、twitcasting)

其它格式是以原網址直接當做 VideoID 傳入

<pre style="text-align: left; width: 100%;">
  <span style="color: #9fc5e8;">https://twitcasting.tv/quon01tama/movie/688324697</span><br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #b4a7d6;">t=1470</span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #d5a6bd;">end=1653 </span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #93c47d;">shuffle=1</span> &amp;<br />
  &nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #ffd966;">playlistinclude=twitcasting</span>
</pre>

### 參數

<ul style="text-align: left;">
  <li>
    <span style="color: #9fc5e8;">VideoID</span>:
    在 Youtube 為原生<code>v</code>參數；Google Drive 是在路徑中；其它為原始網址
  </li>
  <li><code>t</code>: 影片播放<span style="color: #b4a7d6;">開始時間</span></li>
  <li>
    <code>end</code>: 在指定秒數<span style="color: #d5a6bd;">停止播放</span>影片
  </li>
  <li>
    <code>shuffle</code>: Playlist <span style="color: #93c47d;">隨機播放</span>，1 為啟用；0 為禁用(等同不傳入)&nbsp;
  </li>
  <li><code>playlist</code>: <span style="color: #ffa400;">播放單一清單</span>，不能和 <code>playlistinclude</code>、<code>playlistexclude</code> 同時傳入&nbsp;</li><li>
    <code>playlistinclude</code>:
    <span style="color: #ffd966;">讀入</span> Playlist 標籤，可以以「_」底線分隔傳入多個標籤
  </li>
  <li>
    <code>playlistexclude</code>:
    <span style="color: #e06666;">排除</span> Playlist 標籤，可以以「_」底線分隔傳入多個標籤
  </li>
</ul>

### 詳細功能描述

<ul style="text-align: left;">
  <li>此工具是由網址參數驅動</li>
  <li>
    傳入 <span style="color: #ff00fe;">startplaylist</span> 時會啟動此工具，執行<span style="color: #ffa400;">全清單循序播放</span>
  </li>
  <li>
    傳入 <span style="color: #d5a6bd;">end</span>，會<span style="color: #ffa400;">在指定秒數停止播放器</span>
  </li>
  <li>
    傳入 <span style="color: #ffa400;">playlist</span> 參數，會播放指定播放清單
  </li>
  <li>
    使用「標籤篩選功能」，可以混合播放多個播放清單 (例如，以 <span style="color: #ffd966;">playlistinclude=tama</span> 播放久遠たま的所有類型播放清單)
    <ul>
  <li id="include">
    傳入 <span style="color: #ffd966;">playlistinclude</span>，則<span style="color: #ffa400;">只會載入有該標籤的清單</span>
  </li>
  <li>
    傳入 <span style="color: #e06666;">playlistexclude</span>，則會<span style="color: #ffa400;">排除有該標籤的清單</span>，且 <b>Exclude 優先於Include</b>
  </li>
    </ul>
  </li>
  <li>
    「禁用歌單功能」將禁用指定歌單，即使透過標籤篩選也會被排除在外
  </li>
  <li>
    「隨機功能」為建立亂序清單後播放，在所有歌曲都放過一輪後才會再循環
  </li>
  <li>傳入 startplaylist 參數時會立刻重建亂序清單</li>
  <li>
    支援以<span style="color: #ffa400;">鍵盤的媒體按鍵 (Media Keys)</span> 操作「<b>下一首</b>」
  </li>
  <li hidden="">
    <span style="color: #ffa400;">遮蔽「影片已暫停，要繼續觀賞嗎？」功能</span>
  </li>
</ul>

## LICENSE

![LICENSE](https://img.shields.io/github/license/jim60105/YoutubeClipPlaylist?style=for-the-badge#badge)

此工具以 GPLv3 License 開源
