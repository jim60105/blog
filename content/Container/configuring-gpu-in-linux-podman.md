---
title: Configuring GPU in Fedora with Podman
date: 2024-11-09T08:53:24.448Z
updated: 2024-11-09T08:53:24.449Z
draft: true
description: Configuring GPU in Fedora with Podman
taxonomies:
  tags:
    - Container
    - Linux
    - RHEL/Fedora
  licenses:
    - GFDL 1.3
---
## Install Podman Compose

## Install Podman Desktop

## Configure `podman compose` to use podman-compose but NOT docker-compose

Podman Desktop uses `podman-compose` instead of `docker-compose`.

Currently, `docker-compose` is not working with `podman` with CDI. _Issue: [podman issue #19338](https://github.com/containers/podman/issues/19338)_

So we have to make `podman compose` use `podman-compose` instead of `docker-compose`.

<https://docs.podman.io/en/v5.1.1/markdown/podman-compose.1.html>

<https://docs.podman.io/en/stable/markdown/podman.1.html#configuration-files>

$HOME/.config/containers/containers.conf

```toml, linenos
[engine]
  compose_providers = [ "podman-compose" ]
```

## Install NVIDIA Driver

<https://rpmfusion.org/Howto/OSTree>

<https://rpmfusion.org/Howto/NVIDIA#Installing_the_drivers>


## Install NVIDIA Container Toolkit

<https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-yum-or-dnf>

```bash
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
```

```bash
sudo dnf install -y nvidia-container-toolkit
```

## Check things works

```
$ modinfo -F version nvidia
565.57.01
```

```
$ sudo rpm-ostree status -avb
State: idle
AutomaticUpdates: disabled
BootedDeployment:
● fedora:fedora/41/x86_64/kinoite (index: 0)
                  Version: 41.20241212.0 (2024-12-12T00:44:08Z)
               BaseCommit: b8b76d8c6530068936d5bf79c077e5c8751bd4129da0fc5bbb4be74db2b16d81
                           ├─ repo-0 (2024-10-24T13:55:59Z)
                           ├─ repo-1 (2024-12-12T00:16:34Z)
                           └─ repo-2 (2024-12-12T00:21:13Z)
                   Commit: 03bacc3a893793895ecd09927ac326af0c2740c965e9f83106644d35269f976d
                           ├─ copr:copr.fedorainfracloud.org:phracek:PyCharm (2024-12-03T03:46:53Z)
                           ├─ fedora (2024-10-24T13:55:59Z)
                           ├─ fedora-cisco-openh264 (2024-03-11T19:22:31Z)
                           ├─ google-chrome (2024-12-12T08:17:54Z)
                           ├─ nvidia-container-toolkit (2024-12-04T12:02:48Z)
                           ├─ rpmfusion-free (2024-10-27T07:49:25Z)
                           ├─ rpmfusion-free-updates (2024-12-05T20:56:50Z)
                           ├─ rpmfusion-nonfree (2024-10-27T07:58:23Z)
                           ├─ rpmfusion-nonfree-nvidia-driver (2024-12-05T20:48:13Z)
                           ├─ rpmfusion-nonfree-steam (2024-12-02T07:45:38Z)
                           ├─ rpmfusion-nonfree-updates (2024-12-05T21:12:14Z)
                           ├─ updates (2024-12-12T01:29:43Z)
                           └─ updates-archive (2024-12-12T01:58:17Z)
                   Staged: no
                StateRoot: fedora
             GPGSignature: 1 signature
                           Signature made 西元2024年12月12日 (週四) 08時45分34秒 using RSA key ID D0622462E99D6AD1
                           Good signature from "Fedora <fedora-41-primary@fedoraproject.org>"
      RemovedBasePackages: libavdevice-free libavfilter-free libavformat-free ffmpeg-free libpostproc-free libswresample-free libavutil-free libavcodec-free libswscale-free 7.0.2-7.fc41
         InactiveRequests: gstreamer1-plugin-libav
          LayeredPackages: akmod-nvidia fcitx5 fcitx5-rime ffmpeg gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly
                           gstreamer1-vaapi input-remapper libva-utils nvidia-container-toolkit nvidia-vaapi-driver rpmfusion-free-release rpmfusion-nonfree-release
                           vdpauinfo xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda
```

```
$ vdpauinfo
display: :0   screen: 0
API version: 1
Information string: NVIDIA VDPAU Driver Shared Library  565.57.01  Thu Oct 10 11:55:58 UTC 2024
...
```

## CDI (Container Device Interface)

```bash
sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
```

```bash
nvidia-ctk cdi list
```

```bash
podman run --rm --device nvidia.com/gpu=all --security-opt=label=disable ubuntu nvidia-smi -L
```
