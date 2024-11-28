+++
title = "[Koikatu / Koikatsu Sunshine] Studio IK→FK修正插件(Studio Reflect FK Fix)"
description = "[Koikatu / Koikatsu Sunshine] Studio IK→FK修正插件(Studio Reflect FK Fix)"
date = 2019-05-16T19:21:00.015Z
updated = 2021-10-31T11:18:17.279Z
draft = false
aliases = ["/2019/05/koikatu-studio-reflect-fk-fix.html"]

[taxonomies]
tags = ["Koikatu", "C#"]

[extra]
banner = "https://img.maki0419.com/blog/preview/demo5-3.png"
+++
![](https://img.maki0419.com/blog/preview/demo5-3.png)
  
  
修改兩個功能:  
* 原始的「FKにポーズを反映」功能會複寫身體FK+脖子FK+手指FK  
→ 改成了只會複寫身體FK，脖子FK和手指FK維持原樣
* 原始的「FK 首 個別參照」功能，是直接複製アニメ的脖子方向  
→ 改成了會複製真實方向。意即可以使用「首操作 カメラ」定位後，再按我的「→FK(首)」按鈕複製至脖子FK
  
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

<https://cloud.maki0419.com/s/EeEXG5EXYCLdzBD>  