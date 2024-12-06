+++
title = "Handshake domain 區塊鏈網域 —— 如何設定網域"
description = "在前兩篇我們成功競標到了網域，也設定好了環境使可訪問Handshake domain，這篇我們要實際寫DNS位置到鏈上，讓網站上線，最後會提及一些Namebase的加值服務，值得一試。"
date = 2022-03-05T20:37:00.011Z
updated = 2022-12-15T20:31:35.247Z
draft = false
aliases = [ "/2022/03/handshake-blockchain-domain-how-to-setup.html" ]

[taxonomies]
tags = [ "區塊鏈", "Blockchain Domain" ]

[extra]
card = "preview.png"
iscn = "iscn://likecoin-chain/TW11huUVHy5Bsg0S3prnXNNYKzj0iabfmREUOaGla1w/1"

  [extra.comments]
  id = "109447665515037253"
+++

![preview](preview.png)

> 前篇  
> [Handshake domain 區塊鏈網域 —— 如何訪問網域](/Blockchain/blockchain-domain/handshake-blockchain-domain-how-to-access)

在前兩篇我們成功競標到了網域，也設定好了環境使可訪問 Handshake domain，這篇我們要實際寫 DNS 位置到鏈上，讓網站上線，最後會提及一些 Namebase 的加值服務，值得一試。<!--more-->

## 事前準備

在開始以前，我們需要有一個簡單的 Hello World 網站、一台網頁伺服器，和一台 Name Server。選擇很多，為了方便 Demo，我將使用 GitHub Pages 做為網頁和網頁伺服器，並在 DigitalOcean 租一台 VPS，安裝 BIND 以做為 NameServer。

### 範例網頁伺服器

