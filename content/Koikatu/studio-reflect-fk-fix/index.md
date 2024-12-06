+++
title = "[Koikatu / Koikatsu Sunshine] Studio IK→FK 修正插件 (Studio Reflect FK Fix)"
description = "原始的「FKにポーズを反映」功能會複寫身體 FK+脖子 FK+手指 FK → 改成了只會複寫身體 FK，脖子 FK 和手指 FK 會維持原樣。"
date = 2019-05-16T19:21:00.015Z
updated = 2021-10-31T11:18:17.279Z
draft = false
aliases = [ "/2019/05/koikatu-studio-reflect-fk-fix.html" ]

[taxonomies]
tags = [ "Koikatu", "Koikatsu Sunshine" ]

[extra]
banner = "../preview/demo5-3.png"
+++

{{ video(url="/Koikatu/preview/demo5-1.mp4", alt="Studio Reflect FK Fix video1", controls=true, loop=true, autoplay=true, muted=true) }}
{{ video(url="/Koikatu/preview/demo5-2.mp4", alt="Studio Reflect FK Fix video2", controls=true, loop=true, autoplay=true, muted=true) }}

修改兩個功能:

* 原始的「FK にポーズを反映」功能會複寫身體 FK + 脖子 FK + 手指 FK  
  → 改成了只會複寫身體 FK，脖子 FK 和手指 FK 維持原樣
* 原始的「FK 首 個別參照」功能，是直接複製アニメ的脖子方向  
  → 改成了會複製真實方向。意即可以使用「首操作 カメラ」定位後，再按我的「→FK (首)」按鈕複製至脖子 FK
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

<https://cloud.maki0419.com/s/EeEXG5EXYCLdzBD>
