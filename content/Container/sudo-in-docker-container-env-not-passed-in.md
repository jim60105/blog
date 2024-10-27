+++
title = "在 Docker container 中執行 sudo 時，環境變數沒有生效"
description = "在 Docker container 中執行 sudo 時，環境變數沒有被傳入。"
date = 2022-03-10T21:22:00.019Z
updated = 2022-03-10T21:40:39.239Z
draft = false
aliases = [ "/2022/03/sudo-in-docker-container-env-not-passed-in.html" ]
extra = { }

[taxonomies]
tags = [ "Container", "Docker", "Linux" ]
+++

這是一篇備忘，其實標題就是關鍵了  
這不只是 docker 中會遇到的問題，但由於 docker 標準做法是用環境變數做設定，這導致特別容易踩中地雷<!--more-->

## 我遭遇的問題

我在執行 nextcloud 升級後遇到了提示說資料表缺欄位，要我執行 `occ db:add-missing-indices`  
我的 nextcloud 是部署在 docker 中，我習慣是先 `docker exec -it <container_name> bash` 打開裡面的 bash 來做事

好死不死這個 command 需要以 www-data 這個身份組來操作，我又收到如下提示

```
Console has to be executed with the user that owns the file config/config.php
Current user id: 0
Owner id of config.php: 33
Try adding 'sudo -u #33' to the beginning of the command (without the single quotes)
If running with 'docker exec' try adding the option '-u 33' to the docker command (without the single quotes)
```

這最後一行其實就是正確的指示，但我當時沒有注意到  
我使用了個<span class="danger">錯誤的做法</span>，也是我寫下這篇備忘的原因

**我在 container 中安裝了 sudo，並在裡面執行 `sudo -u`**

sudo 安裝完後我在 container 中下了這個 command

```bash
sudo -u www-data ./occ db:add-missing-indices
```

結果是得到了這個回應

```
Fatal error: Allowed memory size of 2097152 bytes exhausted (tried to allocate 446464 bytes) in /var/www/html/3rdparty/composer/autoload_real.php on line 37
```

## 釐清問題

把這段錯誤丟 Google 後我找到[這篇討論](https://help.nextcloud.com/t/solved-occ-command-php-fatal-error-allowed-memory-size-of-xxx-bytes-exhausted/108521/7)，其中有一個人提到了[這個 issue](https://github.com/nextcloud/docker/issues/1413)，在 issue 下的[這篇回答](https://github.com/nextcloud/docker/issues/1413#issuecomment-991186705)完整回覆了問題

> It seems the omission of the -p flag for su causes this problem. This flag ensures the environment of the user running the su command (usually root in this case) is preserved. So the behavior described as problematic is actually as expected.
>
> So `docker exec nextcloud su -p www-data -s /bin/bash -c '/var/www/html/occ'` should run just fine. Or any other command for that matter, such as the cron.php script in the issue description.
>
> Same for `docker exec -u www-data nextcloud /var/www/html/occ`.
>
> These work because the image already has the correct environment variables set (these are set in the Dockerfile). These can be overwritten using -e, but that will only happen for that shell, and they will need to be preserved using -p if using su in a subsequent command.
>
> If -p isn't set, it will revert to the default which apparently isn't enough. Not sure what that is though, as it complains it has exhausted the 2M limit, but the default limit of PHP 8 is 128M.

一言以蔽之，執行 sudo 時現有的環境變數不會生效。  
nextcloud image 使用環境變數來設定 php memory\_limit，缺少這個設定使得指令失敗

## 解決問題

事實上在 `docker exec` 有個 `-u` 參數，能以指定的身份組執行指令，且它會正確的載入我們在 docker 層面設定的環境變數

nextcloud 這問題正確的做法如下，**在 host 執行**

```bash
docker exec -u www-data <container_name> /var/www/html/occ db:add-missing-indices
```

## 結語

* su 時若要使環境變數生效 (保留至 su)，使用 `su -p`
* 千萬不要在 container 中 `sudo -u`，改用 `docker exec -u <username>`
