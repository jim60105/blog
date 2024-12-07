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

## Install NVIDIA Container Toolkit

<https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#installing-with-yum-or-dnf>

```bash
curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
```

```bash
sudo dnf install -y nvidia-container-toolkit
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
