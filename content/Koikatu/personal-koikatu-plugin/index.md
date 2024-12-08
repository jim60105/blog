+++
title = "[Koikatu] コイカツ！ 個人插件介紹匯整 (Koikatsu Sunshine/戀愛活動) "
description = "此文列出我所有的 Koikatu 插件作品。"
date = 2020-07-28T19:44:00.072Z
updated = "2024-12-06T22:48:44.889Z"
aliases = [ "/2020/05/personal-koikatu-plugin.html" ]

[taxonomies]
tags = [ "Koikatsu Sunshine", "Koikatu", "C#" ]
licenses = [ "GFDL 1.3" ]

[extra]
banner = "preview.jpg"
featured = true
scripts = [ "Koikatu/personal-koikatu-plugin/index.js" ]
hot = true
+++

<figure>
{{ image(url="preview.jpg") }}
<figcaption>(角色是我家的，但是原始Scene不是我做的)</figcaption>
</figure>

{% alert (tip=true) %}
以下所有插件皆為 **BepInEx 5** 插件，且以 **Darkness** 為基準程式碼開發

如果遇到安裝問題，請參考這篇  
[コイカツ! 插件安裝方式、問題判斷及排除指南](@/Koikatu/install-and-debug-guide/index.md)

**更新記錄**請見  
**アップデートログ**はこちら  
Click here for **update logs**  
[>> コイカツ！ 個人插件更新記錄 <<](@/Koikatu/plugin-update-logs/index.md)
{% end %}

<!-- more -->

<style type="text/css">
  .animate {
    -moz-transition: 0.4s all;
    -o-transition: 0.4s all;
    -webkit-transition: 0.4s all;
    transition: 0.4s all;
  }
  div[name="languagePanel"] {
    float: left;
    overflow: hidden;
    width: 100%;
  }
  .row  {
  overflow: hidden;
  }

  .flip{
    text-align:center;
    cursor:pointer;
    border-radius: 5em;
    display: inline-block;
    padding: 0.2em 2.5%;
    box-sizing: content-box;
    z-index: 0;
    position: absolute;
  }

  .flip-container{
     width: 100%;
     height: 2em;
     position: relative;
     margin-top: 2em;
  }
</style>

<!--語言切換FlipButton-->
<div class="flip-container">
  <span class="flip animate" lan="zh" name="flip" onclick="toggleLanguage('zh')"
        style="background: rgb(255, 113, 66) none repeat scroll 0% 0%; width: 55%; z-index: 2;">中文</span>
  <span class="flip animate" lan="ja" name="flip" onclick="toggleLanguage('ja')"
        style="background: rgb(88, 190, 54) none repeat scroll 0% 0%; left: 55%; width: 20%; z-index: 1;">日本語</span>
  <span class="flip animate" lan="en" name="flip" onclick="toggleLanguage('en')"
        style="background: rgb(1, 138, 203) none repeat scroll 0% 0%; right: 0px; width: 20%; z-index: 0;">English</span>
</div>

<div class="row">
<div id="container_zh" class="animate zh" lan="zh" name="languagePanel"></div>
<div id="container_ja" class="animate ja" lan="ja" name="languagePanel"></div>
<div id="container_en" class="animate en" lan="en" name="languagePanel"></div>
</div>

<!--語言切換FlipButton-->
<div class="flip-container" style="margin-bottom: 2em;">
  <span class="flip animate" lan="zh" name="flip" onclick="toggleLanguage('zh')"
        style="background: rgb(255, 113, 66) none repeat scroll 0% 0%; width: 55%; z-index: 2;">中文</span>
  <span class="flip animate" lan="ja" name="flip" onclick="toggleLanguage('ja')"
        style="background: rgb(88, 190, 54) none repeat scroll 0% 0%; left: 55%; width: 20%; z-index: 1;">日本語</span>
  <span class="flip animate" lan="en" name="flip" onclick="toggleLanguage('en')"
        style="background: rgb(1, 138, 203) none repeat scroll 0% 0%; right: 0px; width: 20%; z-index: 0;">English</span>
</div>
