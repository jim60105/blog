+++
title = "[Koikatu / Koikatsu Sunshine] Studio 儲存工作區順序修正 (Studio Save Workspace Order Fix)"
description = ""
date = 2020-05-16T05:43:00.011Z
updated = 2021-10-31T11:12:40.737Z
draft = false
aliases = ["/2020/05/koikatu-studio-save-workspace-order-fix.html"]

[taxonomies]
tags = ["Koikatu", "C#"]
+++
[![](https://img.maki0419.com/blog/preview/demo16.png)](https://img.maki0419.com/blog/preview/demo16.png) 

  
* 以Studio的存檔邏輯，工作區中，在第一層之物件排序是以加入順序儲存  
→ 修改為以實際順序儲存

> 因為存這些TreeNode的時候是塞在一個Dictionary裡面，Save&Load的時候依序讀  
> 而Dictionary之排序順序就是Add進去的順序，也就是所有物件建立的順序  
> 這插件做的事就是在Save前按照實際TreeNode順序重新建立這個Dictionary

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

<https://cloud.maki0419.com/s/pckn2RKimATYToL>  