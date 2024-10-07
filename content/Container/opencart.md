+++
title = "[Docker] Opencart購物網站建置"
description = "[Docker] Opencart購物網站建置"
date = 2020-08-27T04:36:00.100Z
updated = 2021-10-31T11:08:31.463Z
draft = false
aliases = ["/2020/08/docker-opencart.html"]

[taxonomies]
tags = ["Docker"]

[extra]
banner = "https://img.maki0419.com/blog/opencart/preview.jpg"
+++
##  前言

[![](https://img.maki0419.com/blog/opencart/preview.jpg)](https://img.maki0419.com/blog/opencart/preview.jpg)

  
[![](https://img.maki0419.com/blog/opencart/opencart-logo.jpg)](https://www.opencart.com/)

Opencart是一套開源的購物網站方案，擴充性高、資源豐富。基本框架免錢，好用的收費模組很多，且台灣的支援度高。

對於一般商家而言，個人較推薦在大型電商開賣場，像是Pchome、蝦皮、露天、Yahoo拍賣等  
好處是建置簡單、曝光率高、客戶熟悉度高。重點是開場成本低，大多是採用賣出時抽成  
自建商店的話，不只初始架站有一筆開銷，之後還有每個月的伺服器維護費....  

說真的，沒有特殊需求別來折騰這個 (ㆆᴗㆆ)

所謂的特殊需求是什麼呢，讓我舉幾個例子:  

* 希望使用自己的域名，做SEO考量
* 一頁式購物、訂閱制購物
* 客戶未登入前不顯示價格
* 新客戶註冊採審核制
* 對不同的客戶分組採用不同價格、不同優惠

不限於這些，還有許多在大型電商不能做到的事  
自由度高，讓不少店家仍希望擁有自己的購物網站

本文以Docker技術，用最少的步驟讓你快速架起自己的Opencart購物網站  

購物網站方案選擇也有不少，而我選用Opencart的理由非常簡單 ──[台灣有廠商](https://www.osec.tw/opencart.html)在收費維護。

[![](https://img.maki0419.com/blog/opencart/money.JPG)](https://img.maki0419.com/blog/opencart/money.JPG)

誒我是說真的，這不是業配 (((ﾟДﾟ;)))

對於營業主而言，能花錢解決問題是很重要的一環，怕的是找不到人提供服務  
今天我們架站不用花錢，但萬一哪天站點出事無力解決，總不能雙手一攤Let it go吧?  
你若不是資訊專家，最好給吃飯的工具留個保險  

另外還有幾個贏過其它方案的優點:  
* 台灣的幾家第三方支付([綠界](https://www.ecpay.com.tw/Service/Appcntr%5FShpcar)、[藍新](https://www.newebpay.com/website/Page/content/download%5Fapi#2)、[歐付寶](https://www.newebpay.com/website/Page/content/download%5Fapi#2)、[紅陽](https://github.com/RedSunTech/OpenCart)等)大都有對Opencart推出模組，很容易就能成功串接
* 有[Facebook官方支援](https://www.facebook.com/business/help/1494437460610744)，可在右下角顯示Messenger聯絡圖標，還能同步上架到Facebook粉專商店
* 核心語言是PHP；伺服器搭MySQL；推薦架在Apache或Nginx，說直白點就是核心確實不要錢
* [有中文社群](https://www.facebook.com/groups/opencart.taiwan/)、[中文論壇](https://forum.opencart.com/viewforum.php?f=64)、[英文論壇](https://forum.opencart.com/)，各路大神們聚在一起~~，有疑難雜症能找人問~~

我不是大神，也不寫PHP  
只是喜歡玩Docker架站，有問題請去上面找專家 ♥(´∀\` )人(甩鍋)

## 概觀

### 本專案核心目標

* 以最少的步驟建立整個server
* 定時備份功能
* 後台網址從前台網域切離  
(意即由www.domain.com/admin無法訪問後台，必需從otheradmin.domain.com訪問)

### 本專案特徵

* 使用OSEC.tw提供之「[OpenCart 台灣優化版](https://www.osec.tw/opencart.html)」，萬一出問題找得到人服務
* 以docer-compose file將需要填入的部份獨立出來，並降到最少
* 分開nginx reverse proxy和opencart的compose file，實現擴充彈性
* 前後台網域分離，讓駭客不能猜到你的後台界面網址

### 本文適合對象

* 初級以上的linux操作基礎
* 有自己的主機或NAS，沒有可以[現在租](#DigitalOcean) (不然你檔案想放哪裡?)

## 流程簡述

1. [Linux主機之Docker安裝和ReveseProxy建置](/2020/11/linux-docker-setup-revese-proxy.html)
2. git clone下來docker-compose建置檔案和config檔案
3. 密碼類的個別設定
4. docker-compose up -d
5. (選)Restore既有資料和config

## 硬體架構

機器有兩台，放在我家的NAS做備份伺服器；Digital Ocean租的VPS做主要Server

若不備份，Rsync Server就不是必須的。本文會講解不做備份的設定方式

┌ Synology NAS (Rsync Server)

WWW  

└ Digital Ocean Droplet (Main Server)

## Main Server系統架構

WWW  
│  
Reverse Proxy (nginx Server) (SSL證書申請、Renew)  
├ Jobber (Cron) (定時備份Docker volume，備份完送至rsync server)   
├ Opencart前台 (nginx Server)  
│ ├ MariaDB資料庫 (網路只對Opencart前後台)  
└ Opencart後台 (nginx Server)

##  DNS設定和Cache設定

我使用Cloudflare做DNS和Cache  
若用其它DNS商請略過Cache設定

  
SSL和PageRule設定如此是為了讓Let's Encrypt能成功訪問，請留意

  
DNS Record有三條，一條A指向SERVER\_IP，另倆CNAME指向A Record  

* DNS  
   * A: `opencart.domain.com` → SERVER\_IP (DNS Only)  
   * CNAME: `shop.domain.com` →`opencart.domain.com` (Proxied)  
   * CNAME: `shopadmin.domain.com` →`opencart.domain.com` (Proxied)
* SSL/TLS  
   * Always Use HTTPS: **Off**  
   * HTTP Strict Transport Security (HSTS):**Disabled**  
   * Automatic HTTPS Rewrites: (Can enable if needed)
* Caching  
   * Caching Level: Standard
* Page Rule  
   1. `*domain.com/.well-known/acme-challenge*`  
         * **Disable Everything**  
         * Cache Level: Bypass

## 架設

### Linux主機和Docker安裝  

請完成此文的建置章節  

> 琳的備忘手札 \[Docker\] Linux主機之Docker安裝和ReveseProxy建置  
> </2020/11/linux-docker-setup-revese-proxy.html>

###  Opencart建置

* cd到root家目錄  
cd
* git clone專案  
git clone https://github.com/jim60105/docker-Opencart-tw.git
* 進入docker-opencart資料夾  
cd docker-Opencart-tw
* 填入.env檔案  
cp .env_sample .env && vim .env  
[![](https://img.maki0419.com/blog/opencart/10.png)](https://img.maki0419.com/blog/opencart/10.png)  
   * `LETSENCRYPT_TEST`: 此為設定申請測試SSL證書，現在給true，**最後上線前才改false**  
   * `LETSENCRYPT_EMAIL`: Let's Encrypt在證書到期時通知你用的email，不會透過這個做驗證。同時用於Opencart Admin帳號，建議正確填入。  
   * `HOST`: 網站前台網域  
   * `HOST_ADMIN`: 網站後台管理界面網域  
   * `MYSQL_ROOT_PASSWORD`: Database的root密碼  
   * `MYSQL_PASSWORD`: Opencart程式專用帳號的Database密碼  
   * `OPENCART_TW`: Opencart的下載網址，由[OSEC.tw](https://www.osec.tw/opencart.html)取得  
   * `OPENCART_ADMIN`: 創建後台Opencart管理員帳號  
   * `OPENCART_ADMIN_PASSWD`: 創建後台Opencart管理員密碼
* 修改jobber部份:  
   * 你有Rsync Server，且會按照本文設定  
   →建立\~/ssh.pas檔案過build，密碼我們後面再填入  
   touch ~/ssh.pas  
   * 你沒有Rsync Server，定時備份後留在Main Server就好  
   →編輯docker-compose.yml，刪除JOB\_COMMAND1的後半段、secrets相關內容  
   [![](https://img.maki0419.com/blog/opencart/18.jpg)](https://img.maki0419.com/blog/opencart/18.jpg)  
   * 你完全不想執行備份  
   →編輯docker-compose.yml，刪除secrets相關內容和整個jobber  
   [![](https://img.maki0419.com/blog/opencart/17.jpg)](https://img.maki0419.com/blog/opencart/17.jpg)
* 起機囉\~\~  
docker-compose up -d
* 檢查Container是否都有起來  
docker ps -a  
[![](https://img.maki0419.com/blog/opencart/11.png)](https://img.maki0419.com/blog/opencart/11.png)
* 檢查SSL是否成功  
docker logs proxy_le -f  
注意紅框處，這樣就是成功  
[![](https://img.maki0419.com/blog/opencart/12.png)](https://img.maki0419.com/blog/opencart/12.png)
* 將SSL申請改為正式申請  
vim .env  
第一行`LETSENCRYPT_TEST`改為`false`  
> ※注意  
> 因為Let's Encrypt針對網域正式申請有次數限制，不論成功與否，做太多次就會鎖住  
> 發布前一定要測試成功再轉正，並於申請成功後備份cert  
重做compose  
docker-compose down -v && docker compose up -d  
檢查是否有成功要到正式證書  
注意紅框處，已沒有\_test\_字樣  
[![](https://img.maki0419.com/blog/opencart/13.png)](https://img.maki0419.com/blog/opencart/13.png)  
> **注意: SSL更新失敗**  
> Opencart架設完成後，請保持此「Use SSL」選項為「否」  
> SSL更新驗證會透過NonSSL進行，此設定會導致驗證失敗  
> SSL自動跳轉請[透過Cloudflare設定](#dnsSetting)  
>  
> [![](https://img.maki0419.com/blog/opencart/SSL.png)](https://img.maki0419.com/blog/opencart/SSL.png)

## Rsync Server設定和備份還原

### Rsync Server設定  

* Synology rsync server設定
   * Rsync是DSM內建功能，開啟「控制台→檔案服務→rsync」  
   啟動rsync服務，port可改(或者由上層的router，外自訂轉內22)  
   [![](https://img.maki0419.com/blog/opencart/rsync1.png)](https://img.maki0419.com/blog/opencart/rsync1.png)
   * 「使用者帳號→新增使用者」  
   使用者名**必須為rsync**，密碼記起來  
   [![](https://img.maki0419.com/blog/opencart/rsync2.png)](https://img.maki0419.com/blog/opencart/rsync2.png)
   * 設定NetBackup為可讀寫，其餘禁止  
   (這rsync專用的共用資料夾**必須名為NetBackup**)  
   [![](https://img.maki0419.com/blog/opencart/rsync3.png)](https://img.maki0419.com/blog/opencart/rsync3.png)
   * 使用者建立後，選中rsync使用者「編輯」→「應用程式」頁籤  
   全選禁止，再選中「rsync服務→針對IP設定」  
   「允許清單→新增IP位址→單一主機」，填入Main Server的IP  
   [![](https://img.maki0419.com/blog/opencart/rsync4.png)](https://img.maki0419.com/blog/opencart/rsync4.png)
* 回到Main Server，修改upload.sh的設定  
cp shellScript/upload.sh_sample shellScript/upload.sh && vim shellScript/upload.sh  
最後兩行修改如下，填入你的RSYNC\_SERVER\_IP和PORT  
su - root -c "ssh-keyscan -p 你的PORT 你的RSYNC_SERVER_IP >> ~/.ssh/known_hosts"  
su - root -c "sshpass -f /run/secrets/rsyncpass rsync -e 'ssh -p 你的PORT' -avz --no-p --no-g /backup/ rsync@你的RSYNC_SERVER_IP::NetBackup/shop/"
* 將shellScript下的檔案權限都改為可執行  
chmod 744 shellScript/* && ls -al shellScript/  
root權限應為rwx  
[![](https://img.maki0419.com/blog/opencart/14.png)](https://img.maki0419.com/blog/opencart/14.png)
* 設定rsync server的ssh密碼，填入Rsync Server上rsync使用者的密碼  
echo "你的密碼" > ~/ssh.pas
* 修改密碼檔權限為-rw-------  
chmod 600 ~/ssh.pas

### 備份  

測試定時備份功能，下面這段的意思是  
「在名為docker-opencart\_jobber\_1的container中，執行jobber test指令，測試名為Backup的定時工作」  

docker exec -it docker-opencart_jobber_1 jobber test Backup

Stderr會報說下載了docker image和加入SSH-Key, 但只要有輸出rsync資訊就是成功  

[![](https://img.maki0419.com/blog/opencart/15.png)](https://img.maki0419.com/blog/opencart/15.png)

也別忘了到Rsync Server確認檔案是否存在

[![](https://img.maki0419.com/blog/opencart/rsync5.png)](https://img.maki0419.com/blog/opencart/rsync5.png)

> ※提醒  
> upload.sh不能在host直接執行，因為密碼檔是以docker secrets的方式處理  
> 此路徑在host不存在

  
我做了簡易的log，記錄下執行時間和IP

[![](https://img.maki0419.com/blog/opencart/16.png)](https://img.maki0419.com/blog/opencart/16.png)

### 還原  

* 把備份檔案放回Main Server的/backup資料夾下  
這部份沒有特別建立管道，我是以區網Samba連到NAS，再拖曳進MobaXterm的SFTP傳輸  
因為安全性考量，我不希望建立能自動從我家NAS輸出資料的管道  
    
假若前面有申請了新的正式SSL證書想要保留，留下reverseproxy字樣的備份不覆蓋
* 執行Restore  
./shellScript/restore.sh && ./shellScript/startContainer.sh  
若restore後不希望自啟動，去掉&&和其後那一段  
> ※提醒  
> restore邏輯  
>   1. 由tag為opencart和proxy的現存volume中取得清單  
>   2. 去/backup資料夾找檔案做複原  
> 故運行前**要先有volume存在**，意即必須得先docker-compose up一次建立volume，後做restore  
> ※提醒  
> renameVolume.sh的用法如下  
>  
> renameVolume.sh oldVolumeName newVolumeName  
>  
> rename邏輯  
>   1. 如果新volume不存在就建立，否則清空延用volume  
>   2. 將舊volume的檔案傳到新的volume  
>   3. 砍掉舊的volume  
> 在建立的過程中不會帶有backup.sh需要的label，所以要由docker-compose up來建立

## 附註: 本專案測試版號

註: 這是在2020年8月測試可用的版號，僅供參考  
docker-compose file內用的是latest，拉下來可能會不同

| 服務       | 版本              |
| -------- | --------------- |
| Opencart | v3.0.3.2 台灣優化版  |
| DB       | MariaDB v10.5.5 |
| Web      | Nginx v1.19.2   |
| PHP      | v7.3-fpm        |

## 附註: 修改Opencart網址

此專案在每次docker-compose up時都會修改網址設定，使之使用寫在.env的環境變數設定  
謹將修改記錄在此  

後台

docker exec -it docker-opencart-tw_web_admin_1 vi /var/www/html/upload/admin/config.php

原始:   

// HTTP
define('HTTP_SERVER', 'http://shop.domain.com/admin/');
define('HTTP_CATALOG', 'http://shop.domain.com/');
// HTTPS
define('HTTPS_SERVER', 'http://shop.domain.com/admin/');
define('HTTPS_CATALOG', 'http://shop.domain.com/');

前幾行被我修改如下:  

// HTTP
define('HTTP_SERVER', 'http://'.getenv('HOST_ADMIN').'/');
define('HTTP_CATALOG', 'http://'.getenv('HOST').'/');
// HTTPS
define('HTTPS_SERVER', 'http://'.getenv('HOST_ADMIN').'/');
define('HTTPS_CATALOG', 'http://'.getenv('HOST').'/');

這樣就會取php container的環境變數使用  
code在此

前台同樣

docker exec -it docker-opencart-tw_web_admin_1 vi /var/www/html/upload/config.php

原始:   

// HTTP
define('HTTP_SERVER', 'http://shop.domain.com/');
// HTTPS
define('HTTPS_SERVER', 'http://shop.domain.com/');

修改如下:  

// HTTP
define('HTTP_SERVER', 'http://'.getenv('HOST').'/');
// HTTPS
define('HTTPS_SERVER', 'http://'.getenv('HOST').'/');

code

  
## 附註: 現有Opencart網站移用

此專案中的nginx web server，其網站檔案是放在volume之下的upload資料夾中  
每次up時會檢查是否有upload資料夾存在，不存在就做初始化，所以一定要將網站放在upload下

假設要複製的既有網站資料位在host的/html；mysqldump出的既有db sql file位在host的/opencart.sql  
請讓資料結構如下

> /html  
> ├storage  
> └upload  
> ├admin  
> ├catalog  
> ├image  
> ├system  
> ├config.php  
> ├index.php  
> └php.ini  
> /opencart.sql  

  
先完成此[架設](#%E6%9E%B6%E8%A8%AD)章節，至能訪問預設網站  
* 修改權限  
chown -R www-data /html && chmod -R 755 /html
* 把檔案複寫入container  
docker cp /html/. docker-opencart-tw_web_1:/var/www/html  
docker cp /opencart.sql docker-opencart-tw_db_1:/
* 進入db container  
docker exec -it docker-opencart-tw_db_1 bash
* 進入bash後將sql倒入，完成後砍了  
mysql -p opencart < /opencart.sql && rm /opencart.sql  
之後`exit`離開即可
  
> 提醒，這裡進入bash後再操作mysql是資訊安全考量  
> 如果無視的話，sql部份能用這樣的一條處理完  
> docker exec -i docker-opencart-tw\_db\_1 mysql -p密碼 opencart < /opencart.sql

  