+++
title = "[Koikatu] コイカツ！ 個人插件介紹匯整 (Koikatsu Sunshine / 戀愛活動) "
description = "此文列出我所有的 Koikatu 插件作品。"
date = 2020-07-28T19:44:00.072Z
updated = 2023-05-19T14:01:59.489Z
draft = true
aliases = [ "/2020/05/personal-koikatu-plugin.html" ]

[taxonomies]
tags = [ "Koikatsu Sunshine", "Koikatu", "C#" ]

[extra]
banner = "CharaStudio-2019-12-22-14-45-35-Render.JPG"
featured = true
scripts = [ "Koikatu/personal-koikatu-plugin/flip-button.js" ]
+++

<figure>
{{ image(url="CharaStudio-2019-12-22-14-45-35-Render.JPG") }}
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
{% end %}<!--more-->

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
    z-index: 0;
    position: absolute;
  }
</style>

<!--語言切換FlipButton-->
<div style="height: 2em; width: 100%;position: relative;">
  <span class="flip animate" lan="zh" name="flip" onclick="toggleLanguage('zh')"
        style="background: rgb(255, 113, 66) none repeat scroll 0% 0%; width: 55%; z-index: 2;">中文</span>
  <span class="flip animate" lan="jp" name="flip" onclick="toggleLanguage('jp')"
        style="background: rgb(88, 190, 54) none repeat scroll 0% 0%; left: 55%; width: 20%; z-index: 1;">日本語</span>
  <span class="flip animate" lan="en" name="flip" onclick="toggleLanguage('en')"
        style="background: rgb(1, 138, 203) none repeat scroll 0% 0%; right: 0px; width: 20%; z-index: 0;">English</span>
</div>

