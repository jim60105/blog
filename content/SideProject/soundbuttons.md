+++
title = "[個人專案] SoundButtons - 聲音按鈕"
description = "[個人專案] SoundButtons - 聲音按鈕"
date = 2021-04-30T19:24:00.098Z
updated = 2023-12-04T11:48:19.034Z
draft = false
aliases = [ "/2021/05/soundbuttons.html" ]

[taxonomies]
tags = [ "JavaScript", "C#", "Livestream" ]

[extra]
banner = "https://img.maki0419.com/blog/soundButtons/homepage_preview.png"
+++
![](https://img.maki0419.com/blog/soundButtons/homepage_preview.png)

  
![License](https://img.shields.io/github/license/jim60105/sound-buttons?style=for-the-badge) ![.NET Core](https://img.shields.io/static/v1?style=for-the-badge&message=.NET+Core&color=512BD4&logo=.NET&logoColor=FFFFFF&label=) ![TypeScript](https://img.shields.io/static/v1?style=for-the-badge&message=TypeScript&color=3178C6&logo=TypeScript&logoColor=FFFFFF&label=) ![Sass](https://img.shields.io/static/v1?style=for-the-badge&message=Sass&color=CC6699&logo=Sass&logoColor=FFFFFF&label=)  
![Angular](https://img.shields.io/static/v1?style=for-the-badge&message=Angular&color=DD0031&logo=Angular&logoColor=FFFFFF&label=) ![Microsoft Azure](https://img.shields.io/static/v1?style=for-the-badge&message=Microsoft+Azure&color=0089D6&logo=Microsoft+Azure&logoColor=FFFFFF&label=) ![Azure Functions](https://img.shields.io/static/v1?style=for-the-badge&message=Azure+Functions&color=0062AD&logo=Azure+Functions&logoColor=FFFFFF&label=) ![YouTube](https://img.shields.io/static/v1?style=for-the-badge&message=YouTube&color=FF0000&logo=YouTube&logoColor=FFFFFF&label=)  

> SoundButtons - 聲音按鈕  
> <https://sound-buttons.click/>

這是一個Vtuber聲音按鈕網站，方便聽你老婆怪叫

此站特色在於獨家的音檔投稿系統，送出表單後能全自動剪輯音訊、產生按鈕。

前端使用Angular；後端以Azure Functions搭配Azure Blob Storage實作，在Github上開源。

## 前言

我一直在思考如何把我的專業和興趣結合。我是個軟體工程師，我喜歡ACG、我喜歡Vtuber。[Koikatu插件](/2020/05/personal-koikatu-plugin.html)、[截選歌單](/2020/12/userscript-youtube-clip-playlist.html)都是成果；而這也是。  

今年(2021)年後轉職為網站後端工程師，加入了 多奇 —— 一間以技術為主的專案公司。  
Sound Buttons專案算是我的個人練習台，練習的同時我也盡力要求自己按照標準實做。Angular規定很多，要求你把code寫在對應的地方。很繁瑣難學，但這就是它的價值。當你的code都能寫在預期的位置，其它寫Angular的工程師就能容易讀懂你的專案。

說句心裡話，  
我是個後端工程師，我不喜歡寫js，js很難做架構；但Angular typescript寫起來就是舒服ww  

此文前半段是寫給大眾的操作說明；後半段是[技術介紹](#技術介紹)，說說這次我用了什麼酷玩意

## 功能介紹

### 首頁  

> <https://sound-buttons.click/>  

[![](https://img.maki0419.com/blog/soundButtons/homepage_preview.png)](https://img.maki0419.com/blog/soundButtons/homepage%5Fpreview.png)

進入首頁會來到Vtuber總覽。  
這頁的重點在於動態載入內容，此站內容全是json設定檔，要加人物只需要寫新設定檔就行。

也就是說，內容的擴充很簡單，歡迎各位[聯絡我](https://github.com/jim60105/sound-buttons%5Fconfigs/discussions/2)添加你婆

另外RWD很好玩，請看看這個

### 人物頁

> <https://sound-buttons.click/yoruka>  

左半邊是人物介紹；右半邊是Youtube來源和聲音按鈕

[![](https://img.maki0419.com/blog/soundButtons/chara.png)](https://img.maki0419.com/blog/soundButtons/chara.png)

最左下角為AudioControl，有「音量調整」、「全部停止」、「語速調整」功能

![](https://img.maki0419.com/blog/soundButtons/audio-control.png)

本頁也有做RWD，尤其是在AudioControl的表現上，我自認做得還不差\~  

![](https://img.maki0419.com/blog/soundButtons/chara-rwd.png)

### 投稿功能

> <https://sound-buttons.click/yoruka/upload>  

[![](https://img.maki0419.com/blog/soundButtons/upload.png)](https://img.maki0419.com/blog/soundButtons/upload.png)

在人物頁的右上角有個「投稿」連結，點此開啟該人物專用的投稿表單

[![](https://img.maki0419.com/blog/soundButtons/chara-upload.png)](https://img.maki0419.com/blog/soundButtons/chara-upload.png)

投稿功能支援兩種方式來提供音檔

1. Youtube網址：  
填入Youtube影片ID，在表單上測試起始、結束秒，送出表單由後台系統剪輯  
[![](https://img.maki0419.com/blog/soundButtons/upload-youtube.png)](https://img.maki0419.com/blog/soundButtons/upload-youtube.png)
2. 上傳音檔：  
直接上傳音檔，此種方式不用等待系統作業，也不用擔心作業失敗，上傳完畢能立刻看到結果。  
此方式適合擁有現成音檔的人使用。  
以此方式仍推薦填上Youtube來源，以便將人流導向回Vtuber  
[![](https://img.maki0419.com/blog/soundButtons/upload-file.png)](https://img.maki0419.com/blog/soundButtons/upload-file.png)

兩種方式可以擇一，也能同時填寫  
同時填寫時會使用上傳之音檔，並在Youtube預覽區顯示填入的Youtube影片來源

### 投稿預覽  

> <https://sound-buttons.click/yoruka?liveUpdate=1>  

[![](https://img.maki0419.com/blog/soundButtons/preview.png)](https://img.maki0419.com/blog/soundButtons/preview.png)

在投稿頁的右上角有「待審核預覽」連結，點此開啟投稿後的成果預覽

[![](https://img.maki0419.com/blog/soundButtons/upload-preview.png)](https://img.maki0419.com/blog/soundButtons/upload-preview.png)

投稿時系統會全自動產生聲音按鈕，能在運算完成後即時看到成果，這是本站賣點  
由於投稿功能並沒有防白目機制，仍需由我手動整理至正式版。

要重整內容時請按左下角的「重新整理本頁內容」  
本站使用Angular，為SPA架構，只要不按F5，在站內瀏覽時都能保持狀態  

[![](https://img.maki0419.com/blog/soundButtons/preview-reload.png)](https://img.maki0419.com/blog/soundButtons/preview-reload.png)

如果內容有錯需要刪修，可以透過[Github](https://github.com/jim60105/sound-buttons%5Fconfigs/discussions/3)連絡我  

### FAQ

* Q: 這網站能幹嘛?  
A: 能聽你老婆怪叫
* Q: 請問按哪裡投稿?  
A: 人物頁面的右上角
* Q: 為什麼投稿會失敗?  
A: 請在直播結束後幾個小時再試，Youtube完成轉檔前的下載速度可能奇慢無比
* Q: 我想加人  
A:[Github Discussion](https://github.com/jim60105/sound-buttons%5Fconfigs/discussions/2)
* Q: 我寫錯了  
A:[Github Discussion](https://github.com/jim60105/sound-buttons%5Fconfigs/discussions/3)
* Q: 網站有Bug  
A:[Github Issues](https://github.com/jim60105/sound-buttons/issues)
* Q: 我想請你喝奶茶  
A: 謝謝，[綠界](https://p.ecpay.com.tw/78C6D)

## 技術介紹

### 專案架構

* sound-buttons  
![Angular](https://img.shields.io/static/v1?style=for-the-badge&message=Angular&color=DD0031&logo=Angular&logoColor=FFFFFF&label=)  
主專案，為Angular網頁，目前直接Host在Github Page
* sound-buttons\_configs  
![JSON](https://img.shields.io/static/v1?style=for-the-badge&message=JSON&color=000000&logo=JSON&logoColor=FFFFFF&label=)  
網頁內容是以json檔管理，預期會頻繁更新，把這些config檔抽離為git submodule
* sound-buttons\_upload-backend  
![Azure Functions](https://img.shields.io/static/v1?style=for-the-badge&message=Azure+Functions&color=0062AD&logo=Azure+Functions&logoColor=FFFFFF&label=)  
這是Azure Function，用來接form post後剪音檔、上傳至Blob Storage、更新json config

### 技術細節  

#### sound-buttons

![Angular](https://img.shields.io/static/v1?style=for-the-badge&message=Angular&color=DD0031&logo=Angular&logoColor=FFFFFF&label=)

##### [首頁](https://github.com/jim60105/sound-buttons/tree/master/src/app/home-page)

首頁結構很簡單，一個ng-for就寫完，但css很複雜。卡片動畫是魔改自網路範例，同時也學到RWD調整。這是我第一次寫SASS、也是我第一次用CSS Variables。

##### [人物頁面](https://github.com/jim60105/sound-buttons/tree/master/src/app/container)

人物頁是自己重頭做的切版，很好的練習到了。尤其是左下角的[AudioControl](https://github.com/jim60105/sound-buttons/blob/master/src/app/audio-control/audio-control.component.scss)，以display grid使之能在RWD改變時正確流動。  

##### [上傳表單](https://github.com/jim60105/sound-buttons/tree/master/src/app/upload)  

在上傳表單中有youtube ID、Start、End和file upload的交叉驗證，用到比較細微的表單狀態操作、ValidatorFn撰寫等

File Upload後的音檔長度驗證，然後修改表單中End參數

表單送出的multipart/form-data如何做組合；form post狀態管理等等。

![](https://img.maki0419.com/blog/soundButtons/upload.png)

##### 多國語系i18n

本專案有做多國語系i18n，我嘗試了三種解決方案

* 自製的i18n  
我自己做了一個簡單的service來處理json檔內的多國語系，並自己寫了i18n pipe，[這裡有git記錄](https://github.com/jim60105/sound-buttons/compare/56e9f138529736265b055333999562b2f27454ce...%E8%87%AA%E8%A3%BD-i18n)
* [Angular內建的i18n](https://angular.tw/guide/i18n)  
但因為它是預編譯至個別資料夾，這不方便用在我的Github Page部屬架構中，[這裡也有記錄](https://github.com/jim60105/sound-buttons/compare/56e9f138529736265b055333999562b2f27454ce...Built-in-i18n)
* [ngx-translate](https://github.com/ngx-translate/core)  
最後我採用ngx-translate，它的用法多元，且專案架構不會改變，[這裡是git compare](https://github.com/jim60105/sound-buttons/compare/56e9f138529736265b055333999562b2f27454ce...47a01385923aaeacacd315a644319b851488a77d)。

ngx-translate和我的自製i18n相比之最大好處在於它有[工具](https://github.com/biesbjerg/ngx-translate-extract)可以extract所有需要翻譯的字串  

##### [按鈕](https://github.com/jim60105/sound-buttons/blob/master/src/app/sound-buttons/Buttons.ts)

得益於Angular、ES6和Typescript，我可以很好的把按鈕給封裝起來。

在這裡我遇到一個小坑：由json以Button型別接進來的物件，並不會帶有我在Button型別上定義的方法。我知道ts在執行時期沒有型別，但我預期Angular在http.get()進來時會以對應的型別new出來接，應該會過我的ctor。但並沒有...[所以我寫了pipe map自己new](https://github.com/jim60105/sound-buttons/blob/master/src/app/services/config.service.ts#L97-L108)  

#### sound-buttons\_upload-backend

![Azure Functions](https://img.shields.io/static/v1?style=for-the-badge&message=Azure+Functions&color=0062AD&logo=Azure+Functions&logoColor=FFFFFF&label=)

後端選用Azure Functions的原因有下

* 網站後端很適合Azure Functions的耗用量方案(Consumption plan)
   * 每月免費送 1 百萬個request，以及每月 400,000 GB 的資源耗用量
   * 後端只用來接上傳表單，運行時間不長足夠我用，就算超過也很便宜(每百萬次執行 NT$6.011)
   * 對，它就便宜
* 我的音檔是存放在Azure Blob Storage，這兩個產品的整合度很高
* 雖說是Serverless，但C#原生的Path、File、Directory都能使用，我在剪音檔時需要暫存檔案

##### 流程圖

[![](https://img.maki0419.com/blog/soundButtons/upload-backend-flowchart.png)](https://img.maki0419.com/blog/soundButtons/upload-backend-flowchart.png)

##### [YoutubeDLSharp](https://github.com/Bluegrams/YoutubeDLSharp)

這是一個C#的youtube-dl wrapper。寫法算直覺，內建不少snippet可以抄。  
我對youtube-dl略懂略懂，在以前的[這個專案](/2020/11/docker-youtube-dl-auto-recording-live-dl.html)使用過，之後可能會寫一篇專文介紹?

另外一提，youtube-dl的windows binary使用的是舊版python打包，有個[已被關閉但未修復](https://github.com/ytdl-org/youtube-dl/issues/10766)的issue  
有以下方式解決

1. 用新版python重新打包youtube-dl
2. 在Azure Functions主機上安裝新版python，然後傳入wrapper
3. 改用yt-dlp

我選3 ༼ つ ◕\_◕ ༽つ  

##### [Xabe.FFmpeg](https://ffmpeg.xabe.net/)

這是一個C#的FFmpeg wrapper，我使用FFmpeg來剪音檔。  
用法有點特別，要讀[doc](https://ffmpeg.xabe.net/docs.html)，但能work得很好。

##### Azure Blob Storage

在Azure Function觸發時可以直接DI拿到[BlobContainerClient](https://learn.microsoft.com/en-us/dotnet/api/azure.storage.blobs.blobcontainerclient?view=azure-dotnet)，直接拿這個做存取即可  
說實話Azure Functions對Blob Storage的[官方文件](https://docs.microsoft.com/zh-tw/azure/azure-functions/functions-bindings-storage-blob)寫得不怎麼樣，也幾乎沒有什麼中文資源，只能多Google  
Azure Blob Storage的.NET Core[文件](https://docs.microsoft.com/zh-tw/azure/storage/blobs/storage-quickstart-blobs-dotnet)就寫得不錯，值得閱讀

## 版權申明

![License](https://img.shields.io/github/license/jim60105/sound-buttons?style=for-the-badge)   
本作品使用 AGPLv3 授權  
原出處擁有所有聲音和角色圖片的版權。尊照他們的衍生作品指南（二次創作指南）使用素材資料。 若希望通過 DMCA Takedown 刪除您的資料，請在[此處](https://github.com/sound-buttons/sound-buttons%5Fconfigs/discussions/3)回報

iscn://likecoin-chain/B0HqE3UCC1IwAvozc0YYnBqy4YO4CI8ZJHYYsu4UxAs