+++
title = "我與AI的寫作合作體驗——教你使用AI撰寫高品質文章"
description = ""
date = 2023-04-13T21:40:00.013Z
updated = 2024-08-31T18:51:14.408Z
draft = false
aliases = ["/2023/04/ai-generated-content-Writes-article-with-Claude.html"]

[taxonomies]
tags = ["AI"]
+++
[![](https://img.maki0419.com/blog/recorder.moe/AIGC/preview.jpg)](https://img.maki0419.com/blog/recorder.moe/AIGC/preview.jpg) 

## 前言

 我最近完成了第一篇 AI 協助下的部落格文章—《[Recorder.moe 錄影服務，讓你再也不會錯過 Vtuber 直播](/2023/04/Recorder-moe-Never-miss-a-Vtuber-stream-again.html)》。這次的寫作經驗讓我大開眼界，我想與讀者們分享這次的寫作過程。這篇文章是我第一次使用 AI 生成的初稿作為基礎，進行修改而完成的。我使用的 AI 寫作工具是 [Claude](https://www.anthropic.com/product)，它在處理程式碼方面表現稍遜，但是在自然語言生成上有出色的表現。

 使用 Claude 產生的文章初稿，為我的寫作節省了不少時間。我只需要對文章進行輕微的潤飾修改，就能產生流暢而清晰的用詞，避免了我一開始面對空白頁面的尷尬。雖然人類作者的才華與創造力是 AI 無法代替的，但是~~藉由與 AI 的合作，我可以專注在高階的寫作部分，讓 AI 支援我處理基礎而枯燥的文章框架定稿。這种人機合作的模式，讓我在寫作上獲得全新的體驗與收穫。~~ 

~~藉由這次的實例，我深切地體會到AI不僅僅是未來，它已經默默地融入我們的日常生活與工作中。AI不會取代人類，但它將成為提升人類生產力與創造力的最佳助手。我對AI與人類在創作領域未來的合作，抱持著充滿期待與想像的心情。~~幹也太長了吧🤣

> ~~請搭配本文的成品閱讀~~
> 
> ~~---~~
> 
> ~~[\[個人專案\] Recorder.moe 錄影服務，讓你再也不會錯過 Vtuber 直播](/2023/04/Recorder-moe-Never-miss-a-Vtuber-stream-again.html)~~  
> 因為專案服務調整，這篇文章已移除

## 開工

首先，我把專案的 [FAQ 原始碼](https://beta.recorder.moe/faq)整個餵了進去，要他產生大綱。我也沒怎麼整理，你能看到內容很醜。

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/01.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/01.png) 

產出結果好到沒話說，一次過關！  
整篇文章就使用了這一套大綱來寫。

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/02.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/02.png) 

我條列了一些我想要的內容，要求他撰寫文字。在產生的過程中有 Retry 了好幾次，選了一篇看得順眼的內容。

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/03.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/03.png) 

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/04.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/04.png) 

接下來就一個章節一個章節要他撰寫，這章我特別要求他加入這些重點，其它部份由他發揮。

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/05.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/05.png) 

因為專案運作模式在 FAQ 文件內寫得很詳細了，我直接請他幫我寫，內容表現也不賴！

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/06.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/06.png) 

這一章節是闡述技術細節。細節一樣在FAQ中都有，但他寫錯了好幾次才寫出正確內容。

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/07.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/07.png) 

總結也寫得很漂亮，不過最後一句話太吹了，我手動調整了一下。  
並且另外加上了未來發展方向的部份。

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/08.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/08.png) 

你沒看錯，他能產生 Mermaid 流程圖！  
這是[這張圖](https://github.com/Recorder-moe/.github/blob/master/profile/README.md#%E5%B0%88%E6%A1%88%E7%9A%84%E5%9F%BA%E7%A4%8E%E6%9E%B6%E6%A7%8B%E4%BB%8B%E7%B4%B9)。  
不過跟我要的內容有點差距，我自己重寫了一半左右。即使如此，他仍舊是給出了很好的範例出來。

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/09.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/09.png) 

最後是請他重寫標題。

[![](https://img.maki0419.com/blog/recorder.moe/AIGC/10.png)](https://img.maki0419.com/blog/recorder.moe/AIGC/10.png) 

從開頭到此為止，我使用的都是同一個交談框。經過這麼長的交談，他沒有表現出忘卻內容。有可能是因為我反覆提及需求，又或者是 Claude 的 token 記憶數量真的很長?

## 結語

不得不說，AI 比我還會寫作。

這次的成果非常另人滿意，節省下非常大量的時間。  
我的工作變成是審核他產出的內容，挑選能用的部份出來，調整他的寫作方向。

另人驚訝的是他真的讀懂了我一開始倒進去的 FAQ 原始碼文件，並且到最後都沒有表現出忘卻。不曉得是 Claude 的記憶 token 數很多，還是我的使用方式正確，效果顯然是出奇的好。

我以後會繼續使用這種方式來產生文章，請多指教了 Claude！

iscn://likecoin-chain/vgNJmLaPB-XlXYNcVy62ln2ogNtfJgyfdSGfSaAxuH0/1