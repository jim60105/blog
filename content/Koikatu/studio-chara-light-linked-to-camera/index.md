+++
title = "[Koikatu / Koikatsu Sunshine] Studio 角色光綁定視角 (Studio Chara Light Linked To Camera)"
description = "將 Studio 角色光和視角間之旋轉值連動"
date = 2020-03-12T17:22:00.016Z
updated = 2021-10-31T11:13:17.122Z
draft = false
aliases = [
  "/2020/03/koikatu-studio-chara-light-linked-to-camera.html",
  "/2020/03/koikatubepinex-v5x-studio-studio-chara.html"
]

[taxonomies]
tags = [ "Koikatu", "Koikatsu Sunshine" ]

[extra]
card = "../preview/demo13.jpg"
+++

{{ video(url="../preview/demo13.mp4", alt="Studio Chara Light Linked To Camera Video", controls=true, loop=true, autoplay=true, muted=true) }}

* 將 Studio 角色光和視角間之旋轉值連動
* 鎖定狀態能隨著 SceneData 儲存

使用範例:  
調整角色光為「右側背光，左側是面光」然後鎖定  
則不論視角如何旋轉，都會維持是畫面右側背光
<!--more-->
## 需求依賴

### Koikatu

* コイカツ！ ダークネス (Koikatu! Darkness)  
  這不相容於 Steam Koikatsu Party
* **BepInEx v5.1 (不支援 v5.0.X)**
* BepisPlugins r15

### Koikatsu Sunshine

* BepInEx v5.4.15
* BepisPlugins r16.8.1

## 安裝方式

參考壓縮檔結構，將文件放進「BepInEx/plugins/jim60105」資料夾之下

## 下載位置

<https://cloud.maki0419.com/s/jACW9KP5wBqMJz6>
