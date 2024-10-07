+++
title = "以VMware運行實體系統(並非轉虛擬)"
description = "以VMware運行實體系統(並非轉虛擬)"
date = 2015-02-28T04:13:00.002Z
updated = 2020-11-24T14:56:53.459Z
draft = false
aliases = ["/2015/02/VMwareRunningPhysicalSystem.html"]

[taxonomies]
tags = []

[extra]
banner = "https://4.bp.blogspot.com/-jaH8otuNfZY/VPFDP8VlJoI/AAAAAAAAKnE/ojEZdLlzFPg/s1600/2015-02-28%2B07%2B35%2B58.png"
+++
[![](https://4.bp.blogspot.com/-jaH8otuNfZY/VPFDP8VlJoI/AAAAAAAAKnE/ojEZdLlzFPg/s1600/2015-02-28%2B07%2B35%2B58.png)](http://4.bp.blogspot.com/-jaH8otuNfZY/VPFDP8VlJoI/AAAAAAAAKnE/ojEZdLlzFPg/s1600/2015-02-28%2B07%2B35%2B58.png)
  
  
## 寫作緣由

跟辦公室環境有關，個人每天有數小時必須使用公司的公用電腦。那台電腦大家都在用，桌面堆滿不知名連結/資料夾，就像肉O器的正正正正正一樣(X  
所以我就拿了一顆行動硬碟灌了Arch帶著走\~((自己的老婆自己顧( ･ิω･ิ)  
回家要調教系統總是得把電腦開開關關，Del連打，感覺總有一天硬碟會被我操壞(\`・ω・´)  
就開始研究"Win7"←"VMware"←"實體Arch"的運行可能性  
  
問我為什麼不用VirtualBox?  
自從嘗試Genymotion以來，我的Win7要用VirtualBox總是跳不知名ERROR....  
  
※此篇只用於紀錄方法，其中原理及除錯本人不解答  
※硬碟請妥善備份，任何資料遺失本人概不負責  
  
  
## 環境準備

HOST: Win7(示範:旗艦SP1)電腦  

[![](https://3.bp.blogspot.com/-RPVzRQxcK-8/VPExc_-H66I/AAAAAAAAKjo/vhG6-fBclyI/s1600/2015-02-28%2B10%2B39%2B10.png)](http://3.bp.blogspot.com/-RPVzRQxcK-8/VPExc%5F-H66I/AAAAAAAAKjo/vhG6-fBclyI/s1600/2015-02-28%2B10%2B39%2B10.png)

  
VM: VMware Player(示範:7.0.0 build-2305329): [官方載點](https://my.vmware.com/web/vmware/free#desktop%5Fend%5Fuser%5Fcomputing/vmware%5Fplayer/7%5F0)  

[![](https://2.bp.blogspot.com/-L31wkfv-yAs/VPD-0qMTQ9I/AAAAAAAAKjY/GkMU6o9g6CI/s1600/2015-02-28%2B07%2B05%2B42.png)](http://2.bp.blogspot.com/-L31wkfv-yAs/VPD-0qMTQ9I/AAAAAAAAKjY/GkMU6o9g6CI/s1600/2015-02-28%2B07%2B05%2B42.png)

  
Client:裝在硬碟中的Arch  

[![](https://2.bp.blogspot.com/-DOXhUs2iTJc/VPEx2rXB6iI/AAAAAAAAKjw/5KJeygFfSYU/s1600/2015-02-28%2B07%5E6%5E7%2B%E7%9A%84%E8%9E%A2%E5%B9%95%E6%93%B7%E5%9C%96.png)](http://2.bp.blogspot.com/-DOXhUs2iTJc/VPEx2rXB6iI/AAAAAAAAKjw/5KJeygFfSYU/s1600/2015-02-28%2B07%5E6%5E7%2B%E7%9A%84%E8%9E%A2%E5%B9%95%E6%93%B7%E5%9C%96.png)
  
  
## Client端系統準備

※久未更新pacman者先執行:

> sudo pacman -Syu --needed

((小技巧:pacman後面加上"--needed"參數可節省很多時間))  
  
  
1.安裝編譯環境:

> sudo pacman -S base-devel net-tools linux-headers

2.安裝VMware-tool:

> packer -S open-vm-tools-dkms open-vm-tools

3.安裝顯示驅動  

> sudo pacman -S xf86-input-vmmouse xf86-video-vmware mesa

  
4..確認GRUB內有"fallback"開機選項 (本人使用BURG，請忽略)  

[![](https://3.bp.blogspot.com/-BpXe5sqgxmU/VPEyH5tDVeI/AAAAAAAAKj4/S0P5AiG2Fsk/s1600/2015-02-28%2B07%5ER%5EA%2B%E7%9A%84%E8%9E%A2%E5%B9%95%E6%93%B7%E5%9C%96.png)](http://3.bp.blogspot.com/-BpXe5sqgxmU/VPEyH5tDVeI/AAAAAAAAKj4/S0P5AiG2Fsk/s1600/2015-02-28%2B07%5ER%5EA%2B%E7%9A%84%E8%9E%A2%E5%B9%95%E6%93%B7%E5%9C%96.png)
  
  
## HOST端，開工

確認把VMware安裝妥當後，新建VM  

[![](https://4.bp.blogspot.com/-hbPP6_7ovuY/VPEygqYD23I/AAAAAAAAKkI/3RwNHmm0YrA/s1600/2015-02-28%2B07%2B56%2B54.png)](http://4.bp.blogspot.com/-hbPP6%5F7ovuY/VPEygqYD23I/AAAAAAAAKkI/3RwNHmm0YrA/s1600/2015-02-28%2B07%2B56%2B54.png)

  
系統稍後再裝\~((其實已經裝好惹  

[![](https://4.bp.blogspot.com/-k5TmdiyFrAs/VPEygNkbWbI/AAAAAAAAKkA/Snw6SaEW9o0/s1600/2015-02-28%2B07%2B57%2B03.png)](http://4.bp.blogspot.com/-k5TmdiyFrAs/VPEygNkbWbI/AAAAAAAAKkA/Snw6SaEW9o0/s1600/2015-02-28%2B07%2B57%2B03.png)

  
選Other→Other  

[![](https://1.bp.blogspot.com/-uBClrYjE9l4/VPEyge21IKI/AAAAAAAAKkE/sJzwkGamwS8/s1600/2015-02-28%2B07%2B57%2B18.png)](http://1.bp.blogspot.com/-uBClrYjE9l4/VPEyge21IKI/AAAAAAAAKkE/sJzwkGamwS8/s1600/2015-02-28%2B07%2B57%2B18.png)

  
名字隨便給，認得出來就好(這張跳過)  
VM切到最小，這個虛擬硬碟完全用不到\~  

[![](https://3.bp.blogspot.com/-i5c8xRRSByM/VPEyhzt8uiI/AAAAAAAAKkY/URSNSPg1BdI/s1600/2015-02-28%2B07%2B57%2B55.png)](http://3.bp.blogspot.com/-i5c8xRRSByM/VPEyhzt8uiI/AAAAAAAAKkY/URSNSPg1BdI/s1600/2015-02-28%2B07%2B57%2B55.png)

  
Customize可以不用調，等會還要再改一次  
Finish以後先別啟動  

[![](https://1.bp.blogspot.com/-7nR5Q1HzWNs/VPEyiRCtDpI/AAAAAAAAKkc/4dpa_w5np0M/s1600/2015-02-28%2B08%2B00%2B47.png)](http://1.bp.blogspot.com/-7nR5Q1HzWNs/VPEyiRCtDpI/AAAAAAAAKkc/4dpa%5Fw5np0M/s1600/2015-02-28%2B08%2B00%2B47.png)

  
選到剛剛創建的VM，進入編輯  

[![](https://1.bp.blogspot.com/-u-TuIE8mJ5Q/VPEyjF20yaI/AAAAAAAAKko/z4Y4sTbPPlA/s1600/2015-02-28%2B08%2B01%2B04.png)](http://1.bp.blogspot.com/-u-TuIE8mJ5Q/VPEyjF20yaI/AAAAAAAAKko/z4Y4sTbPPlA/s1600/2015-02-28%2B08%2B01%2B04.png)

  
順手先把Shared Folders設定好((之後再弄也可以  

[![](https://3.bp.blogspot.com/-SpF_xVDUkSQ/VPE6HTVMccI/AAAAAAAAKmo/tPWycW52Qfc/s1600/2015-02-28%2B08%2B33%2B55.png)](http://3.bp.blogspot.com/-SpF%5FxVDUkSQ/VPE6HTVMccI/AAAAAAAAKmo/tPWycW52Qfc/s1600/2015-02-28%2B08%2B33%2B55.png)

  
Hardware標籤下方按"Add"  

[![](https://3.bp.blogspot.com/-4rZP9OhnV5U/VPEyj7fTdpI/AAAAAAAAKkw/iaNiWCpYRsg/s1600/2015-02-28%2B08%2B01%2B17.png)](http://3.bp.blogspot.com/-4rZP9OhnV5U/VPEyj7fTdpI/AAAAAAAAKkw/iaNiWCpYRsg/s1600/2015-02-28%2B08%2B01%2B17.png)
  
  
新增HDD  

[![](https://4.bp.blogspot.com/-n5XnHCxGIN0/VPEykUFyqGI/AAAAAAAAKk0/NQAFal0peio/s1600/2015-02-28%2B08%2B01%2B25.png)](http://4.bp.blogspot.com/-n5XnHCxGIN0/VPEykUFyqGI/AAAAAAAAKk0/NQAFal0peio/s1600/2015-02-28%2B08%2B01%2B25.png)
  
  
這裡以Recommended為主，IDE/SATA每個人可能會不同(待驗證)  

[![](https://1.bp.blogspot.com/-6ky4OltdV_w/VPEykjFFfYI/AAAAAAAAKk4/W2sywwAHVvs/s1600/2015-02-28%2B08%2B01%2B32.png)](http://1.bp.blogspot.com/-6ky4OltdV%5Fw/VPEykjFFfYI/AAAAAAAAKk4/W2sywwAHVvs/s1600/2015-02-28%2B08%2B01%2B32.png)
  
  
選實體硬碟  

[![](https://4.bp.blogspot.com/-5ilVDlxP5bA/VPEylO21b-I/AAAAAAAAKlI/Tx-v43UZtXY/s1600/2015-02-28%2B08%2B01%2B38.png)](http://4.bp.blogspot.com/-5ilVDlxP5bA/VPEylO21b-I/AAAAAAAAKlI/Tx-v43UZtXY/s1600/2015-02-28%2B08%2B01%2B38.png)
  
  
接著我們要確定哪個硬碟是哪個，避免選錯  
Device從頭/從尾開始選，選第二項看詳情  

[![](https://4.bp.blogspot.com/-ajeMc31Wl3A/VPEylgqEc0I/AAAAAAAAKlM/8nOTdMYIteA/s1600/2015-02-28%2B08%2B01%2B55.png)](http://4.bp.blogspot.com/-ajeMc31Wl3A/VPEylgqEc0I/AAAAAAAAKlM/8nOTdMYIteA/s1600/2015-02-28%2B08%2B01%2B55.png)
  
  
因為外接硬碟通常都在最後，於是我從後面開始試  
確認是我的Arch硬碟無誤後，按"BACK"  

[![](https://2.bp.blogspot.com/-MR42jmO6lpw/VPEyl8-bCEI/AAAAAAAAKlQ/hvO08_aOsBw/s1600/2015-02-28%2B08%2B02%2B10.png)](http://2.bp.blogspot.com/-MR42jmO6lpw/VPEyl8-bCEI/AAAAAAAAKlQ/hvO08%5FaOsBw/s1600/2015-02-28%2B08%2B02%2B10.png)
  
  
選擇整顆硬碟，這才是正確的模式  

[![](https://3.bp.blogspot.com/-c0KIsKG-fsk/VPEymix4vrI/AAAAAAAAKlg/fafr_xNL5fc/s1600/2015-02-28%2B08%2B02%2B19.png)](http://3.bp.blogspot.com/-c0KIsKG-fsk/VPEymix4vrI/AAAAAAAAKlg/fafr%5FxNL5fc/s1600/2015-02-28%2B08%2B02%2B19.png)
  
  
CPU&RAM的部分自己斟酌，給太小裡面會很LAG，給太大外面會很LAG  
最後再次確認是選到整顆硬碟  

[![](https://3.bp.blogspot.com/-Ig_OJmbQYVc/VPEynovNsDI/AAAAAAAAKls/ejZ_QF4CuRo/s1600/2015-02-28%2B08%2B03%2B54.png)](http://3.bp.blogspot.com/-Ig%5FOJmbQYVc/VPEynovNsDI/AAAAAAAAKls/ejZ%5FQF4CuRo/s1600/2015-02-28%2B08%2B03%2B54.png)
  
  
接下來就是考驗手速的時刻( • ̀ω•́ )✧

  
啟動以後  
看到下面這畫面的瞬間請按ESC或F2，只能按一次喔\~  
連擊會失敗\~  

[![](https://2.bp.blogspot.com/-dVrw0f2jBDo/VPEynhNhsxI/AAAAAAAAKlo/ikkLo35ds_g/s1600/2015-02-28%2B08%2B04%2B14.png)](http://2.bp.blogspot.com/-dVrw0f2jBDo/VPEynhNhsxI/AAAAAAAAKlo/ikkLo35ds%5Fg/s1600/2015-02-28%2B08%2B04%2B14.png)
  
  
如果是按ESC要接著選這項，F2直接跳過此步驟  

[![](https://1.bp.blogspot.com/-XnoMdEoodSg/VPEyoCcn38I/AAAAAAAAKlw/3lI4Qq3N_-A/s1600/2015-02-28%2B08%2B05%2B37.png)](http://1.bp.blogspot.com/-XnoMdEoodSg/VPEyoCcn38I/AAAAAAAAKlw/3lI4Qq3N%5F-A/s1600/2015-02-28%2B08%2B05%2B37.png)
  
  
到BOOT這頁按"+"把(PM)這個按到上面去，也有可能是其他名字，總之多試試\~  
最後F10-Save&Exit  

[![](https://3.bp.blogspot.com/-CK5UReQp7PY/VPEyo3G7GfI/AAAAAAAAKmA/Uq2V3G22AA0/s1600/2015-02-28%2B08%2B06%2B16.png)](http://3.bp.blogspot.com/-CK5UReQp7PY/VPEyo3G7GfI/AAAAAAAAKmA/Uq2V3G22AA0/s1600/2015-02-28%2B08%2B06%2B16.png)
  
  
接著VM會自動重啟  
看到GRUB就表示硬碟讀到拉\~\~\~  
沒出現的再回去Check看看是不是選錯硬碟  
以fallback模式開機  

[![](https://1.bp.blogspot.com/-mIDJ93vvFFc/VPEyp1R9BFI/AAAAAAAAKmI/BCvDbY_SUF8/s1600/2015-02-28%2B08%2B06%2B44.png)](http://1.bp.blogspot.com/-mIDJ93vvFFc/VPEyp1R9BFI/AAAAAAAAKmI/BCvDbY%5FSUF8/s1600/2015-02-28%2B08%2B06%2B44.png)
  
  
最後出現clean這行代表讀到系統碟惹  
※piix4 error見文末  

[![](https://1.bp.blogspot.com/-qCDsoGpGEfU/VPEyqDFN7mI/AAAAAAAAKmM/Bd-tRFWs4zg/s1600/2015-02-28%2B08%2B07%2B03.png)](http://1.bp.blogspot.com/-qCDsoGpGEfU/VPEyqDFN7mI/AAAAAAAAKmM/Bd-tRFWs4zg/s1600/2015-02-28%2B08%2B07%2B03.png)
  
  
｡:.ﾟヽ(\*´∀\`)ﾉﾟ.:｡作戰成功｡:.ﾟヽ(´∀\`\*)ﾉﾟ.:｡

  
[![](https://3.bp.blogspot.com/-P30QuwC8UAs/VPEys_UgHUI/AAAAAAAAKmY/Hqxc0qc4vUY/s1600/2015-02-28%2B08%2B07%2B56.png)](http://3.bp.blogspot.com/-P30QuwC8UAs/VPEys%5FUgHUI/AAAAAAAAKmY/Hqxc0qc4vUY/s1600/2015-02-28%2B08%2B07%2B56.png)
  
  
## 成功啟動系統後\~

1.在系統內允許VMwareTool服務:

> sudo systemctl enable vmtoolsd.service

2.設定Shared Folders:  
  
2-1.首先建立掛載點:  

> sudo mkdir /mnt/vmware

2-2.將Shared Folders掛上去:

> #這三行每次掛載都要執行  
> vmware-hgfsclient #顯示可掛載的目錄  
> sudo modprobe vmhgfs #可寫進mkinitcpio.conf開機執行  
> sudo mount -t vmhgfs .host:/ /mnt/vmware #可寫進fstab開機掛載

((小技巧:我是寫了sh檔跑這三行))   
  
  
## Troubleshooting

1\. piix4\_smbus host smbus controller not enabled!

[![](https://1.bp.blogspot.com/-LFAtFhLE67Y/VPE7STonSmI/AAAAAAAAKm0/fLWFUFS20pw/s1600/2015-02-24%2B06%2B16%2B26.png)](http://1.bp.blogspot.com/-LFAtFhLE67Y/VPE7STonSmI/AAAAAAAAKm0/fLWFUFS20pw/s1600/2015-02-24%2B06%2B16%2B26.png)

  
遇到這行，代表系統嘗試載入piix4驅動模組失敗，因為VM並沒有這個東西

解法如下:  

> sudo vim /etc/modprobe.d/blacklist.conf

在 blacklist.conf裡面加上  

> blacklist i2c\_piix4

再存檔離開即可  
  
2.沒有packer...AUR算是基本功來著(´･ω･\`)  
3.vim無法離開...右上叉叉慢走不送(ヾﾉ･ω･\`)

## 參考資料

1. Installing Arch Linux in VMware - ArchWiki <https://wiki.archlinux.org/index.php/Installing%5FArch%5FLinux%5Fin%5FVMware>
2. 修复 piix4\_smbus Host SMBus controller not enabled 错误  
<http://winotes.net/fixing-piix4-host-smbus-controller-not-enabled-error-for-centos-on-vmware.html>
  