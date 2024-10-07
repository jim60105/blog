+++
title = "Bananapi 香蕉派M3 ArchLinux 支援BPI7吋LCD輸出之鏡像"
description = "Bananapi 香蕉派M3 ArchLinux 支援BPI7吋LCD輸出之鏡像"
date = 2016-03-12T13:33:00.003Z
updated = 2020-11-24T14:56:53.459Z
draft = false
aliases = [ "/2016/03/bananapi-m3-archlinux-7lcd.html" ]

[taxonomies]
tags = [ "bananapi" ]

[extra]
banner = "https://2.bp.blogspot.com/-uTvS5VOfIT8/VuQVZ4Fry4I/AAAAAAAAK8I/KDxmvPaKVKMU2wuSYEv86VkO_WZN94W1w/s640/IMG_20160312_142441.jpg"
+++
[![](https://2.bp.blogspot.com/-uTvS5VOfIT8/VuQVZ4Fry4I/AAAAAAAAK8I/KDxmvPaKVKMU2wuSYEv86VkO_WZN94W1w/s640/IMG_20160312_142441.jpg)](https://2.bp.blogspot.com/-uTvS5VOfIT8/VuQVZ4Fry4I/AAAAAAAAK8I/KDxmvPaKVKMU2wuSYEv86VkO%5FWZN94W1w/s1600/IMG%5F20160312%5F142441.jpg)
  
  
香蕉派M3，硬體夠強但是官方系統支援現在還不夠 爬了一下文決定自己搞w  

## **載點**

Google: <https://drive.google.com/open?id=0B-LfCSS6uQyuOUlSaHJIV0EwY0k>  

## 特色

1. 以官方釋出之[BPI-M3-bsp](https://github.com/BPI-SINOVOIP/BPI-M3-bsp)進行編譯
2. 搭配"[2015-12-09-ArchLinuxARM-lite-bpi-m3-sd-emmc.img](http://forum.banana-pi.org/t/bpi-m3-new-image-archlinuxarm-lite-for-bpi-m3-20151209/850)"進行Cross-Compile
3. 以官方7吋LCD進行畫面輸出
4. 縮小/dev/sdx2之大小至5.4G，確保8G SD卡都能裝的下

## 使用方法

* Windows:

使用Win32DiskImager寫入記憶卡

* Unix/Linux/BSD:

dd if=arch_LCD7_20160312.img of=/dev/sdx bs=1M

(覆蓋/dev/sdx為你的記憶卡位置)

詳見: <https://bananapi.gitbooks.io/bpi-m3/content/howtoburnlinuximagetoemmc.html>

  
寫入完成後，請用resize2fs擴大/dev/sdx2之容量為記憶卡最大大小

方法詳見: <http://banoffeepiserver.com/resize-the-root-file-system-partition.html>

## 已知問題

那個藍底螢幕不知道怎麼調啊\~

## 參考資料

1. How to burn Linux image to eMMC | Banana pi BPI-M3 octa-core single board computer  
<https://bananapi.gitbooks.io/bpi-m3/content/howtoburnlinuximagetoemmc.html>
2. GitHub - BPI-SINOVOIP/BPI-M3-bsp: Supports BananaPi BPI -M3 (Kernel3.4)  
<https://github.com/BPI-SINOVOIP/BPI-M3-bsp>
3. 乐美客轻松编译香蕉派u-boot及内核(适用于Lubuntu3.0)\_Banana Pro/Pi常规讨论\_乐美客开发板论坛|LeMaker  
<http://forum.lemaker.org/cn/thread-426-1-1.html>
4. 放大或縮小 Linux 分割區 – 煎炸熊の記事本  
<http://note.artchiu.org/2009/12/25/%E6%94%BE%E5%A4%A7%E6%88%96%E7%B8%AE%E5%B0%8F-linux-%E5%88%86%E5%89%B2%E5%8D%80/>
5. Resize the root partition  
<http://banoffeepiserver.com/resize-the-root-file-system-partition.html>