+++
title = "在 RHEL 8.8 離線安裝 Docker"
description = "在 RHEL 8.8 離線安裝 Docker"
date = 2024-07-06T15:02:00.003Z
updated = 2024-09-07T20:12:04.194Z
draft = false
aliases = [ "/2024/07/install-docker-on-rhel8-air-gap-network.html" ]

[taxonomies]
tags = [ "Docker", "Linux", "RHEL/Fedora" ]
licenses = [ "GFDL 1.3" ]

[extra]
banner = "preview.png"

  [extra.preview]
  withAI = true
  url = "https://civitai.com/images/28256320"
  description = "Made with Flux.1-dev"
+++
## 前言

最近從公司接下了一個輔導客戶導入容器化的案子，其中一項任務是幫他們新採購的伺服器安裝容器運行環境。

Dell 主機；系統 RHEL 8.8；無對外網路；安裝「Docker」。  
為什麼強調「Docker」......我該不該跟他們說 RHEL 內建 Podman 啊😐  
Podman 也沒什麼不好，就只是客戶會撞牆在權限跟權限跟權限而已......還是算了

出發前一天先寫驗收要的手冊，想說  
「沒什麼難的，照 Docker 官方手冊裝一裝就完事了\~\~🥳」  
結果真的踩中地雷，於是就有了這篇文章的誕生🤣

<!-- more -->

## 準備裝機 USB

> USB 大小選擇 16 GB 以上

* 在 Red Hat 下載 RHEL 安裝 ISO 檔: <https://access.redhat.com/downloads>
* 以 rufus 或是其它方式建立開機 USB: <https://rufus.ie/zh%5FTW/>

## 下載 Docker 離線安裝包

> Docker 官方手冊
>
> ---
> <https://docs.docker.com/engine/install/rhel/#install-from-a-package>

* 到這個網站 <https://download.docker.com/linux/rhel/>
* 選擇這次裝機版本 8.8 版 <https://download.docker.com/linux/rhel/8/x86%5F64/stable/Packages/>
* 下載以下套件的最新版 rpm  
  * containerd.io-version.x86\_64.rpm  
  * docker-ce-version.x86\_64.rpm  
  * docker-ce-cli-version.x86\_64.rpm  
  * docker-buildx-plugin-version.x86\_64.rpm  
  * docker-compose-plugin-version.x86\_64.rpm
* 下載 libcgroup 和 container-selinux rpm  
  * <https://kojihub.stream.centos.org/koji/buildinfo?buildID=46698>  
  * <https://kojihub.stream.centos.org/koji/buildinfo?buildID=19484>
* 以上 rpm 檔案放在另一支 USB 裡帶去

## 準備 docker image 做測試 (可選)

tar 檔放 USB 帶去

```bash
docker save -o busybox.tar busybox
docker save -o nginx.tar nginx
```

## 安裝 RHEL

> Red Hat 官方手冊
>
> ---
> <https://docs.redhat.com/en/documentation/red%5Fhat%5Fenterprise%5Flinux/8/html-single/performing%5Fa%5Fstandard%5Frhel%5F8%5Finstallation/index>

開機時 F11 進 One-shot boot menu，選擇 RHEL 開機 USB

* 注意若要創建其它用戶時 _**必須**_ 授予 sudo 權限
* 硬碟配置選 Custom，並將 `/var` 切大一點，docker 佔空間的檔案會存在這

[![](7.jpg)](7.jpg)

其餘依照客戶需求做設定，安裝完成後重啟

## 安裝 docker

### Mount usb

```bash
mount /dev/sdb1 /mnt
cd /mnt
ls -alh
```

[![](8.png#full-bleed)](8.png)

### 移除衝突套件 (for RHEL 8)

> install docker-ce on redhat 8 - Stack Overflow
>
> ---
> <https://stackoverflow.com/a/60153726/8706033>

```bash
dnf module disable container-tools
dnf remove runc
```

### 安裝依賴項

```bash
dnf install ./container-selinux(tab 按出檔案名)
dnf install ./libcgroup(tab 按出檔案名)
```

### 安裝所有 docker 相關 rpm

```bash
dnf install ./(用 tab 依序按出所有檔案)
```

[![](9.png#full-bleed)](9.png)

### 啟用 docker

```bash
systemctl enable docker
systemctl start docker
```

### 確認 docker 成功安裝

```bash
docker -v
docker compose version
```

## 測試 docker (可選)

```bash
docker load -i busybox.tar
docker load -i nginx.tar
docker images

docker run --rm busybox echo "hello from busybox"
docker run --rm -d -p 8080:80 --name web nginx
curl http://localhost:8080
docker stop web

docker system prune -a
```