<div class="row">
  <!--中文-->
  <div class="animate zh" lan="zh" name="languagePanel">
    <h2><a href="/2019/03/koikatu-studio-coordinate-load-option.html" target="_blank">服裝卡選擇性載入插件</a></h2>
    載入服裝卡片時，<span style="color: orange;">可以選擇要載入的細項</span>，包括飾品個別選擇<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo1.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/04/koikatu-studio-all-girls-plugin.html" target="_blank">Studio跨性別讀取</a></h2>
    實現Studio<span style="color: #ffa400;">跨性別替換角色</span>功能<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo2.gif"><img border="0" src="../demo2.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/04/koikatu-studio-simple-color-on-girls.html" target="_blank">Studio女體單色化插件</a></h2>
    使<span style="color: #ffa400;">女性</span>支持<span style="color: #ffa400;">單色化</span>功能<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo3.gif"><img border="0" src="../demo3.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/05/koikatu-studio-chara-only-load-body.html" target="_blank">Studio換人插件</a></h2>
    保留衣服和飾品，<span style="color: orange;">只替換人物</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo4.gif" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo4.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/05/koikatu-studio-reflect-fk-fix.html" target="_blank">Studio IK→FK修正插件</a></h2>
    修正「IK→FK」功能會重置手勢和脖子的問題，並增加了一個複製當前脖子方向到FK「→FK(首)」的功能<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo5-3.png" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo5-1.mp4" type="video/mp4">
        </source>
      </video></div>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo5-4.png" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo5-2.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/06/koikatu-studio-text-plugin.html" target="_blank">Studio文字插件</a></h2>
    在Studio內添加<span style="color: orange;">文字物件</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo6-2.JPG" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo6.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/07/koikatu-studio-auto-close-loading-scene-window.html" target="_blank">Studio自動關閉Scene載入視窗</a>
    </h2>
    Studio Load Scene視窗處，在Import或Load後可以<span style="color: orange;">自動關閉視窗</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.2%; position: relative; text-align: center;"><a
         href="../demo7.png" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo7.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/01/koikatubepinex-v5x-plugin-list-tool.html" target="_blank">插件清單工具</a></h2>
    導出當前遊戲中<span style="color: orange;"><b>已加載的</b></span>BepInEx插件和IPA插件清單<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.2%; position: relative; text-align: center;"><a
         href="../demo8.png" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo8.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/01/koikatu-fbi-open-up.html" target="_blank">開門查水表！</a></h2>
    此插件可依照原始角色，將她們向模板角色轉變。預設為<span style="color: orange;">蘿化</span>，也可以用來做<span
          style="color: orange;">三頭身化</span>。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><iframe
              allowfullscreen="" class="YOUTUBE-iframe-video" data-thumbnail-src="../demo9.png" frameborder="0"
              src="https://www.youtube.com/embed/0-286KH6ZQA?feature=player_embedded"
              style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"></iframe></div>
    <h2><a href="/2020/01/koikatubepinex-v5x-overlay-iris-overlay.html" target="_blank">角色Overlay隨服裝變換</a></h2>
    讓所有角色Overlay(Iris、Face、Body Overlay)隨著服裝變更，反映在人物存檔和服裝存檔上<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo10-2.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/02/koikatubepinex-v5x-png-capture-size.html" target="_blank">PNG存檔尺寸調整工具</a></h2>
    <span style="color: orange;">可調所有PNG存檔的拍照尺寸</span>、調整Maker中的檔案選擇器顯示列數、放大Studio SceneData選擇器的選中預覧、給PNG存檔加上浮水印角標<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo11.png"><img border="0" src="../demo11.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo11-1.png"><img border="0" src="../demo11-1.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/02/koikatubepinex-v5x-studio-studio-chika.html" target="_blank">Studio千佳替換器</a></h2>
    一鍵把Studio內的所有女角色都換成千佳(預設角色)，並<span style="color: #ffa400;">保</span><span
          style="color: orange;">留原始人物的身形數據</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo12.gif"><img border="0" src="../demo12.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/03/koikatubepinex-v5x-studio-studio-chara.html" target="_blank">Studio角色光綁定視角</a></h2>
    將Studio角色光和視角間之旋轉值連動，詳見預覧對比<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo13.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/03/koikatubepinex-v5x-studio-studio-dual.html" target="_blank">Studio雙螢幕</a></h2>
    啟用Studio的第二顯示器功能，<b><span style="color: orange;">必需要有實體雙顯示器才能使用</span><br />
    </b>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 30%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"><br />
        <source src="../demo14.mp4" type="video/mp4">
        </source><br />
      </video></div><br />
    <h2><a href="/2020/05/koikatubepinex-v5x-studio-studio-save.html" target="_blank">Studio儲存工作區順序修正</a></h2>
    以Studio的存檔邏輯，工作區中，在第一層之物件排序是以<span style="color: orange;">加入順序儲存 → 修改為以實際順序儲存</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 100%; position: relative; text-align: center;"><a
         href="../demo16.png"><img border="0" src="../demo16.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/05/koikatubepinex-v5x-studio-studio-body.html" target="_blank">Studio角色覆寫腳本</a></h2>
    一鍵<span style="color: orange;">覆寫</span>角色身體<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo15.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/05/koikatubepinex-v5x-transparent.html" target="_blank">透明背景</a></h2>
    <span style="color: orange;">透明視窗和背景</span>，可顯示和點擊視窗下的東西<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><iframe
              allowfullscreen="" class="YOUTUBE-iframe-video"
              data-thumbnail-src="https://i.ytimg.com/vi/1ooTUL_F4_s/0.jpg" frameborder="0"
              src="https://www.youtube.com/embed/1ooTUL_F4_s?feature=player_embedded"
              style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"></iframe></div>
    <h2><a href="/2020/06/koikatubepinex-v5x-save-load-compression.html" target="_blank">存檔壓縮</a></h2>
    使用LZMA對CharaFile、CoordinateFile、Studio SceneData存檔做<span style="color: orange;">壓縮</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 73.59%; position: relative; text-align: center;"><a
         href="../demo18.png"><img border="0" src="../demo18.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>
    <h2><a href="/2020/06/koikatubepinex-v5x-coordinate-capture.html" target="_blank">服裝拍攝姿勢解鎖</a></h2>
    <span style="color: #ffa400;">解除</span>拍照服裝存檔時的<span style="color: #ffa400;">姿勢限制</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 68.75%; position: relative; text-align: center;"><a
         href="../demo19.jpg"><img border="0" src="../demo19.jpg"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>
    <h2><a href="/2020/09/koikatu-studio-menu-scrolling-text.html" target="_blank">Studio選單跑馬燈</a></h2>
    在Studio的添加物品清單添加<span style="color: #ffa400;">滾動顯示功能</span>，並在分類清單顯示自訂文字<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo20.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/09/koikatu-what-are-you-saying.html" target="_blank">りしれ供さ小</a></h2>
    本年度最無用作品，核心功能是<span style="color: #ffa400;">讓你看不懂他們在說啥</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo21.png"><img border="0" src="../demo21.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>
  </div>
  <!--日文-->
  <div class="animate jp" lan="jp" name="languagePanel">
    <h2><a href="/2019/03/koikatu-studio-coordinate-load-option.html" target="_blank">Coordinate Load Option</a></h2>
    衣裝データをロードするとき、<span style="color: orange;">アクセサリーの個別の選択を含む</span>、ロードする詳細を選択できます。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo1.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/04/koikatu-studio-all-girls-plugin.html" target="_blank">Studio Transgender Loading</a></h2>
    これにより、Studio内の<span style="color: #ffa400;">トランスジェンダーの役割置換</span>機能を実現します。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo2.gif"><img border="0" src="../demo2.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/04/koikatu-studio-simple-color-on-girls.html" target="_blank">Studio Simple Color On Girls</a>
    </h2>
    <span style="color: #ffa400;">女性</span>が<span style="color: #ffa400;">モノクロ機能</span>をサポートできるようにします。 <br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo3.gif"><img border="0" src="../demo3.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/05/koikatu-studio-chara-only-load-body.html" target="_blank">Studio Chara Only Load Body</a></h2>
    服とアクセサリーをそのまま、<span style="color: orange;">キャラクターのみを変更できる</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo4.gif" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo4.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/05/koikatu-studio-reflect-fk-fix.html" target="_blank">Studio Reflect FK Fix</a></h2>
    「IK→FK」機能がジェスチャーと首をリセットする問題を修正しました、現在の首の方向をFK「→FK（首）」にコピーする機能を追加した。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo5-3.png" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo5-1.mp4" type="video/mp4">
        </source>
      </video></div>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo5-4.png" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo5-2.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/06/koikatu-studio-text-plugin.html" target="_blank">Studio Text Plugin</a></h2>
    Studioで<span style="color: orange;">テキストオブジェクト</span>を追加します。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo6-2.JPG" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo6.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/07/koikatu-studio-auto-close-loading-scene-window.html" target="_blank">Studio Auto Close Loading
        Scene Window</a></h2>
    Studio Load Sceneウィンドウでは、インポートまたはロード後にウィンドウを<span style="color: orange;">自動的に閉じることができます</span>。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.2%; position: relative; text-align: center;"><a
         href="../demo7.png" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo7.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/01/koikatubepinex-v5x-plugin-list-tool.html" target="_blank">Plugin List Tool</a></h2>
    導出當前遊戲中<span style="color: orange;"><b>已加載的</b></span>BepInEx插件和IPA插件清單<br />
    現在のゲームに<b><span style="color: orange;">読み込まれて</span></b>いるBepInExプラグインとIPAプラグインのリストをエクスポートします。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.2%; position: relative; text-align: center;"><a
         href="../demo8.png" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo8.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/01/koikatubepinex-v5x-fbi-open-up.html" target="_blank">FBI Open Up</a></h2>
    このプラグインは、元のキャラクターに合わせてテンプレートキャラクターに変更。 デフォルトは<span style="color: orange;">ロリ化</span>です。これは<span
          style="color: orange;">三頭身化</span>を作成するためにも使用できます。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><iframe
              allowfullscreen="" class="YOUTUBE-iframe-video" data-thumbnail-src="../demo9.png" frameborder="0"
              src="https://www.youtube.com/embed/0-286KH6ZQA?feature=player_embedded"
              style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"></iframe></div>
    <h2><a href="/2020/01/koikatubepinex-v5x-overlay-iris-overlay.html" target="_blank">Chara Overlays Based On
        Coordinate</a></h2>
    すべてのキャラクターオーバーレイ（アイリス、フェイス、ボディオーバーレイ）を衣装で変更し、キャラクターカードや衣装カードに反映させます<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo10-2.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/02/koikatubepinex-v5x-png-capture-size.html" target="_blank">PNG Capture Size Modifier</a></h2>
    <span style="color: orange;">すべてのPNGアーカイブの写真サイズを調整し</span>、Makerのファイルセレクターに表示される列の数を調整し、Studio
    SceneDataセレクターの選択したプレビューを拡大し、PNGアーカイブに透かしを追加します<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo11.png"><img border="0" src="../demo11.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo11-1.png"><img border="0" src="../demo11-1.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/02/koikatubepinex-v5x-studio-studio-chika.html" target="_blank">Studio Chika Replacer</a></h2>
    ワンクリックでStudioのすべての女性キャラクターを千佳（デフォルトキャラクター）に変更し、<span style="color: orange;">オリジナルのフィギュアデータを保持します</span>。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo12.gif"><img border="0" src="../demo12.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/03/koikatubepinex-v5x-studio-studio-chara.html" target="_blank">Studio Chara Light Linked To
        Camera</a></h2>
    Studioキャラクターライトと視野角の間の回転値をリンクします。詳細については、プレビューの比較を参照してください。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo13.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/03/koikatubepinex-v5x-studio-studio-dual.html" target="_blank">Studio Dual Screen</a></h2>
    Studioのデュアルモニター機能を有効にします。<b>&nbsp;<span style="color: orange;">使用するには2つのモニターが必要です。</span><br />
    </b>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 30%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"><br />
        <source src="../demo14.mp4" type="video/mp4">
        </source><br />
      </video></div>
    <h2><a href="/2020/05/koikatubepinex-v5x-studio-studio-save.html" target="_blank">Studio Save Workspace Order
        Fix</a></h2>
    Studioのアーカイブロジックに基づいて、ワークスペースの最初のレイヤーのオブジェクトの順序は、<span
          style="color: orange;">追加の順序で格納されます→実際の順序で格納されるように変更されます。</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 100%; position: relative; text-align: center;"><a
         href="../demo16.png"><img border="0" src="../demo16.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/05/koikatubepinex-v5x-studio-studio-body.html" target="_blank">Studio Body Overwrite Script</a>
    </h2>
    ワンクリックでキャラクターのボディを<span style="color: orange;">上書き</span>。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo15.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/05/koikatubepinex-v5x-transparent.html" target="_blank">Transparent Background</a></h2>
    <span style="color: orange;">透明なウィンドウと背景</span>、ウィンドウの下にあるものを表示してクリックできます<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><iframe
              allowfullscreen="" class="YOUTUBE-iframe-video"
              data-thumbnail-src="https://i.ytimg.com/vi/1ooTUL_F4_s/0.jpg" frameborder="0"
              src="https://www.youtube.com/embed/1ooTUL_F4_s?feature=player_embedded"
              style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"></iframe></div>
    <h2><a href="/2020/06/koikatubepinex-v5x-save-load-compression.html" target="_blank">Save Load Compression</a></h2>
    LZMAを使用して、CharaFile、CoordinateFile、Studio SceneDataアーカイブを<span style="color: orange;">圧縮</span>します。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 73.59%; position: relative; text-align: center;"><a
         href="../demo18.png"><img border="0" src="../demo18.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>
    <h2><a href="/2020/06/koikatubepinex-v5x-coordinate-capture.html" target="_blank">Coordinate Capture Pose Unlock</a>
    </h2>
    衣装カード保存ファイルをキャプチャするときの<span style="color: #ffa400;">姿勢制限を削除します</span>。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 68.75%; position: relative; text-align: center;"><a
         href="../demo19.jpg"><img border="0" src="../demo19.jpg"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>
    <h2><a href="/2020/09/koikatu-studio-menu-scrolling-text.html" target="_blank">Studio Menu Scrolling Text</a></h2>
    Studioでアイテムリストに<span style="color: #ffa400;">スクロール表示機能</span>と文字入力機能を実現しています。<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo20.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/09/koikatu-what-are-you-saying.html" target="_blank">What are you saying?</a></h2>
    今年で最も役に立たないMOD、文字を読まないようにするだけ<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo21.png"><img border="0" src="../demo21.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>
  </div>

  <!--English-->
  <div class="animate en" lan="en" name="languagePanel">
    <h2><a href="/2019/03/koikatu-studio-coordinate-load-option.html" target="_blank">Coordinate Load Option</a></h2>
    When loads the coordinate card, <span style="color: orange;">you can select the details to be loaded</span>,
    including the individual selection of accessories.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo1.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/04/koikatu-studio-all-girls-plugin.html" target="_blank">Studio Transgender Loading</a></h2>
    This will enable Studio <span style="color: #ffa400;">transgender character replacement</span> function.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo2.gif"><img border="0" src="../demo2.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/04/koikatu-studio-simple-color-on-girls.html" target="_blank">Studio Simple Color On Girls</a>
    </h2>
    To enable <span style="color: #ffa400;">female</span> to support <span style="color: #ffa400;">the simple color
      function</span>.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo3.gif"><img border="0" src="../demo3.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/05/koikatu-studio-chara-only-load-body.html" target="_blank">Studio Chara Only Load Body</a></h2>
    Keep clothes and accessories and<span style="color: orange;"> only replace characters</span>.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo4.gif" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo4.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2019/05/koikatu-studio-reflect-fk-fix.html" target="_blank">Studio Reflect FK Fix</a></h2>
    Fix the problem that the "IK→FK" function will reset gestures and neck, and add a function to copy the current neck
    direction to FK.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo5-3.png" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo5-1.mp4" type="video/mp4">
        </source>
      </video></div>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo5-4.png" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo5-2.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/06/koikatu-studio-text-plugin.html" target="_blank">Studio Text Plugin</a></h2>
    Add<span style="color: orange;"> text objects</span> in Studio.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" poster="../demo6-2.JPG" preload="auto"
             style="height: 100%; left: 0; margin-left: 1em; margin-right: 1em; position: absolute; top: 0; width: 100%;">
        <source src="../demo6.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2019/07/koikatu-studio-auto-close-loading-scene-window.html" target="_blank">Studio Auto Close Loading
        Scene Window</a></h2>
    In the Studio Load Scene window, the window can be <span style="color: orange;">automatically closed</span> after
    Import or Load.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.2%; position: relative; text-align: center;"><a
         href="../demo7.png" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo7.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/01/koikatubepinex-v5x-plugin-list-tool.html" target="_blank">Plugin List Tool</a></h2>
    Export the <span style="color: orange;"><b>loaded</b></span> BepInEx plugin and IPA plugin list in the current
    game.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.2%; position: relative; text-align: center;"><a
         href="../demo8.png" rel="noopener noreferrer" target="_blank"><img alt="image" height="359" src="../demo8.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/01/koikatubepinex-v5x-fbi-open-up.html" target="_blank">FBI Open Up</a></h2>
    This plugin can change body to template chara according to the original chara. The default behavior is <span
          style="color: orange;">lolify</span>, which can also be used to <span
          style="color: orange;">chibify</span>.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><iframe
              allowfullscreen="" class="YOUTUBE-iframe-video" data-thumbnail-src="../demo9.png" frameborder="0"
              src="https://www.youtube.com/embed/0-286KH6ZQA?feature=player_embedded"
              style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"></iframe></div>
    <h2><a href="/2020/01/koikatubepinex-v5x-overlay-iris-overlay.html" target="_blank">Chara Overlays Based On
        Coordinate</a></h2>
    Make all character's Overlay (Iris, Face, Body Overlay) change with the costume. Can be saved with character file
    and coordinate file.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo10-2.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/02/koikatubepinex-v5x-png-capture-size.html" target="_blank">PNG Capture Size Modifier</a></h2>
    <span style="color: orange;">You can adjust the capture size of save files</span>, adjust the number of rows
    displayed by the file selector in Maker, enlarge the selected preview of the Studio SceneData selector, and add
    watermarks at corners.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo11.png"><img border="0" src="../demo11.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo11-1.png"><img border="0" src="../demo11-1.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/02/koikatubepinex-v5x-studio-studio-chika.html" target="_blank">Studio Chika Replacer</a></h2>
    One click to change all female characters to Chika (default chan) in Studio, and<span style="color: orange;"> retain
      the original body data</span>.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo12.gif"><img border="0" src="../demo12.gif"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/03/koikatubepinex-v5x-studio-studio-chara.html" target="_blank">Studio Chara Light Linked To
        Camera</a></h2>
    Link the rotation value between the Studio chara light and the viewing angle, see the preview comparison for
    details.
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo13.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/03/koikatubepinex-v5x-studio-studio-dual.html" target="_blank">Studio Dual Screen</a></h2>
    To enable Studio's second monitor function, <b><span style="color: orange;">you must have two physical monitors to
        use it.</span><br />
    </b>
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 30%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"><br />
        <source src="../demo14.mp4" type="video/mp4">
        </source><br />
      </video></div><br />
    <h2><a href="/2020/05/koikatubepinex-v5x-studio-studio-save.html" target="_blank">Studio Save Workspace Order
        Fix</a></h2>
    Based on Studio's save file logic, the order of objects in the first layer in the workspace is <span
          style="color: orange;">stored in the order of addition → modified to be stored in the actual
      order.</span><br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 100%; position: relative; text-align: center;"><a
         href="../demo16.png"><img border="0" src="../demo16.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a></div>
    <h2><a href="/2020/05/koikatubepinex-v5x-studio-studio-body.html" target="_blank">Studio Body Overwrite Script</a>
    </h2>
    <span style="color: orange;">Overwrite </span>the character's body with one click.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo15.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/05/koikatubepinex-v5x-transparent.html" target="_blank">Transparent Background</a></h2>
    <span style="color: orange;">Transparent windows and backgrounds</span>, can display and click things under the
    windows.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><iframe
              allowfullscreen="" class="YOUTUBE-iframe-video"
              data-thumbnail-src="https://i.ytimg.com/vi/1ooTUL_F4_s/0.jpg" frameborder="0"
              src="https://www.youtube.com/embed/1ooTUL_F4_s?feature=player_embedded"
              style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;"></iframe></div>
    <h2><a href="/2020/06/koikatubepinex-v5x-save-load-compression.html" target="_blank">Save Load Compression</a></h2>
    Use LZMA to <span style="color: orange;">compress </span>CharaFile, CoordinateFile, Studio SceneData save
    files.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 73.59%; position: relative; text-align: center;"><a
         href="../demo18.png"><img border="0" src="../demo18.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>
    <h2><a href="/2020/06/koikatubepinex-v5x-coordinate-capture.html" target="_blank">Coordinate Capture Pose Unlock</a>
    </h2>
    <span style="color: #ffa400;">Remove the pose restriction</span> when capturing the coordinate save file.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 68.75%; position: relative; text-align: center;"><a
         href="../demo19.jpg"><img border="0" src="../demo19.jpg"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>
    <h2><a href="/2020/09/koikatu-studio-menu-scrolling-text.html" target="_blank">Studio Menu Scrolling Text</a></h2>
    Add <span style="color: #ffa400;">scrolling display function</span> to the list of add&gt;&gt;items in Studio, and
    display custom text in the category list.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><video
             class="video-js" controls="" data-setup="{}" loop="loop" preload="auto"
             style="height: 100%; left: 0; position: absolute; top: 0; width: 100%;">
        <source src="../demo20.mp4" type="video/mp4">
        </source>
      </video></div>
    <h2><a href="/2020/09/koikatu-what-are-you-saying.html" target="_blank">What are you saying?</a></h2>
    The most useless work of the year. The core function is <span style="color: #ffa400;">to make you unable to read
      what they are saying</span>.<br />
    <div class="separator"
         style="clear: both; overflow: hidden; padding-bottom: 56.25%; position: relative; text-align: center;"><a
         href="../demo21.png"><img border="0" src="../demo21.png"
             style="height: 100%; left: 0px; position: absolute; top: 0px; width: 100%;" /></a> </div>

  </div>
</div>

<!--語言切換FlipButton-->
<div style="height: 2em; width: 100%;position: relative;">
  <span class="flip animate" lan="zh" name="flip" onclick="toggleLanguage('zh')"
        style="background: rgb(255, 113, 66) none repeat scroll 0% 0%; width: 55%; z-index: 2;">中文</span>
  <span class="flip animate" lan="jp" name="flip" onclick="toggleLanguage('jp')"
        style="background: rgb(88, 190, 54) none repeat scroll 0% 0%; left: 55%; width: 20%; z-index: 1;">日本語</span>
  <span class="flip animate" lan="en" name="flip" onclick="toggleLanguage('en')"
        style="background: rgb(1, 138, 203) none repeat scroll 0% 0%; right: 0px; width: 20%; z-index: 0;">English</span>
</div>
