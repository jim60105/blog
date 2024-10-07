+++
title = "通過Fortigate看Youtube很LAG？"
description = "通過Fortigate看Youtube很LAG？"
date = 2021-12-05T14:11:00.008Z
updated = 2022-01-01T18:52:47.804Z
draft = false
aliases = [ "/2021/12/fortigate-passthrough-youtube.html" ]

[taxonomies]
tags = [ "Livestream" ]

[extra]
banner = "https://img.maki0419.com/blog/fortigate-Youtube/preview.jpg"
+++
![](https://img.maki0419.com/blog/fortigate-Youtube/preview.jpg)

## 前言

![](https://img.maki0419.com/blog/fortigate-Youtube/fortigate.jpg)

前幾天重新規劃了家裡的網路架構，買了一台Fortigate FG-50E防火牆擋在前面。我遇到一個問題——Youtube直播在經過網頁過濾功能(Web Filter)時異常的慢。慢到什麼程度？播三秒卡轉圈，卡了十秒再播三秒，鬼才看得下去。所以我決定把Youtube流量設Policy，使之不經過任何資安過濾功能，最大的確保觀看影片時的流暢性。在設定時有幾個注意點，我想用這篇文記錄下來。

**這必定會犠牲掉一點安全性，請自行評估是否值得。**

## 新增位址物件

![](https://img.maki0419.com/blog/fortigate-Youtube/1.png)

分別新增以下位址物件:

* www.youtube.com
* signaler-pa.youtube.com
* yt3.ggpht.com
* yt4.ggpht.com
* \*.googlevideo.com

類型為FQDN，介面any，不選Show in address list

![](https://img.maki0419.com/blog/fortigate-Youtube/2.png)

新增位址群組，把剛新增的所有位址物件加進去，勾上Show in address list

![](https://img.maki0419.com/blog/fortigate-Youtube/3.png)

如果你有IPv6，那麼也要新增一套IPv6位址物件 (Youtube站台支援IPv6，會優先走IPv6)

![](https://img.maki0419.com/blog/fortigate-Youtube/9.png)

## 新增服務: QUIC

Chromium base瀏覧器支援QUIC協定，這用在大部份的Google相關網站上，包括Youtube  
詳情請見[Wiki](https://zh.wikipedia.org/wiki/QUIC)說明  
QUIC協定在效能上較佳，但防火牆無法監控它  
我的情況不需要監控Client端，所以我將QUIC開放

![](https://img.maki0419.com/blog/fortigate-Youtube/4.png)

新增服務: QUIC

目的埠號: UDP 80  
UDP 443  

## 新增政策

新增一條政策: Youtube

![](https://img.maki0419.com/blog/fortigate-Youtube/5.png)

![](https://img.maki0419.com/blog/fortigate-Youtube/6.png)

進入介面: lan  
離開介面: wan  
來源: all  
目的: YoutubeGroup (前面建立的位址群組)  
服務: HTTPS、QUIC (前面建立的服務)  
檢測模式: Flow-based  
資安管理設定:**(全不選)**

這條政策要放在lan to wan之上，讓Youtube流量匹配進去，如此來自Youtube的連線就會不做任何檢查，直接通過政策  

![](https://img.maki0419.com/blog/fortigate-Youtube/7.png)

如果你有IPv6，那麼也要新增一套IPv6位址物件 (Youtube站台支援IPv6，會優先走IPv6)

![](https://img.maki0419.com/blog/fortigate-Youtube/10.png)

設定完成後請開幾個影片，並觀察FortiView政策是否有匹配進剛剛新增的政策

![](https://img.maki0419.com/blog/fortigate-Youtube/8.png)