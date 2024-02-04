# Docker Cloudflare Argo Tunnel client

[![Docker Pulls](https://img.shields.io/docker/pulls/afonsoc12/cloudflared?logo=docker)](https://hub.docker.com/repository/docker/afonsoc12/cloudflared) 
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

[![Github Starts](https://img.shields.io/github/stars/afonsoc12/docker-cloudflared?logo=github)](https://github.com/afonsoc12/docker-cloudflared)
[![Github Fork](https://img.shields.io/github/forks/afonsoc12/docker-cloudflared?logo=github)](https://github.com/afonsoc12/docker-cloudflared)
[![Github Release](https://img.shields.io/github/v/release/afonsoc12/docker-cloudflared?logo=github)](https://github.com/afonsoc12/docker-cloudflared/releases)

[cloudflared](https://github.com/cloudflare/cloudflared) is the command-line client for Cloudflare Tunnel, *"a tunneling daemon that proxies traffic from the Cloudflare network to your origins"*. 

This repository automatically builds and pushes docker images for the latest releases of [cloudflare/cloudflared](https://github.com/cloudflare/cloudflared) git repository, in both `linux/amd64` and `linux/arm64` architectures.

> Note: Cloudflare now provides `linux/arm64` images, therefore I'm archiving this repo. Please check [cloudflare/cloudflared](https://hub.docker.com/r/cloudflare/cloudflared) for more information.

# Instalation

The image can be pulled from both [DockerHub](https://hub.docker.com/r/afonsoc12/cloudflared) and [ghcr.io](https://github.com/afonsoc12/docker-cloudflared/pkgs/container/cloudflared) container registries.

```shell
# You can also specify a version as the tag, such as afonsoc12/cloudflared:2022.5.1
docker pull afonsoc12/cloudflared:latest

# Should print cloudflared version
docker run --rm afonsoc12/cloudflared

```

The commands for cloudflared are parsed as docker commands, e.g., to create a tunnel:

```shell
docker run afonsoc12/cloudflared tunnel create mytunnel
```
Please consult [the official documentation](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/create-tunnel) on Cloudflare's website.


## Credits

Copyright 2022 Afonso Costa

Licensed under the [Apache License, Version 2.0](https://github.com/afonsoc12/docker-cloudflared/blob/master/LICENSE) (the "License")
