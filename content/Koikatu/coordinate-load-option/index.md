+++
title = "[Koikatu / Koikatsu Sunshine] 服裝卡選擇性載入插件 (Coordinate Load Option)"
description = "服裝卡讀取處，多一個選項盤可以選擇性載入服裝"
date = 2019-03-24T18:08:00.082Z
updated = 2024-10-03T06:22:49.482Z
draft = false
aliases = [
  "/2019/03/koikatu-coordinate-load-option.html",
  "/2019/03/koikatustudiostudio-coordinate-load.html",
  "/2019/03/koikatu-studio-coordinate-load-option.html"
]

[taxonomies]
tags = [ "Koikatu", "Koikatsu Sunshine" ]
licenses = [ "GFDL 1.3" ]

[extra]
card = "../preview/demo1-2.png"
iscn = "iscn://likecoin-chain/cdlnJ1pUNVS0PN3RI3I_D2twlb5ezIL4JqTGb5i2BtM/1"
featured = true
hot = true
+++
{{ video(url="/Koikatu/preview/demo1.mp4", alt="Coordinate Load Option video", controls=true, loop=true, autoplay=true, muted=true) }}

## 主要功能

* 服裝卡讀取處，多一個選項盤可以選擇性載入服裝
* **ABMX 的獨立選擇項**
* 飾品:
  * 取代模式: 複寫同一欄位的飾品
  * 增加模式: 往空欄位依序附加上去
  * **清除飾品: 一鍵清除角色當前服裝的所有飾品**
  * **鎖定頭髮飾品: 可將頭髮飾品鎖定，使之不會受到清除和複寫**
  * 反選頭髮飾品: 一鍵反向選擇所有頭髮飾品
* 不展開選擇項即會調用原始換衣程式
<!-- more -->
## 支援插件 {#compatible_plugins}

> 請確認環境滿足以下條件

### Koikatu

* Koikatu Overlay Mods v5.2
* Koikatu ABMX V4.4.4
* Koikatu More Accessories **v1.1.0** (不支援 v1.0.X，v2.X 未知)
* Koikatu MaterialEditor **v2.5** (不支援 v2.4)
* Koikatu HairAccessoryCustomizer v1.1.5
* Koikatu Chara Overlays Based On Coordinate **v1.3.6** (不支援 v1.3.3)

### Koikatsu Sunshine

* Overlay Mods v6.0.4
* ABMX V4.4.4
* More Accessories **v2**.0.10 (不支援 v1.X)
* MaterialEditor v3.1.10
* HairAccessoryCustomizer v1.1.6
* KKS MoreOutfits v1.1

## 常見問題和兼容性

### IllusionModdingAPI (KKAPI、KKSAPI)

如果你在 Maker 中遇到 (依賴於 IllusionModdingAPI 的) 插件報錯，請安裝 IllusionFixes.NullChecks 以繞過它。

換衣服的實作是先讀衣裝存檔到假人身上，再把需要的部份扒過來。  
而 IllusionModdingAPI 設計為「在 Maker 中只會載入一個角色」，這導致依賴於它的插件無法成功初始化假人。  
如果你碰到問題請試著安裝 [IllusionFixes.NullChecks](https://github.com/IllusionMods/IllusionFixes/releases/latest)，它可以簡單的繞過問題。因假人不使用到其它未支援的插件資料，它們的初始化失敗並不影響到換衣成果。

**IllusionFixes.NullChecks 並不是此插件的依賴，但它可以繞過 IllusionModdingAPI 的設計缺陷。**

### 其它飾品功能插件 (絕大多數為 Madevil 製)

在某些飾品插件的功能設計中，是不能允許飾品被分開載入的。部份讀取飾品們會導致那些插件資料被拆散。  
這不是一個新的限制，而是保險措施。**總是有人不理解自己在做什麼，然後把它做為 bug 回報。**

在衣裝存檔或角色上偵測到下列插件之擴充資料時，{{cr(body="將禁用飾品的選擇項功能")}}。

內建清單:

* madevil.kk.ass
* madevil.kk.mr
* madevil.kk.ca
* BonerStateSync
* BendUrAcc
* madevil.kk.AAAPK

> 給其它開發者
>
> ---
> 如果需要**擴充**此清單，請修改 CoordinateLoadOption 的 Configuration Setting: "Plugin that bound accessories options"  
> 填入其它插件的 GUID，以逗點「,」分隔

### Coordinate Load ended unexpectedly

請確認環境滿足[「支援插件」](#compatible_plugins)所寫條件  
很重要所以我再寫一遍

{% alert(caution=true) %}
Coordinate Load ended unexpectedly.

請確認環境滿足[「支援插件」](#compatible_plugins)所寫條件
{% end %}

## 衝突插件

* KK\_**Clothes**LoadOption (列為不兼容，功能重覆，請將之移除)
* Koikatu Studio Coordinate Load Option (列為不兼容，此為插件更名，請移除此舊插件)

{% alert(note=true) %}
關於 KK\_**Coordinate**LoadOption 和 KK\_**Clothes**LoadOption 之差異說明

---
KK\_ClothesLoadOption (56e4\_xXVv): 實作了遊戲內服裝、飾品資料的拆分讀取  
KK\_CoordinateLoadOption (**我**): 實作了遊戲內服裝、飾品資料的拆分讀取，除此之外也處理[支援插件](#compatible_plugins)的插件資料，包括 HairAccessoryCustomizer 數據、 Material Editor 數據、 More\_Accessories 數據等

在 KK 的原始設計中，服裝卡一次只能讀入一整套，並且大多數的插件也是搭建在此設計之上。為了實現部份讀取，我只能在外部拆分各支援插件的儲存資料。實際上，本插件的大部份程式碼都是在實作和其它插件之間的兼容處理，而這也是為什麼它在支援插件的版本不匹配時容易發生故障。

至於 56e4\_xXVv 開發的 KK\_ClothesLoadOption 狀況就不一樣了，{{cr(body="它完全沒有處理任何插件資料")}}。你的插件資料依然是以整套服裝為單位在讀寫，符合其它插件開發者的設計，自然也就有可能較少出現錯誤紅字。{{cr(body="但是沒有錯誤不代表沒有發生問題，因為你的插件資料和遊戲服裝並不匹配。")}}

我相信你只有在兩種情境之下會發現它工作得更好: 當你的遊戲中不存在任何[支援插件](#compatible_plugins)時；以及你沒有能力判斷你的插件資料是否缺失時。
{% end %}

## 需求依賴

### Koikatu

* コイカツ！ ダークネス (Koikatu! Darkness)  
  這不相容於 Steam Koikatsu Party
* **BepInEx v5.4.5** (不支援 v5.3)
* BepisPlugins r16.2

### Koikatsu Sunshine

* **BepInEx v5.4.15**
* BepisPlugins r16.4

## 安裝方式

參考壓縮檔結構，將文件放進「BepInEx/plugins/jim60105」資料夾之下

## 下載位置

<https://cloud.maki0419.com/s/c53d9Cqo4cSG4cy>
