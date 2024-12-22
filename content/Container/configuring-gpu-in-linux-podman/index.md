+++
title = "Fedora/RHEL 的 Podman GPU 設定手札"
date = "2024-12-22T01:56:24.474Z"
updated = "2024-12-22T15:34:01.584Z"
description = "本指南詳細介紹如何在 Fedora 系統中為 Podman 配置 GPU 支援。從 Podman 和相關工具的安裝，到 NVIDIA 驅動程式與 Container Toolkit 的設定，文章提供了完整的步驟說明。特別強調了 Container Device Interface (CDI) 的重要性，並提供測試方法驗證 GPU 運作。文末介紹了 Stable Diffusion WebUI 和 WhisperX 兩個實際應用範例，展示 GPU 容器化的優勢。無論您是 Linux 新手還是經驗開發者，本文都能助您充分發揮 Fedora 上 Podman 和 GPU 的潛力。"

[taxonomies]
tags = [ "Container", "Linux", "RHEL/Fedora", "Docker" ]
licenses = [ "GFDL 1.3" ]

[extra]
iscn = "iscn://likecoin-chain/LJx_mG7rlrm4mxdFaZI76qVzYqWPERhCAA8NdHFbC_o/1"

  [extra.comments]
  id = "113694165566370607"
+++
## 前言

