+++
title = "[Koikatu / Koikatsu Sunshine] Studio 雙螢幕 (Studio Dual Screen)"
description = "啟用 Studio 的第二顯示器功能，在 VMD 錄屏的同時操作 UI 或調整物件；第二顯示器固定視角，並在主顯示器調整物件"
date = 2020-03-25T15:34:00.018Z
updated = 2021-10-31T11:13:00.070Z
draft = false
aliases = [
  "/2020/03/koikatu-studio-dual-screen.html",
  "/2020/03/koikatubepinex-v5x-studio-studio-dual.html"
]

[taxonomies]
tags = [ "Koikatu", "Koikatsu Sunshine" ]

[extra]
card = "../preview/demo14.png"
+++

{{ youtube(id="zrIIoW44bsQ") }}

{% alert(important=true) %}
必需要有實體雙顯示器才能使用
{% end %}

* 在 VMD 錄屏的同時操作 UI 或調整物件
* 第二顯示器固定視角，並在主顯示器調整物件

## 功能

* 啟用 Studio 的第二顯示器功能
* UI 只會顯示在主顯示畫面
* Frame 會顯示在雙畫面
* VMD 和 KK\_StudioCharaLightLinkedToCamera 會作用在第二畫面
* 脖子和目光朝向第二畫面
* 可固定副顯示器的視角，使滑鼠操作和 Camera1\~10 不會移動副顯示器  
  (鍵盤操作仍會反應)
<!-- more -->
## 支援插件

* KKVMDPlay v0.2.4

## 注意

* **必需要有雙實體顯示器才能使用**
* 兩個預設快捷鍵皆為「未設定」，到 Config 設定後才能使用
* 副顯示器固定後，或修改畫面設定 (濾鏡等) 後，需要再次觸發啟動快捷鍵以進行畫面同步
* 已知問題: {{cr(body="啟用雙螢幕後 F9 截圖會造成無回應")}} >> **請改用 F11**

## 需求依賴

### Koikatu

* コイカツ！ ダークネス (Koikatu! Darkness)  
  這不相容於 Steam Koikatsu Party
* BepInEx v5.1 (不支援 v5.0.X)
* BepisPlugins r15

### Koikatsu Sunshine

* BepInEx v5.4.15
* BepisPlugins r16.8.1

## 安裝方式

參考壓縮檔結構，將文件放進「BepInEx/plugins/jim60105」資料夾之下

## 下載位置

<https://cloud.maki0419.com/s/5rAceqoeJNzHXMq>
