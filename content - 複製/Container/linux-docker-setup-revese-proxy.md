+++
title = "[Docker] Linux主機之Docker安裝和ReveseProxy建置"
description = "[Docker] Linux主機之Docker安裝和ReveseProxy建置"
date = 2020-11-23T18:51:00.080Z
updated = 2023-01-03T13:49:34.758Z
draft = false
aliases = ["/2020/11/linux-docker-setup-revese-proxy.html"]

[taxonomies]
tags = ["Docker"]

[extra]
banner = "https://img.maki0419.com/blog/dockerAndReverseProxy/preview.png"
+++
##  前言

[![](https://img.maki0419.com/blog/dockerAndReverseProxy/preview.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/preview.png)

圖源 https://webapplicationconsultant.com/scalability/nginx-reverse-proxy-for-scalability/

此篇文章由零開始設定Linux主機、安裝Docker，並設定Reversy Proxy  

Reverse Proxy(反向代理)，可以比喻為一棟樓的大門管理員  
當一個包裏送至管理員，管理員會依照地址將之轉送給後方的住戶  
當一個Web Request送至Reverse Proxy，Reverse Proxy會依照URL將之轉送給後方的伺服器  
使用docker技術，能在同一台機器上配置多個伺服器，且不會互相干擾

此套ReverseProxy可在docker compose up時建立路由，自動申請及Renew SSL證書  
我個人的所有網路服務都是配合此套ReverseProxy做建置，特撰此文以做前導

## 流程簡述

1. 起一台新的Linux
2. 安裝docker、docker-compose
3. git clone下Reverse Proxy之建置檔案
4. docker-compose up -d

## 建置

### Linux主機  

* 起一台Linux做Main Server，理論上任何能裝Docker的arm64 linux都行  
[![DigitalOcean Referral Badge](https://web-platforms.sfo2.cdn.digitaloceanspaces.com/WWW/Badge%201.svg)](https://www.digitalocean.com/?refcode=ac52b09a7f63&utm%5Fcampaign=Referral%5FInvite&utm%5Fmedium=Referral%5FProgram&utm%5Fsource=badge)我個人是用[**Digital Ocean**](https://m.do.co/c/ac52b09a7f63)，最便宜的方案每個月6美元 (4美元的方案請略過它)  
這是老牌的主機商，在業界有信譽有口碑，比國內的主機商穩定得多  
亞洲可選的資料中心在新加坡，對台灣連線速度佳，沒有什麼奇怪的問題  
透過上方推廣鏈結註冊，你會拿到60天內200美元的試用額度，而這足夠玩遍所有功能  
DigitalOcean的註冊優惠都是這個價，用我的推廣就當成是對我小額贊助吧  
這裡我選一台Unbuntu x64 LTS  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/1.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/1.png)  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/2.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/2.png)
* 由後台從Consle連入，把SSH port改為自設的port  
vi /etc/ssh/sshd_config  
service ssh restart  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/5.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/5.png)  
> 如果你使用 22.10 版本以上的 Ubuntu，改用這個方式更改 SSH port  
>  
> ---  
>  
> <https://askubuntu.com/a/1439482>
* 注意UFW是否有擋port  
ufw status  
如果它是inactive以外的狀態，請上網找`Ubuntu UFW`相關文章做調整  
需開放80、443和自設的SSH port
* 若是租用VPS，建議關了UFW，用VPS後台的Firewall功能即可  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/3.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/3.png)  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/4.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/4.png)
* SSH Client，以root連入，推薦用[MobaXterm](https://mobaxterm.mobatek.net/)  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/6.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/6.png)  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/7.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/7.png)

> 小小建議
>
> ---
>
> 可以開一個3GB的Volume做Swap，比加RAM便宜得多喔  
> [建立Volume的說明](https://docs.digitalocean.com/products/volumes/quickstart/)，還有[Swap的說明](https://www.digitalocean.com/community/tutorial%5Fcollections/how-to-add-swap-space)

  
### Docker安裝  

> 可參閱[官方文件](https://docs.docker.com/engine/install/ubuntu/#installation-methods)  
> 若有更新，請以官方文件為準

* (選)全面更新  
sudo apt-get update && sudo apt-get upgrade -y
* 安裝必要組件  
sudo apt-get install \  
    ca-certificates \  
    curl \  
    gnupg \  
    lsb-release
* 加入gpg key  
sudo mkdir -p /etc/apt/keyrings  
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
* 加入repo庫  
echo \  
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \  
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
* 安裝Docker和Docker compose plugin  
sudo apt-get update  
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
* 測試  
docker --version  
docker compose version  
安裝成功，印出版本號

### Reverse Proxy建置  

> 請用root連入或是su  
> docker所有操作都需要root權限，且docker-compose file我會建議放在root家目錄下

* cd到root家目錄  
cd
* git clone專案  
git clone https://github.com/jim60105/docker-ReverseProxy.git
* 啟動nginx reverse proxy  
docker-compose -f ./docker-ReverseProxy/docker-compose.yml up -d  
[![](https://img.maki0419.com/blog/dockerAndReverseProxy/9.png)](https://img.maki0419.com/blog/dockerAndReverseProxy/9.png)

## Reverse Proxy之使用

請對每個後端服務添加以下環境變數  
* VIRTUAL\_HOST: 要導向此container的網址
* LETSENCRYPT\_HOST: SSL證書之網域、別名
* LETSENCRYPT\_EMAIL: SSL證書申請人email，到期日近會有通知。請正確填寫，似乎不能變更
* (選)LETSENCRYPT\_TEST: 申請測試證書。請給true/false。因正式申請有嘗試次數上限、申請數量上限，**請在最後上線前再轉false**

然後將所有後端服務都連上`networks: proxy-tier`，就像[這樣](https://github.com/jim60105/docker-V2Ray/blob/master/docker-compose.yml#L22-L23)   
  
就這麼簡單(╹ڡ╹ )  

## 附註: `docker-compose` vs `docker compose` (中間的-號)

* docker\-compose: Compose v1，是以python寫的，穩定。最後一版是 [v1.29.2](https://github.com/docker/compose/releases/tag/1.29.2)
* docker compose: Compose v2，是以golang重寫的，其設計能從v1無痛轉移，大部份的參數相同，但目前不太穩定。

Windows Docker Desktop新舊都有內建，可在設定中開啟v2  
v2不像v1是獨立程式，而是docker-cli plugin

其餘差異見官方文件。

> [Compose command compatibility with docker-compose | Docker Documentation](https://docs.docker.com/compose/cli-command-compatibility/)

### compose-switch: 以`docker-compose`執行`docker compose`

網路上舊的command都是`docker-compose`，因為command不同，沒辦法copy & paste直接用，造成不少困擾。官方做了 [compose-switch](https://github.com/docker/compose-switch) 工具來解決這個問題。它可以在下command執行`docker-compose`時改叫`docker compose`來用。

需注意，compose-switch是「以`docker-compose`來呼叫v2」，而不是執行v1，[v2和v1有若干不同](https://docs.docker.com/compose/cli-command-compatibility/)。

curl -fL https://raw.githubusercontent.com/docker/compose-switch/master/install_on_linux.sh | sh
update-alternatives --install /usr/local/bin/docker-compose docker-compose /usr/local/bin/compose-switch 99

測試

docker-compose version

安裝成功，印出版本號

## 附註: 常用docker指令

列出所有cotainer，-a: 列出包含未啟動的container  

docker ps -a

列出所有volume

docker volume ls

清除所有未被container使用的volume  

docker volume prune

建立compose，同時用來做驗證  

docker-compose build  

compose狀態，可以用來檢查變數是否有正確代入，環境變數的讀入順序十分麻煩  

docker-compose config  

啟動compose，-d: 以deamon背景服務執行  

docker-compose up -d

compose操作都可以用-f 給定docker-compose.yml的位置，但需注意有些相對路徑可能會有問題  

docker-compose -f <路徑> up -d

stop&remove compose的所有container，-v: 同時刪除volume  

docker-compose down

列出此compose的logs，-f: 持續監聽  

docker-compose logs

列出指定container的log，-f: 持續監聽docker logs

重啟compose下的container  

docker-compose restart

在container內執行指令，常會執行bash來做進入  
docker exec -it  <指令>

iscn://likecoin-chain/\_zmSdL8lQdrPnP5LurJlWdK6WsCzRksqbRzk-UJKr4c