上個月我從 Windows 跳槽到了 Fedora 重裝系統時深入研究了「如何在 Linux 環境設定 Podman」這個課題。以前在寫[個人專案文件](https://github.com/jim60105/docker-stable-diffusion-webui?tab=readme-ov-file#-get-your-docker-ready-for-gpu-support)時碰到 Linux 總是輕輕帶過，「Linux 使用者知道自己在做什麼😉」，放個連結交差了事。然而實際輪到自己安裝時果然還是會遇到值得記錄下來的小挑戰{{ch(body="小地雷")}}。

這篇文章將講述如何設定 [Podman](https://podman.io/)、[Podman Compose](https://github.com/containers/podman-compose)、[NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html)、[Container Device Interface (CDI)](https://github.com/cncf-tags/container-device-interface)，以便能夠在容器中使用 GPU。我會詳細介紹從安裝到設定的所有步驟，並分享一些實際應用的例子。無論你是初學者還是有經驗的使用者，希望這篇文章能為你在 Podman 容器的探索中提供幫助。

## Podman 簡介

### Podman 是什麼?

{% crt() %}

```
$ podman run quay.io/podman/hello
Trying to pull quay.io/podman/hello:latest...
Getting image source signatures
Copying blob 81df7ff16254 done   | 
Copying config 5dd467fce5 done   | 
Writing manifest to image destination
!... Hello Podman World ...!

         .--"--.           
       / -     - \         
      / (O)   (O) \        
   ~~~| -=(,Y,)=- |         
    .---. /`  \   |~~      
 ~/  o  o \~~~~.----. ~~   
  | =(X)= |~  / (O (O) \   
   ~~~~~~~  ~| =(Y_)=-  |   
  ~~~~    ~~~|   U      |~~ 

Project:   https://github.com/containers/podman
Website:   https://podman.io
Desktop:   https://podman-desktop.io
Documents: https://docs.podman.io
YouTube:   https://youtube.com/@Podman
X/Twitter: @Podman_io
Mastodon:  @Podman_io@fosstodon.org
```

{% end %}

Podman 是一款功能強大的容器管理工具，專門用於處理 OCI 容器的建立、管理和執行。它的指令介面與 Docker 相似，這意味著 Docker 使用者可以輕鬆上手。Podman 最大的特點是採用無背景程式 (Daemonless) 的架構，讓容器管理更加安全和高效。使用者可以直接 rootless 啟動容器，而不需要擔心有個背景程式需要持續運作，或是需要有管理員權限才能運行容器。

### Podman 與 Docker 的比較

Podman 和 Docker 雖然在功能上相似，但有幾個關鍵的差異：

- 開源：Podman 是由社群驅動的開源專案，而 Docker 則是由商業公司開發和維護。這影響了兩者的發展方向和商業模式。
- 架構：Podman 不需要常駐程式，而 Docker 則需要。這使得 Podman 在資源使用和安全性方面更具優勢。
- 權限要求：Podman 可以在一般使用者權限下運作，不需要管理員權限。Docker 直到最近才新增了 rootless mode。
- 系統整合：Podman 與 Linux 系統有更好的整合性。這提供了更順暢的系統管理體驗。
- 相容性：Podman 設計上相容 Docker 的大部分指令，這讓 Docker 使用者可以輕鬆轉換。

Podman 作為一個開源專案，提供了更安全、更靈活的容器管理解決方案。選擇使用 Podman 還是 Docker，除了考慮技術需求外，也可能涉及對開源理念的支持。如果你重視社群驅動的開發模式，同時注重安全性和系統整合，Podman 會是一個很好的選擇。它結合了強大的功能和靈活的使用方式，能有效提升容器管理的效率。

> 延伸閱讀
>
> ---
> {{ youtube(id="dD691zzC3kk") }}
> [What is Podman? | Redhat.com](https://www.redhat.com/en/topics/containers/what-is-podman)

### 改用 Podman 就對了嗎？

我必須誠實地說，**Podman 的這些優勢主要是在 Linux 系統上才能充分發揮**。如果你是在 Windows 系統上使用 Podman，你需要啟動一個 Podman machine ，這實際上就是需要另外開著一個虛擬機。在這種情況下，Podman 可能就無法展現出相較於 Docker 的優勢。

**對於 Windows 使用者來說，我的建議是繼續使用 Docker**。Docker 在 Windows WSL 環境下已經有很好的整合和優化，能夠提供更直接、更順暢的使用體驗。選擇合適的工具不僅要考慮功能，也要考慮到你的操作系統環境。在正確的場景中使用正確的工具，才能獲得最佳的效果。

但如果你是在 RHEL/Fedora 上運行容器，我誠摯的推薦你嘗試 Podman。萬一遇到了 Podman 無法解決的問題時，請記得

<figure>
{{image(url="我全都要.gif", alt="我全都要", no_hover=true)}}
<figcaption>你可以兩個都裝，它們不衝突</figcaption>
</figure>

## 安裝必要組件

### 安裝 Podman

對於 Fedora 或 RHEL 系統的使用者來說，有個好消息：{{cg(body="Podman 已經跟你的系統整合在一起了。")}}

這真的是個好消息。  
在某一些公司 {{ch(body="尤其是金融業")}} 安裝軟體是一件麻煩的事情，可能要送申請、跑簽核...  
而現在，RHEL 主機裝好了？ Podman 就在那裡了。

不過，如果出於某些原因你的系統上沒有 Podman，或者你想確保使用的是最新版本，你可以使用以下指令輕鬆安裝：

```bash
sudo dnf -y install podman
```

這個指令會使用 Fedora 的套件管理器 DNF 來安裝 Podman。如果你使用的是其他 Linux 發行版，可以參考 [Podman 官方安裝文件](https://podman.io/docs/installation) 來獲取適合你系統的安裝指令。

### 安裝 Podman Desktop

Podman Desktop 是一個圖形化界面，能讓你更直觀地管理容器。在 Fedora 上可以使用 Flatpak 來安裝 Podman Desktop。

```bash
sudo flatpak install flathub io.podman_desktop.PodmanDesktop
```

這個指令會[從 Flathub 倉庫下載並安裝 Podman Desktop](https://flathub.org/apps/io.podman_desktop.PodmanDesktop)。

### 安裝 Podman Compose

在安裝 Podman Compose 之前，有一件事得提醒一下。

當你安裝完 Podman Desktop 後，你可能會在它的 Extension 中發現一個預先安裝的 Compose Extension。

{{ image(url="1.png", alt="Podman Compose Extension") }}

{% alert(caution=true) %}
這裡有一個小陷阱：  
**這個 Podman Compose Extension 實際上安裝的是 Docker Compose，而不是 Podman Compose。**
{% end %}

雖然 Docker Compose 可以與 Podman 一起運行，但它們之間的相容性並不完美。特別是在使用 GPU 時，會出現一些問題。Docker Compose 無法成功地讓 Podman 使用 GPU。

因此需要[額外手動安裝 Podman Compose](https://github.com/containers/podman-compose?tab=readme-ov-file#installation)。

```bash
sudo dnf -y install podman-compose
```

安裝完成後還需要進行一些設定，確保 `podman compose` 指令使用的是 podman-compose 而不是 docker-compose。

## 設定 `podman compose` 使用 podman-compose 而非 docker-compose

目前，`docker-compose` 與使用 CDI 的 `podman` 存在相容性問題。這個問題已在 [podman issue #19338](https://github.com/containers/podman/issues/19338) 中被提出。

為了解決這個問題，我們需要設定 `podman compose` 使用 `podman-compose`，而不是 Podman Desktop 預設的 `docker-compose`。

1. 首先，確保你已經按照前一章節的說明安裝了 `podman-compose`。
2. 接下來需要修改 Podman 的設定文件。這個文件在 `/usr/share/containers/containers.conf`, `/etc/containers/containers.conf`, `$HOME/.config/containers/containers.conf`。取決於你希望這是一個全系統的設定還是個人的設定，來選擇要把它寫在什麼地方。你可以在[這個官方文件](https://docs.podman.io/en/stable/markdown/podman.1.html#configuration-files)中找到更多細節。
3. 打開這個文件並添加以下設定：

   ```toml, linenos
   [engine]
     compose_providers = [ "podman-compose" ]
   ```

   這個設定告訴 Podman 在執行 `podman compose` 指令時使用 `podman-compose`。
4. 保存並關閉文件。
5. 現在你可以運行 `podman compose version` 指令，確保它使用的是 `podman-compose`。

   ```
   $ podman compose version
   >>>> Executing external compose provider "/usr/bin/podman-compose". Please see podman-compose(1) for how to disable this message. <<<<
   
   podman-compose version 1.2.0
   podman version 5.3.1
   ```

需要注意的是，`podman-compose` 和 `docker-compose` 在某些細節上可能有所不同。如果你之前主要使用 `docker-compose`，可能需要稍微注意一下這些差異，但我個人的使用經驗上來說最近並沒有遇到什麼大問題。

這個設定是確保我們能夠順利使用 Podman 與 GPU 的關鍵步驟。在下一章節中，我將深入探討如何設定 Podman 以使用 GPU。

## 設定 Podman 以使用 GPU

在這個章節中，我將詳細介紹如何設定 Podman 來使用 GPU。這個過程包括安裝 NVIDIA 驅動、NVIDIA Container Toolkit，以及設置 CDI（Container Device Interface）。

### 安裝 NVIDIA 驅動

首先，確保你的系統已經安裝了最新的 NVIDIA 驅動。

在 Fedora 安裝 NVIDIA 驅動之前，我強烈建議你先看過 RPM Fusion 的 [Howto/NVIDIA](https://rpmfusion.org/Howto/NVIDIA)，它涵蓋了近十年所有版本的 NVIDIA 驅動安裝方法。並且不要忘記，在安裝 NVIDIA 驅動之前你需要[先安裝 RPM Fusion 的 repository](https://rpmfusion.org/Configuration)。

安裝完成後，你可以使用以下指令來確認 NVIDIA 驅動是否正確安裝：

```
$ modinfo -F version nvidia
565.57.01
```

```
$ vdpauinfo
display: :0   screen: 0
API version: 1
Information string: NVIDIA VDPAU Driver Shared Library  565.57.01  Thu Oct 10 11:55:58 UTC 2024
...
```

### 安裝 NVIDIA Container Toolkit

NVIDIA Container Toolkit 是使容器能夠利用 GPU 的關鍵組件。安裝過程參考這份[官方安裝指南](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-yum-or-dnf)。

首先，添加 NVIDIA Container Toolkit 的 repository：

```bash
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
```

然後，使用 DNF 安裝 NVIDIA Container Toolkit：

```bash
sudo dnf install -y nvidia-container-toolkit
```

### 設定 CDI (Container Device Interface)

CDI 允許容器管理器以標準化的方式將設備（如 GPU）暴露給容器。這裡是 [NVIDIA 提供的說明文件](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html)。設定它其實蠻簡單的，總共只有一條指令，生成 CDI 規範文件：

```bash
sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
```

這個指令會創建一個 YAML 文件，定義了如何在容器中使用 NVIDIA GPU。

接下來，運行以下指令驗證 CDI 設定：

```bash
nvidia-ctk cdi list
```

這個指令會顯示可用的 CDI 設備。如果設定正確，你應該能看到你的 NVIDIA GPU 列表。

```
$ nvidia-ctk cdi list
INFO[0000] Found 3 CDI devices
nvidia.com/gpu=0
nvidia.com/gpu=GPU-6e9cf2fe-a071-933b-32ff-388b189925ec
nvidia.com/gpu=all
```

> 運行這兩個指令時如果看見任何的紅字，請回頭檢查你的 NVIDIA 驅動和 NVIDIA Container Toolkit 是否正確安裝。

## 測試 Podman 和 GPU 設定

在完成 Podman 和 GPU 的設定後，進行以下測試以確保一切設置正確。

我們可以使用一個簡單的指令來測試 Podman 是否能夠正確地訪問 GPU：

```bash
podman run --rm --device nvidia.com/gpu=all --security-opt=label=disable ubuntu nvidia-smi -L
```

這個指令的含義如下：

| 指令                                    | 說明                                                |
|-----------------------------------------|-----------------------------------------------------|
| `podman run`                            | 運行一個新的容器                                     |
| `--rm`                                  | 容器停止後自動刪除                                   |
| `--device nvidia.com/gpu=all`           | 允許容器訪問所有可用的 NVIDIA GPU                     |
| `--security-opt=label=disable`          | 暫時禁用 SELinux 標籤，以避免權限問題                 |
| `ubuntu`                                | 使用 Ubuntu 基礎映像                                   |
| `nvidia-smi -L`                         | 在容器內運行 `nvidia-smi` 指令，列出所有可用的 GPU       |

運行上述指令後，你應該會看到類似以下的輸出：

```
GPU 0: NVIDIA GeForce RTX 3060 (UUID: GPU-6e9cf2fe-a071-933b-32ff-388b189925ec)
```

這個輸出告訴你幾個重要的資訊。它表明 Podman 成功啟動了一個容器，容器能夠訪問主機的 GPU，並且 `nvidia-smi` 指令成功執行並列出了可用的 GPU，這意味著 NVIDIA 驅動程式在容器內正常工作。

如果你看到了類似上面的輸出，那麼恭喜你！這意味著你的 Podman 和 GPU 設定已經成功了。在下一章中，我將介紹兩個需要 GPU 的容器化應用，來體驗一下 GPU 容器化的樂趣。

## GPU 容器應用實例

在確認 Podman 能夠正確訪問 GPU 後，我們可以開始運行一些實際的 GPU 容器應用。本章將介紹兩個流行的 AI 工具：Stable Diffusion WebUI 和 WhisperX，它們都能夠充分利用 GPU 來提高性能。

### [Stable Diffusion WebUI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)

{{ image(url="/Container/docker-stable-diffusion-webui-kohyas-gui/stable-diffusion-webui.png", alt="Stable Diffusion WebUI") }}

Stable Diffusion WebUI 是一個強大的 AI 圖像生成工具。它基於 Stable Diffusion 模型，提供了一個用戶友好的網頁界面，讓你可以輕鬆創建令人驚嘆的 AI 生成圖像。這個工具重度依賴 GPU 來進行快速的圖像生成，因此是測試我們 GPU 設定的絕佳選擇。

如果你想了解更多關於如何在容器中運行 Stable Diffusion WebUI 的詳細資訊，我建議你參考我之前寫的一篇文章。在那篇文章中，我深入探討了容器化 Stable Diffusion WebUI 的過程以及如何使用它。

> 延伸閱讀
>
> ---
> [\[Docker 專案\] 一行指令運行 Stable Diffusion WebUI 和 Kohya's GUI](@/Container/docker-stable-diffusion-webui-kohyas-gui/index.md)

### [WhisperX](https://github.com/m-bain/whisperX)

{{ image(url="/AI/whisperx/preview.png", alt="WhisperX") }}

WhisperX 是一個革命性的自動語音識別工具，提供高速轉錄、詞級時間戳和講話者分離功能。它基於 OpenAI 的 Whisper 模型，但在速度和功能上有顯著提升。WhisperX 使用 faster-whisper 作為後端，能夠在保持高準確度的同時，實現驚人的 70 倍轉錄速度。它還整合了語者分離功能，可以區分不同的說話者，這使得它非常適合處理多人對話或訪談的音檔。

請閱讀我之前寫的一篇專門介紹 WhisperX 的文章。這篇文章詳細介紹了如何使用 WhisperX 容器來做語音轉文字。

> 延伸閱讀
>
> ---
> [介紹 WhisperX: AI 語音識別加上單詞級別的時間戳記和語音分離](@/AI/whisperx/index.md)

通過運行這兩個 GPU 容器應用，不僅可以驗證我們之前的 Podman 和 GPU 設定是否正確，還可以親身體驗 GPU 給這些 AI 應用帶來的巨大性能提升。在容器中運行這些應用能讓你更靈活地管理依賴關係，並在不同環境間輕鬆遷移。

另外，如果你在實作過程中遇到什麼問題歡迎在下方留言討論。說不定你踩到的地雷其他人已經踩過一次了。

總之，希望這篇文章對你有幫助。容器化的 GPU 應用確實帶來了很多便利，期待看到更多人在這個領域發揮創意，做出有趣的東西！
