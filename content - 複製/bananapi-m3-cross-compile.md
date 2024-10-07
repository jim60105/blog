+++
title = "Bananapi 香蕉派M3 Cross Compile 教學"
description = "Bananapi 香蕉派M3 Cross Compile 教學"
date = 2016-03-22T18:47:00.002Z
updated = 2020-11-24T14:56:53.456Z
draft = false
aliases = [ "/2016/03/bananapi-m3-cross-compile.html" ]

[taxonomies]
tags = [ "bananapi" ]

[extra]
banner = "https://1.bp.blogspot.com/-qXx5Z1dZZPA/VvHvJz2hUsI/AAAAAAAAK9k/7hA6_Vmas_g3W_mw6p5Mo_FnPGdT_FJcw/s640/IMG_20160323_091652.jpg"
+++
##  前言

[![](https://1.bp.blogspot.com/-qXx5Z1dZZPA/VvHvJz2hUsI/AAAAAAAAK9k/7hA6_Vmas_g3W_mw6p5Mo_FnPGdT_FJcw/s640/IMG_20160323_091652.jpg)](https://1.bp.blogspot.com/-qXx5Z1dZZPA/VvHvJz2hUsI/AAAAAAAAK9k/7hA6%5FVmas%5Fg3W%5Fmw6p5Mo%5FFnPGdT%5FFJcw/s1600/IMG%5F20160323%5F091652.jpg)

之前寫了這篇： [Jim: Bananapi 香蕉派M3 ArchLinux 支援BPI7吋LCD輸出之鏡像](http://blog.jim60105.com/2016/03/bananapi-m3-archlinux-7lcd.html)  
想想還是要把步驟記錄下來，不然很快就會忘了(´-ω-｀)  
  
先展示下我的系統配置：  

jim@jim-Ubuntu:~$ uname -a
Linux jim-Ubuntu 4.2.0-34-generic #39-Ubuntu SMP Thu Mar 10 22:13:01 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

  
開工  
  
## 編譯BPI-M3-bsp

> BSP 是 “Board Support Package”，板级支持包的意思，包含了编译内核，U-boot等等所需要的一切工具，至于U-Boot，你可以理解为Linux下的Grub或者Windows下的NT OS Loader。
>
> ──引用至[這裡](http://forum.lemaker.org/cn/thread-426-1-1.html)

建立bsp存放資料夾，並git clone回來： <https://github.com/BPI-SINOVOIP/BPI-M3-bsp>  

mkdir bananapi
cd bananapi
git clone https://github.com/BPI-SINOVOIP/BPI-M3-bsp.git

  
※本文撰寫時間點：20160323  
官方的bsp有一個bug，我已經提出issue，目前尚未解決： <https://github.com/BPI-SINOVOIP/BPI-M3-bsp/issues/7>  
程式執行中會存取一個尚未建立的資料夾  
事先手動建立此資料夾即可迴避此error  

cd BPI-M3-bsp
mkdir -p linux-sunxi/output/lib/firmware

  
\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
若是64位元系統，必須執行這一段  
因為bpi官方在編譯相關套件時是使用32位元系統，所以若你使用64位元Ubuntu，必須增加系統支援32位元執行檔  

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386

\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  
  
安裝必要之工具(若是在64位元那段執行過那兩條指令，則可省略)  

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential u-boot-tools binutils-arm-linux-gnueabihf gcc-4.7-arm-linux-gnueabihf-base g++-4.7-arm-linux-gnueabihf gcc-arm-linux-gnueabihf gcc-arm-linux-gnueabi cpp-arm-linux-gnueabihf libusb-1.0-0 libusb-1.0-0-dev git wget fakeroot kernel-package zlib1g-dev libncurses5-dev

  
開始編譯  

./build.sh

  
接著會出現選擇畫面，這次我的目標是要在BPI7吋LCD上使用，所以選3  

==========================================
            BPI-M3 BSP Build Tool         
==========================================

This tool support following BPI board(s):
------------------------------------------
1. BPI_M3_720P
2. BPI_M3_1080P
3. BPI_M3_LCD7
4. BPI_M3_USB_720P
5. BPI_M3_USB_1080P
6. BPI_M3_USB_LCD7
------------------------------------------
Please choose a target(1-6): 3


Now configuring...

BPI_M3_LCD7 configured. Now run `make`

Configure success!

  
接著選擇要執行的動作，選1  

This tool support following building mode(s):
--------------------------------------------------------------------------------
1. Build all, uboot and kernel and pack to download images.
2. Build uboot only.
3. Build kernel only.
4. kernel configure.
5. Build rootfs for linux, and copy target files to output
  ROOTFS=/xxx/rootfs.tar.gz
  This is optinal, default using rootfs/linux/default_linux_rootfs.tar.gz.
6. Pack the builds to target download image, this step must execute after u-boot,
    kernel and rootfs build out
7. Clean all build.
--------------------------------------------------------------------------------
Please choose a mode(1-6): 1

  
這段會跑蠻久的，視你的電腦效能而定\~\~  
  
當你看到這個畫面就是成功了  

[![](https://4.bp.blogspot.com/-IDlAfV-2Lfc/VvHCnebPsyI/AAAAAAAAK8c/gu4fJPBXbsUgBYqYpWm1WMJ1zmE98A72w/s640/2016-03-23%2B06-08-52%2B%25E7%259A%2584%25E8%259E%25A2%25E5%25B9%2595%25E6%2593%25B7%25E5%259C%2596.png)](https://4.bp.blogspot.com/-IDlAfV-2Lfc/VvHCnebPsyI/AAAAAAAAK8c/gu4fJPBXbsUgBYqYpWm1WMJ1zmE98A72w/s1600/2016-03-23%2B06-08-52%2B%25E7%259A%2584%25E8%259E%25A2%25E5%25B9%2595%25E6%2593%25B7%25E5%259C%2596.png)

  
沒有出現的話，其他Build success!都是騙你w  
那是Build finish的意思ww  

| [![](https://4.bp.blogspot.com/-e20pAZEEALU/VvHoqRKqCSI/AAAAAAAAK9U/xZ222ci7RFAjXP0wkbrBV5hoU2VR6vZqw/s320/1375960887-3441910111.png)](https://4.bp.blogspot.com/-e20pAZEEALU/VvHoqRKqCSI/AAAAAAAAK9U/xZ222ci7RFAjXP0wkbrBV5hoU2VR6vZqw/s1600/1375960887-3441910111.png) |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 騙你wwwwwww                                                                                                                                                                                                                                                              |

  
## 燒錄鏡像至記憶卡

找張記憶卡，把官方鏡像刷進去： <http://www.banana-pi.org/download.html>  
  
接下來的步驟，務必選到正確的裝置  
**※此記憶卡必定會清空，若有任何遺失本人概不負責※**  

sudo fdisk -l

  
此處確認我的裝置是/dev/sdf  

[![](https://1.bp.blogspot.com/-mZFrW4q29IE/VvHMlRVYPlI/AAAAAAAAK8s/Iu2cA5QwBuEKXC3uWizv7WRIl7-5Ap0qw/s640/2016-03-23%2B06-49-30%2B%25E7%259A%2584%25E8%259E%25A2%25E5%25B9%2595%25E6%2593%25B7%25E5%259C%2596.png)](https://1.bp.blogspot.com/-mZFrW4q29IE/VvHMlRVYPlI/AAAAAAAAK8s/Iu2cA5QwBuEKXC3uWizv7WRIl7-5Ap0qw/s1600/2016-03-23%2B06-49-30%2B%25E7%259A%2584%25E8%259E%25A2%25E5%25B9%2595%25E6%2593%25B7%25E5%259C%2596.png)
  
  
卸載磁碟  

umount /dev/sdf*

  
清空裝置  

sudo fdisk /dev/sdf
p
d
w
sync

請用d把partition砍光  
  
然後把裝置徹底清掉  

dd if=/dev/zero of=/dev/sdf bs=4M

> 小推薦  
> 可以到[這裡](https://github.com/Xfennec/progress)安裝progress觀看dd進度

刷入官方提供之鏡像檔，請選Android跟Berryboot以外的傢伙  
此處我以ArchLinux為例  
至[此網頁](http://forum.banana-pi.org/t/bpi-m3-new-image-archlinuxarm-lite-for-bpi-m3-20151209/850)下載檔案，我載到的檔案是"2015-12-09-ArchLinuxARM-lite-bpi-m3-sd-emmc.img.zip"  
  
解壓縮並寫入記憶卡  

unzip 2015-12-09-ArchLinuxARM-lite-bpi-m3-sd-emmc.img.zip -d ~
cd ~
sudo dd if=2015-12-09-ArchLinuxARM-lite-bpi-m3-sd-emmc.img of=/dev/sdf bs=4M

  
接著又得等待一段時間～  
不要以為dd沒回饋就把他砍掉囉  
  
編譯結束後，系統可能會自動掛載  
若有，則執行卸載  

umount /dev/sdf*

  
檢查partition  

sudo fsck /dev/sdf1
sudo fsck /dev/sdf2

  
將/dev/sdf2降為ext2，等下順便改大小  

sudo tune2fs -O ^has_journal /dev/sdf2
sudo e2fsck -f /dev/sdf2

  
## 寫入最剛開始編譯好的資料

下一步驟將會清除partition table，所以我們必須先抄下來  

[![](https://3.bp.blogspot.com/-T_ZsqYkm5UA/VvHbCRJkAvI/AAAAAAAAK88/IbAYUK-vk6cu0KkyK3k55Afscrag_B-5A/s640/2016-03-23%2B07-53-26%2B%25E7%259A%2584%25E8%259E%25A2%25E5%25B9%2595%25E6%2593%25B7%25E5%259C%2596.png)](https://3.bp.blogspot.com/-T%5FZsqYkm5UA/VvHbCRJkAvI/AAAAAAAAK88/IbAYUK-vk6cu0KkyK3k55Afscrag%5FB-5A/s1600/2016-03-23%2B07-53-26%2B%25E7%259A%2584%25E8%259E%25A2%25E5%25B9%2595%25E6%2593%25B7%25E5%259C%2596.png)

  
前往我們剛編譯好的東西存放的資料夾  

cd ~/bananapi/BPI-M3-bsp/download/BPI_M3_LCD7

  
底下應該存在這些東西  

[![](https://4.bp.blogspot.com/-uUoZxHhVECM/VvHcL-MuOII/AAAAAAAAK9E/DCMoGkcxZmMF_ZOhKguBRPMZSpZPWNR3w/s640/2016-03-23%2B07-57-54%2B%25E7%259A%2584%25E8%259E%25A2%25E5%25B9%2595%25E6%2593%25B7%25E5%259C%2596.png)](https://4.bp.blogspot.com/-uUoZxHhVECM/VvHcL-MuOII/AAAAAAAAK9E/DCMoGkcxZmMF%5FZOhKguBRPMZSpZPWNR3w/s1600/2016-03-23%2B07-57-54%2B%25E7%259A%2584%25E8%259E%25A2%25E5%25B9%2595%25E6%2593%25B7%25E5%259C%2596.png)

  
清空記憶卡前1M的空間(同時會清空partition table)  

sudo dd if=/dev/zero of=/dev/sdf bs=1M count=1

  
依序寫入編譯好的檔案  

sudo dd if=boot0_sdcard.fex of=/dev/sdf bs=1k seek=8
sudo dd if=u-boot.fex of=/dev/sdf bs=1k seek=19096
sudo dd if=sunxi_mbr.fex of=/dev/sdf bs=1k seek=20480
sudo dd if=boot-resource.fex of=/dev/sdf bs=1k seek=36864
sudo dd if=env.fex of=/dev/sdf bs=1k seek=69632
sudo dd if=boot.fex of=/dev/sdf bs=1k seek=86016

  
復原partition table，並增大容量至記憶卡最大，再恢復/dev/sdf2格式  

sudo fdisk /dev/sdf
p
n
p
1
204800
729087
t
c
n
p
2
729088
#這裡直接Enter，default會取到空間最大
w
sync
sudo fsck /dev/sdf1
sudo fsck /dev/sdf2
sudo resize2fs /dev/sdf2
sudo tune2fs -j /dev/sdf2
sudo e2fsck -f /dev/sdf2

  
至此，所有工作就結束了  
拿到你的bananapi上去試試看吧  
ヽ(∀ﾟ )人(ﾟ∀ﾟ)人( ﾟ∀)人(∀ﾟ )人(ﾟ∀ﾟ)人( ﾟ∀)ﾉ  
  
## 參考資料

1. 乐美客轻松编译香蕉派u-boot及内核(适用于Lubuntu3.0)\_Banana Pro/Pi常规讨论\_乐美客开发板论坛|LeMaker  
<http://forum.lemaker.org/cn/thread-426-1-1.html>
2. Cross－Compile BnnPi's u-boot & kernel - General discussion - LeMaker | The Open Source SBCs Community  
<http://forum.lemaker.org/thread-1706-1-1-%5Fcopy%5Fthis%5Flink%5Fto%5Fquote%5F.html>
3. BPI-SINOVOIP/BPI-M3-bsp: Supports BananaPi BPI -M3 (Kernel3.4)  
<https://github.com/BPI-SINOVOIP/BPI-M3-bsp>
4. 放大或縮小 Linux 分割區 – 煎炸熊の記事本  
<http://note.artchiu.org/2009/12/25/%E6%94%BE%E5%A4%A7%E6%88%96%E7%B8%AE%E5%B0%8F-linux-%E5%88%86%E5%89%B2%E5%8D%80/>
5. Xfennec/progress: Linux tool to show progress for cp, mv, dd, ... (formerly known as cv)  
<https://github.com/Xfennec/progress>
6. Banana Pi BPI operating system downloads  
<http://www.banana-pi.org/download.html>
7. Learn-Git-in-30-days/docs at master · doggy8088/Learn-Git-in-30-days  
<https://github.com/doggy8088/Learn-Git-in-30-days/tree/master/docs>
  
  
> Jim: Bananapi 香蕉派M3 Cross Compile 教學http://blog.jim60105.com/2016/03/bananapi-m3-cross-compile.html把上次的步驟詳細的寫了下來然後又耗掉了一個晚上順便還回覆了一個簡單的issue...  
> 由[陳鈞](https://www.facebook.com/jim60105)貼上了 [2016年3月22日](https://www.facebook.com/jim60105/posts/1156203164399293)