* [建立 GitHub 帳號](https://github.com/)
* Fork 以下 Repo: <https://github.com/digitalocean/sample-html>

> 我們不使用 DigitalOcean Apps 做網頁服務，因為它不支援 Handshake domain  
> 但它的 Sample 真的蠻漂亮的，借來一用  
> ![](/Blockchain/blockchain-domain/handshake/setup/1.png)

* 點右上的「Settings」
* 點左側的「Pages」，在右方選擇「main」這個 branch  
  ![](/Blockchain/blockchain-domain/handshake/setup/2.png)  
  ![](/Blockchain/blockchain-domain/handshake/setup/3.png)
* 「Save」後等約兩分鐘，等 GitHub 將你的網站部署上去  
  GitHub 提供的網址為:`https://<你的username>.github.io/sample-html/`，而我們後面要把它對應到 Handshake domain  
  ![](/Blockchain/blockchain-domain/handshake/setup/4.png)

### 範例 Name Server

> 為方便演示，本文使用別人包裝好，包含 GUI 界面的 docker image: [sameersbn/bind](https://hub.docker.com/r/sameersbn/bind/)  
> 資訊安全保護不良的 Name Server 常成為駭客眼中的肥羊  
> 請將此章節視為功能演示就好

* 開一台 VPS

> 請參考本文建置主機，安裝 Docker 環境  
> [琳的備忘手札: \[Docker\] Linux 主機之 Docker 安裝和 ReveseProxy 建置](@/Container/linux-docker-setup-reverse-proxy/index.md)  
> 配置新主機請參考此設定  
> [![](/Blockchain/blockchain-domain/handshake/setup/5.png)](/Blockchain/blockchain-domain/handshake/setup/5.png)

* 安裝 BIND

  * ```bash
      docker pull sameersbn/bind
      ```

  * 關閉 systemd-resolved

      ```bash
      systemctl disable systemd-resolved
      systemctl stop systemd-resolved
      ```

  * ```bash
      docker run --name bind -d --restart=always \
         --publish 53:53/tcp --publish 53:53/udp --publish 10000:10000/tcp \
         --volume /srv/docker/bind:/data \
         sameersbn/bind
      ```

  * 在服務成功啟動後，新增防火牆規則，開啟 UDP 53、TCP 53、10000 port，配置到 VPS 上  
    ![](/Blockchain/blockchain-domain/handshake/setup/6.png)
  * 瀏覧器打開 VPS 的 10000 port，預設密碼為 `root/password`  
    ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%281%29.png)

## 設定 Bob Wallet 中的網域

* 由左側的 Domain Manager 選擇目標 domain，Add Records  
  ![](/Blockchain/blockchain-domain/handshake/setup/9.png)
* 新增兩條記錄，NS 記錄和 GLUE4 記錄  
  **注意勿遺漏在網域後面的那個點 (.)**

  |||
  |-------|-------------------------------|
  | NS    | ns1.chenchun.                 |
  | GLUE4 | ns1.chenchun. 178.128.XXX.XXX |

   > Handshake records 的詳細說明請見此  
   > Handshake Resource Record Guide - Handshake Developer Documentation  
   > <https://hsd-dev.org/guides/resource-records.html>  
   > ![](/Blockchain/blockchain-domain/handshake/setup/10.png)

* 寫到鏈上要 15 分鐘，但更新入 Handshake domain 要 6 小時以上。總之等個半天再來做測試吧  
  ![](/Blockchain/blockchain-domain/handshake/setup/11.png)

## 設定 Namebase 中的網域

> Namebase 有提供 DNS 服務，功能使用上沒什麼問題  
> 但如果託管在 Namebase 就變成使用另一個中心化服務，失去了去中心化的優點  
> 你可以選擇「網域託管在 Namebase，並使用 Namebase 的 DNS」、  
> 「網域託管在 Namebase，並指向私人 DNS」、  
> 「網域轉出至 Bob Wallet」等不同的配置
>
> 本章節將示範「網域託管在 Namebase，並指向私人 DNS」的配置模式

* 來到 [Dashboard → Domain Manager](https://www.namebase.io/manage/owned?page=1) → Manage  
  ![](/Blockchain/blockchain-domain/handshake/setup/12.png)
* 在「Blockchain DNS records」中的 ns1 填入 VPS 的 IP，ns2 刪除  
  ![](/Blockchain/blockchain-domain/handshake/setup/13.png)
* 寫到鏈上要 15 分鐘，但更新入 Handshake domain 要 6 小時以上。總之等個半天再來做測試吧

## 在 Name Server 上添加網域和 Record

> 參考資料  
> [Deploying a DNS Server using Docker - SAMEER NAIK](http://www.damagehead.com/blog/2015/04/28/deploying-a-dns-server-using-docker/)

* 左側「Server」→「BIND DNS Server」→「Create master zone」  
  ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%282%29.png)
* 填寫如圖，按 Create  

  |||
  |--------------------------------------|-------------|
  | Domain name                          | chenchun    |
  | Master server                        | ns.chenchun |
  | Use zone template?                   | Yes         |
  | Add reverses for template addresses? | No          |

  ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%283%29.png)

* 選擇「Address」，填寫如圖，按 Create

  |||
  |---------|-----------------|
  | Name    | ns.chenchun     |
  | Address | 178.128.XXX.XXX |

  ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%284%29.png)  
  ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%285%29.png)

* 選擇「Name Alias」，填寫如圖，按 Create  

  |||
  |-----------|-------------------------------------------------|
  | Name      | color                                           |
  | Real Name | <你的 username>.github.io. (注意最後面有一個點！) |

  ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%286%29.png)  
  ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%287%29.png)

* 最後，點右上角的「Apply configuration」！  
  ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%288%29.png)
* 在主機上確認能否解析 `color.chenchun` 至 jim60105.github.io.  
  ![](/Blockchain/blockchain-domain/handshake/setup/bind%20%289%29.png)

## 將網域設定至 GitHub Pages

> 設定 GitHub Pages 的詳細官方文件請見此  
> [Managing a custom domain for your GitHub Pages site - GitHub Docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)

來到剛才的「Settings」→「Pages」頁面，在「Custom Domain」填入網域名稱  
這會在 Repo 根目錄建立一個「CNAME」檔

![](/Blockchain/blockchain-domain/handshake/setup/15.png)

不用理會下方的設定失敗，GitHub 不能解析 Handshake domains

![](/Blockchain/blockchain-domain/handshake/setup/16.png)

## 結語

![](/Blockchain/blockchain-domain/handshake/setup/17.png)

至此，Handshake domain 介紹告一段落。本系列文從原理、競標、訪問，至設定都介紹了一輪，也實際演示下標了兩個網域並實際上架了一個網站。希望各位對 Handshake domain 都有了大致的了解。
