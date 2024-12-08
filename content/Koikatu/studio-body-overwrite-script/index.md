+++
title = "[Koikatu][BepInEx v5.X] Studio 角色覆寫腳本 (Studio Body Overwrite Script)"
description = "一鍵覆寫角色身體"
date = 2020-05-16T05:48:00.013Z
updated = 2021-10-31T11:12:17.939Z
draft = false
aliases = [
  "/2020/05/koikatu-studio-body-overwrite-script.html",
  "/2020/05/koikatubepinex-v5x-studio-studio-body.html"
]

[taxonomies]
tags = [ "C#", "Koikatu" ]
licenses = [ "GFDL 1.3" ]

[extra]
card = "../preview/demo15.jpg"
+++

{{ video(url="/Koikatu/preview/demo15.mp4", alt="Studio Body Overwrite Script video", controls=true, loop=true, autoplay=true, muted=true) }}

這個不是 Plugin 而是 Script，**請用 [ScriptLoader](https://github.com/denikson/BepInEx.ScriptLoader) 載入執行**

請手動編輯 `.cs` 檔，將內容修改為你要覆寫的數值

* 數值等於 Maker 中的數字除以 100 (即遊戲內數值 89 = 0.89f)
* Color 為 Color (r, g, b, a)，請參閱 [UnityDoc](https://docs.unity3d.com/ScriptReference/Color-ctor.html)
* 不需覆寫的項目請在開頭加上「//」做行註解

{% alert(tip=true) %}
Studio 中以 <kbd>O</kbd> 鍵觸發
{% end %}

<!-- more -->

**衝突: Koikatu PushUp** 因其內部自己存了一份胸部數據，並會在儲存和切換時回寫

## 需求依賴

* コイカツ！ ダークネス (Koikatu! Darkness)  
  這不相容於 Steam Koikatsu Party
* **BepInEx v5.0.1**
* BepisPlugins r13.1.1

## 安裝方式

1. 安裝 [ScriptLoader](https://github.com/denikson/BepInEx.ScriptLoader)
2. 將 \*.cs 置於「Koikatu/scripts」下

## 下載位置

<https://cloud.maki0419.com/s/sxp596jEzfapnzL>
