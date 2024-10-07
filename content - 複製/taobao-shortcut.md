+++
title = "逛淘寶小技巧--網址參數跳轉"
description = "逛淘寶小技巧--網址參數跳轉"
date = 2015-12-04T22:22:00.011Z
updated = 2020-11-24T14:56:53.457Z
draft = false
aliases = ["/2015/12/blog-post.html"]

[taxonomies]
tags = []

[extra]
banner = "https://4.bp.blogspot.com/-5yvRpFizkig/VmIR9M1qrUI/AAAAAAAAK2c/54Smp86GK-8/s640/2015-12-05%2B05%2B41%2B22.png"
+++
## 發現問題:

淘寶每次搜尋都會重置搜尋選項  
例如搜尋"裙子"，他就會直接搜尋所有的裙子   
但是我只要搜尋"BJD專區"的裙子，所以每次搜尋都在那邊點點點   
  
## 解法:

  
淘寶的搜尋選項是在網址後面加參數，就是那串"&OOO=XXXXXX"，所以只要把"BJD專區"的參數記下來，加在網址列後面就好  
例如:"BJD專區"是"&cat=50026909"  
  
## 書籤一勞永逸解法:

  
但是我比較懶，每次在那邊複製貼上也嫌煩，所以寫了段小script來跳轉網頁  

### item淘寶跳轉到world淘寶:

javascript:window.location.replace('http://world.taobao.com/item/'+location.href.match(/id=(\d+)/)[1]+'.htm');

###  world淘寶跳轉到item淘寶:

javascript:window.location.replace('https://item.taobao.com/item.htm?id='+location.href.match(/item\/(\d+)/)[1]);

### item淘寶URL清理:

javascript:window.location.replace('https://item.taobao.com/item.htm?id='+location.href.match(/id=(\d+)/)[1]);

### 跳轉到BJD專區:

javascript:window.location.replace(location.href+'&cat=50026909&sort=price-asc&fs=1');

把上面這些複製到書籤網址去，如圖  
  
[![](https://4.bp.blogspot.com/-5yvRpFizkig/VmIR9M1qrUI/AAAAAAAAK2c/54Smp86GK-8/s640/2015-12-05%2B05%2B41%2B22.png)](https://4.bp.blogspot.com/-5yvRpFizkig/VmIR9M1qrUI/AAAAAAAAK2c/54Smp86GK-8/s640/2015-12-05%2B05%2B41%2B22.png)
  
  
以後搜尋只要點一下這書籤，就會自動跳轉加上參數  
※加上了依照價格排序↑，常用的功能※   
  
舉一反三:  
至於其他的分類呢?  
只要搜尋一次，並且在那網頁的網址列尋找 "&cat=XXXXXX" ，把這串替換掉script裡面那段就是了  
  
  
快速跳轉wwwwwww