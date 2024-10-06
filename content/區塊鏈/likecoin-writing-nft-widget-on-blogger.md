+++
title = "在Blogger或其它寫作平台放置LikeCoin Button、Writing NFT widget (半自動化)"
description = ""
date = 2022-12-14T13:04:00.017Z
updated = 2023-11-05T07:31:32.294Z
draft = false
aliases = ["/2022/12/likecoin-writing-nft-widget-on-blogger.html"]

[taxonomies]
tags = ["區塊鏈"]
+++
[![](https://img.maki0419.com/blog/likecoin-writing-nft-widget/preview.png)](https://img.maki0419.com/blog/likecoin-writing-nft-widget/preview.png) 

## 前言

我也加入 Writing NFT 的作者行列了！

 這篇文章教各位在 Blogger 每篇文的文末自動產生 LikeCoin Button ，並且，只要在文章中加入 ISCN ，LikeCoin Button 就會變成 Writing NFT widget！

 所謂的「半自動化」，是指你需要手動為文章產生 ISCN 並加入文章內，其餘都是自動化的喔！

## Widget 外觀

## 插入程式碼

* 打開主題編輯器: Blogger 後台 → 主題 → 編輯 HTML
* Ctrl+F 尋找  ，這個標籤是文章內容，我們要把 code 貼在它的後面  
    
> 如果你的版型支援手機版，你會找到兩處，一處手機版一處電腦版，不要遺漏
* 複製貼上這段程式碼，位置參考如圖  
[![](https://img.maki0419.com/blog/likecoin-writing-nft-widget/template.png)](https://img.maki0419.com/blog/likecoin-writing-nft-widget/template.png)  
    
      
> Blogger 主題程式碼需要做 HTML encode  
> [文末](#%E9%80%9A%E7%94%A8%E7%A8%8B%E5%BC%8F%E7%A2%BC)提供原始程式碼以在其它平台上使用
* 把程式碼第六行的 `[LikerID]` 改為你的 LikerID ！
* CSS微調: 你可能會想調整在第二行的 style，讓它搭配你的版型風格

## 使用方式

### 在沒有出版為 Writing NFT 的時候 

它會顯示為讚賞按鈕，自動的，什麼都不用做！ 

### 在出版為 Writing NFT 的時候

* 在[NFT Protal](https://app.like.co/nft/url) 手動出版為 Writing NFT，取得 ISCN  
> 官方說明書  
>  
> ---  
>  
> [https://docs.like.co/v/zh/general-guides/writing-nft/nft-portal](https://docs.like.co/v/zh/general-guides/writing-nft/nft-portal#yi-wen-zhang-wang-zhi-chu-ban-writing-nft)
* 回到文章編輯器，切換至 <> HTML檢視  
[![](https://img.maki0419.com/blog/likecoin-writing-nft-widget/switch-to-html.png)](https://img.maki0419.com/blog/likecoin-writing-nft-widget/switch-to-html.png)
* 在文章的任一處 (最末尾即可)，貼上這個 div 標籤  
iscn://likecoin-chain/iQ5NQdeCLXQ66evbflzBGgc908rbt0xlfH15cQLdlSQ/1

> 各位理解後一定能記住它
> 
> ---
> 
> <div id="iscn" hidden\>iscn://likecoin-chain/iQ5NQdeCLXQ66evbflzBGgc908rbt0xlfH15cQLdlSQ/1
> 
> ---
> 
> 綠色： div 標籤本體，它是的形式  
> 橘色： 這個標籤的 id，用做程式碼的識別，這 id 就叫做 iscn  
> 黃色： hidden ，設定這個標籤在頁面上隱藏不顯示  
> 紫色： ISCN 的內容，程式會把這個內容拿去產生 Writing NFT widget

## 通用程式碼

以下提供 html encode 前的程式碼，可以在其它的寫作平台使用


## 參考資料

* [以JavaScript在Blogger等各家網誌的文末、側欄產生LikeButton « 尋夢，撐一支長篙](https://danieltw.net/archives/2444)
* [NFT Widget - LikeCoin](https://docs.like.co/v/zh/general-guides/writing-nft/nft-widget)

> ↓下面這一個就是用此方法產生的 widget↓

iscn://likecoin-chain/iQ5NQdeCLXQ66evbflzBGgc908rbt0xlfH15cQLdlSQ