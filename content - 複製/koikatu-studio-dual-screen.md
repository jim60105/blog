+++
title = "[Koikatu / Koikatsu Sunshine] Studio 雙螢幕 (Studio Dual Screen)"
description = "[Koikatu / Koikatsu Sunshine] Studio 雙螢幕 (Studio Dual Screen)"
date = 2020-03-25T15:34:00.018Z
updated = 2021-10-31T11:13:00.070Z
draft = false
aliases = ["/2020/03/koikatu-studio-dual-screen.html"]

[taxonomies]
tags = ["Koikatu", "C#"]

[extra]
banner = "https://img.maki0419.com/blog/preview/demo14.png"
+++
![](https://img.maki0419.com/blog/preview/demo14.png)
  
  
**必需要有實體雙顯示器才能使用**  
* 在VMD錄屏的同時操作UI或調整物件
* 第二顯示器固定視角，並在主顯示器調整物件
  
#### 功能

* 啟用Studio的第二顯示器功能
* UI只會顯示在主顯示畫面
* Frame會顯示在雙畫面
* VMD和KK\_StudioCharaLightLinkedToCamera會作用在第二畫面
* 脖子和目光朝向第二畫面
* 可固定副顯示器的視角，使滑鼠操作和Camera1\~10不會移動副顯示器  
(鍵盤操作仍會反應)

#### 支援插件

* KKVMDPlay v0.2.4

#### 注意

* **必需要有雙實體顯示器才能使用**
* 兩個預設快捷鍵皆為「未設定」，到Config設定後才能使用
* 副顯示器固定後，或修改畫面設定(濾鏡等)後，需要再次觸發啟動快捷鍵以進行畫面同步
* 已知問題: 啟用雙螢幕後F9截圖會造成無回應 \>> 請改用F11

#### 需求依賴

##### Koikatu

* コイカツ！ ダークネス (Koikatu! Darkness)  
這不相容於Steam Koikatsu Party
* BepInEx v5.1 (不支援v5.0.X)
* BepisPlugins r15

##### Koikatsu Sunshine

* BepInEx v5.4.15
* BepisPlugins r16.8.1
  
#### 安裝方式

參考壓縮檔結構，將文件放進「BepInEx/plugins/jim60105」資料夾之下  
  
#### 下載位置

<https://cloud.maki0419.com/s/5rAceqoeJNzHXMq>  