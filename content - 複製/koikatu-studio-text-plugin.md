+++
title = "[Koikatu / Koikatsu Sunshine] Studio文字插件 (Studio Text Plugin)"
description = "[Koikatu / Koikatsu Sunshine] Studio文字插件 (Studio Text Plugin)"
date = 2019-06-29T20:37:00.010Z
updated = 2021-10-31T11:17:54.571Z
draft = false
aliases = ["/2019/06/koikatu-studio-text-plugin.html"]

[taxonomies]
tags = ["Koikatu", "C#"]

[extra]
banner = "https://img.maki0419.com/blog/preview/demo6-2.JPG"
+++
![](https://img.maki0419.com/blog/preview/demo6-2.JPG)
  
  
* 從「add→アイテム→2D効果→文字Text」加載，右側選中後在anim選單編輯
* 文字物件可修改字體、大小、樣式、顏色、錨點位置、對齊(換行後顯示選項)
* 可保存文字設定，以作為NewText的預設參數

> 建議分享Scene時一併分享使用的Font  
> (It is recommended to share the Fonts used when sharing Scene.)

  
#### 注意事項

* Fonts會列出OS內安裝，支援Unity動態生成的所有字體，字體總數在500以下時可以顯示預覽
* 若Scene保存後，在其他沒有安裝此Font的OS讀取，會加載MS Gothic
* Color選取使用右下角遊戲原生Color選擇器
* 文字中插入換行符「\\n」可以換行，插入換行符後會顯示「對齊」編輯選項
* 文字重疊時偶爾會渲染不正確，這是Unity的問題，似乎無解
  
#### 需求依賴

##### Koikatu

* コイカツ！ ダークネス (Koikatu! Darkness)  
這不相容於Steam Koikatsu Party
* **BepInEx v5.1 (不支援v5.0.X)**
* BepisPlugins r15

##### Koikatsu Sunshine

* BepInEx v5.4.15
* BepisPlugins r16.8.1
  
#### 安裝方式

參考壓縮檔結構，將文件放進「BepInEx/plugins/jim60105」資料夾之下  
  
#### 下載位置

<https://cloud.maki0419.com/s/T5W2WHaHeRHqNkZ>  