+++
title = "以 VMware 運行實體系統(並非轉虛擬)"
description = "以 VMware 運行實體系統(並非轉虛擬)"
date = 2015-02-28T04:13:00.002Z
updated = 2015-02-28T04:13:00.002Z
draft = false
aliases = [ "/2015/02/VMwareRunningPhysicalSystem.html" ]

[extra]
featured = true
banner = "2015-02-28 07 35 58.png"

[taxonomies]
tags = [ "Linux", "System Admin" ]
+++

[![](2015-02-28%2007%2035%2058.png)](2015-02-28%2007%2035%2058.png)

## 寫作緣由

跟辦公室環境有關，個人每天有數小時必須使用公司的公用電腦。那台電腦大家都在用，桌面堆滿不知名連結 / 資料夾~~，就像肉O器的正正正正正一樣~~  
所以我就拿了一顆行動硬碟灌了 Arch 帶著走\~ ((自己的老婆自己顧 ( ･ิω･ิ)  
回家要調教系統總是得把電腦開開關關，Del 連打，感覺總有一天硬碟會被我操壞 (\`・ω・´)  
就開始研究 <mark>Win7</mark> ← <mark>VMware</mark> ← <mark>實體 Arch</mark> 的運行可能性

問我為什麼不用 VirtualBox?  
自從嘗試 Genymotion 以來，我的 Win7 要用 VirtualBox 總是跳不知名 ERROR....

{% alert (caution=true) %}
※此篇只用於紀錄方法，其中原理及除錯本人不解答  
※硬碟請妥善備份，任何資料遺失本人概不負責  
{% end %}
<!-- more -->
## 環境準備

HOST: Win7 (示範: 旗艦 SP1) 電腦

[![](2015-02-28%2010%2039%2010.png)](2015-02-28%2010%2039%2010.png)

VM: VMware Player (示範：7.0.0 build-2305329): [官方載點](https://my.vmware.com/web/vmware/free#desktop%5Fend%5Fuser%5Fcomputing/vmware%5Fplayer/7%5F0)

[![](2015-02-28%2007%2005%2042.png)](2015-02-28%2007%2005%2042.png)

Client: 裝在硬碟中的 Arch

[![](2015-02-28%2007%5E6%5E7%20%E7%9A%84%E8%9E%A2%E5%B9%95%E6%93%B7%E5%9C%96.png)](2015-02-28%2007%5E6%5E7%20%E7%9A%84%E8%9E%A2%E5%B9%95%E6%93%B7%E5%9C%96.png)

## Client 端系統準備

※久未更新 pacman 者先執行:

```bash
sudo pacman -Syu --needed
```

{% alert(tip=true) %}
pacman 後面加上 "--needed" 參數可節省很多時間
{% end %}

1. 安裝編譯環境:

   ```bash
   sudo pacman -S  base-devel net-tools linux-headers
   ```

2. 安裝 VMware-tool:

   ```bash
   packer -S open-vm-tools-dkms open-vm-tools
   ```

3. 安裝顯示驅動

   ```bash
   sudo pacman -S xf86-input-vmmouse xf86-video-vmware mesa
   ```

4.. 確認 GRUB 內有 "fallback" 開機選項 (本人使用 BURG，請忽略)

[![](2015-02-28%2007%5ER%5EA%20%E7%9A%84%E8%9E%A2%E5%B9%95%E6%93%B7%E5%9C%96.png)](2015-02-28%2007%5ER%5EA%20%E7%9A%84%E8%9E%A2%E5%B9%95%E6%93%B7%E5%9C%96.png)

## HOST 端，開工

確認把 VMware 安裝妥當後，新建 VM

[![](2015-02-28%2007%2056%2054.png)](2015-02-28%2007%2056%2054.png)

系統稍後再裝\~((其實已經裝好惹

[![](2015-02-28%2007%2057%2003.png)](2015-02-28%2007%2057%2003.png)

選 Other→Other

[![](2015-02-28%2007%2057%2018.png)](2015-02-28%2007%2057%2018.png)

名字隨便給，認得出來就好 (這張圖跳過)

VM 切到最小，這個虛擬硬碟完全用不到\~

[![](2015-02-28%2007%2057%2055.png)](2015-02-28%2007%2057%2055.png)

Customize 可以不用調，等會還要再改一次  
{{cr(body="Finish 以後先別啟動")}}

[![](2015-02-28%2008%2000%2047.png)](2015-02-28%2008%2000%2047.png)

選到剛剛創建的 VM，進入編輯

[![](2015-02-28%2008%2001%2004.png)](2015-02-28%2008%2001%2004.png)

順手先把 Shared Folders 設定好 ((之後再弄也可以

[![](2015-02-28%2008%2033%2055.png)](2015-02-28%2008%2033%2055.png)

Hardware 標籤下方按 "Add"

[![](2015-02-28%2008%2001%2017.png)](2015-02-28%2008%2001%2017.png)

新增 HDD

[![](2015-02-28%2008%2001%2025.png)](2015-02-28%2008%2001%2025.png)

這裡以 Recommended 為主，IDE/SATA 每個人可能會不同 (待驗證)

[![](2015-02-28%2008%2001%2032.png)](2015-02-28%2008%2001%2032.png)

選實體硬碟

[![](2015-02-28%2008%2001%2038.png)](2015-02-28%2008%2001%2038.png)

接著我們要確定哪個硬碟是哪個，避免選錯  
Device 從頭 / 從尾開始選，選第二項看詳情

[![](2015-02-28%2008%2001%2055.png)](2015-02-28%2008%2001%2055.png)

因為外接硬碟通常都在最後，於是我從後面開始試  
確認是我的 Arch 硬碟無誤後，{{cr(body="按 BACK")}}

[![](2015-02-28%2008%2002%2010.png)](2015-02-28%2008%2002%2010.png)

選擇整顆硬碟，這才是正確的模式

[![](2015-02-28%2008%2002%2019.png)](2015-02-28%2008%2002%2019.png)

CPU\&RAM 的部分自己斟酌，給太小裡面會很 LAG，給太大外面會很 LAG  
最後再次確認是選到整顆硬碟

[![](2015-02-28%2008%2003%2054.png)](2015-02-28%2008%2003%2054.png)

> 接下來就是考驗手速的時刻 (・̀ω・́)✧

啟動以後  
看到下面這畫面的瞬間請按 ESC 或 F2，只能按一次喔\~  
連擊會失敗\~

[![](2015-02-28%2008%2004%2014.png)](2015-02-28%2008%2004%2014.png)

如果是按 ESC 要接著選這項，F2 直接跳過此步驟

[![](2015-02-28%2008%2005%2037.png)](2015-02-28%2008%2005%2037.png)

到 BOOT 這頁按 "+" 把 (PM) 這個按到上面去，也有可能是其他名字，總之多試試\~  
最後 F10-Save\&Exit

[![](2015-02-28%2008%2006%2016.png)](2015-02-28%2008%2006%2016.png)

接著 VM 會自動重啟  
看到 GRUB 就表示硬碟讀到拉\~\~\~  
沒出現的再回去 Check 看看是不是選錯硬碟  
以 fallback 模式開機

[![](2015-02-28%2008%2006%2044.png)](2015-02-28%2008%2006%2044.png)

最後出現 clean 這行代表讀到系統碟惹  
※piix4 error 見文末

[![](2015-02-28%2008%2007%2003.png)](2015-02-28%2008%2007%2003.png)

> ｡:.ﾟヽ (\*´∀\`)ﾉﾟ.:｡作戰成功｡:.ﾟヽ (´∀\`\*)ﾉﾟ.:｡

[![](2015-02-28%2008%2007%2056.png)](2015-02-28%2008%2007%2056.png)

## 成功啟動系統後\~

1. 在系統內啟動 VMwareTool 服務:

   ```bash
   sudo systemctl enable vmtoolsd.service
   ```

2. 設定 Shared Folders:

   1. 首先建立掛載點:

      ```bash
      sudo mkdir /mnt/vmware
      ```

   2. 將 Shared Folders 掛上去:

      ```bash
      #這三行每次掛載都要執行
      vmware-hgfsclient  #顯示可掛載的目錄
      sudo modprobe vmhgfs  #可寫進mkinitcpio.conf開機執行
      sudo mount -t vmhgfs .host:/ /mnt/vmware  #可寫進fstab開機掛載
      ```

      {% alert(tip=true) %}
      我是寫了 sh 檔跑這三行
      {% end %}

## Troubleshooting

### piix4\_smbus host smbus controller not enabled

[![](2015-02-24%2006%2016%2026.png)](2015-02-24%2006%2016%2026.png)

遇到這行，代表系統嘗試載入 piix4 驅動模組失敗，因為 VM 並沒有這個東西

解法如下:

```bash
sudo vim /etc/modprobe.d/blacklist.conf
```

在 blacklist.conf 裡面加上

```config
blacklist i2c_piix4
```

再存檔離開即可

## 參考資料

1. Installing Arch Linux in VMware - ArchWiki <https://wiki.archlinux.org/index.php/Installing%5FArch%5FLinux%5Fin%5FVMware>
2. 修复 piix4\_smbus Host SMBus controller not enabled 错误  
   <http://winotes.net/fixing-piix4-host-smbus-controller-not-enabled-error-for-centos-on-vmware.html>
