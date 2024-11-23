+++
title = "[Koikatu] コイカツ！ 個人插件更新記錄"
description = "[Koikatu] コイカツ！ 個人插件更新記錄"
date = 2022-12-04T12:36:00.004Z
updated = 2023-09-30T18:12:35.830Z
draft = false
aliases = [ "/2020/05/koikatu-update-log.html" ]

[taxonomies]
tags = [ "Koikatu", "Koikatsu Sunshine" ]

[extra]
+++

<style>
  .header > h3{
    border-bottom: 0px;
  }
  
  .container{
    border: 1px solid #FFF;
    background: #FFFFFF19;
    border-radius: 10px;
    margin: 10px;
    padding: 15px;
  }

  .container > .header{
    background: #00000070;
    border-radius: 10px 10px 0px 0px;
    font-weight: bold;
    margin: -15px -15px 14px -15px;
    padding: 8px;
    display: flex;
    align-items: stretch;
  }

  .container > .content{
    padding: 5px;
  }

  .header > .date{
    width: 150px;
    display: grid;
    text-align: center;
    border-right: 1px #666 solid;
    font-weight: normal;
    order:1;
    white-space: nowrap;
    align-content: center;
  }

  .header > .title{
    padding: 0 2vw;
    order:2;
    flex: 1 1 auto;
    display: grid;
    align-content: center;
  }

  .header > .version{
    color: darkgray;
    text-align: right;
    font-size: small;
    order:3;
    white-space: nowrap;
  }

  .version .releaseVersion{
    color: #FFF;
    font-size: x-large;
  }

  @media only screen and (max-width: 750px) {
    .header > .title {
      order: 4;
      flex-basis: 100%;
      text-align: center;
    }

    .container > .header {
      flex-wrap: wrap;
    }

    .header > .date {
      flex: 1 1 0%;
    }

    .header > .version {
      text-align: center;
      flex: 1 1 0%;
    }
  }
</style>

[![](banner.png)](banner.png)

---

<div style="text-align: center;">
  <a href="https://github.com/jim60105/KK/commits/KKSunshine" target="_blank">GitHub Commit History</a>
</div>

---

<div style="text-align: center;">
  此頁只做Log記錄用，請到下方鏈結尋找下載和其它資訊。<br />このページはロギング専用です。<br />ダウンロードやその他の詳細については、このリンクにアクセスしてください。<br />This
  page is only for logging, please go to this link for download and other
  details.<br />
  <font size="6"><a href="/2020/05/personal-koikatu-plugin.html">&gt;&gt;&gt; コイカツ！個人插件介紹匯整 &lt;&lt;&lt;</a></font>
</div>

---

<div class="container">
  <div class="header">
    <span class="date">2023/10/01</span>
    <h3 class="title"><b></b> Studio Chara Only Load Body</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v23.10.01.0</span></div>
      <div>RV.<span class="releaseVersion">v1.4.4</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>Add compatibility with AdditionalFKNodes<br>
      Currently there is no AdditionalFKNodes for KKS.<br>
      This update is to keep it consistent with the KK version.</li>
  </ul>
</div>
<div class="container">
  <div class="header">
    <span class="date">2023/10/01</span>
    <h3 class="title"><b><i>Koikatu</i></b> Studio Chara Only Load Body</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v23.10.01.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.11</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>Add compatibility with AdditionalFKNodes</li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2022/12/04</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v22.12.04.3</span></div>
      <div>RV.<span class="releaseVersion">v1.4.7</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>Fixed the issue where the ResolveInfo of unreplaced clothing/accessories would change from LocalSlot to Slot.</li><li>Fixed the mistake in the calculation of the maximum number of MoreAccessories.</li><li>MaterialEditor&nbsp;Support:&nbsp;Add Copy Material feature support.</li><li>Code refactor</li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2022/11/04</span>
    <h3 class="title">Studio Save Workspace Order Fix</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v22.11.04.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.1</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li><a href="https://github.com/jim60105/KK/commit/8d11d1fee942d8fe20cb272e5606363a08e4054a" rel="nofollow" target="_blank">Prevent crashes breaking studio save, for insurance</a> by ManlyMarco</li>
  </ul>
</div>
<div class="container">
  <div class="header">
    <span class="date">2022/11/04</span>
    <h3 class="title"><b><i>Koikatu</i></b>Studio Save Workspace Order Fix</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v22.11.04.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.2</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li><a href="https://github.com/jim60105/KK/commit/21b10f820364544661d8cd90a1bb1923cc5f30c6" rel="nofollow" target="_blank">Prevent crashes breaking studio save, for insurance</a> by ManlyMarco</li>
  </ul>
</div>
<div class="container">
  <div class="header">
    <span class="date">2022/11/02</span>
    <h3 class="title"><b><i>Koikatu</i></b>Studio Chika Replacer</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v22.11.02.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.2</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li><a href="https://github.com/jim60105/KK/pull/18/commits/895a7f4403ac5b9322352664637d7f096dd739c1" rel="nofollow" target="_blank">Add non-darkness KK support</a> by ManlyMarco</li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2022/06/30</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v22.06.30.0</span></div>
      <div>RV.<span class="releaseVersion">v1.4.3</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>When boundAcc, adjust UI display to avoid misunderstanding.</li>
  </ul>
</div>
<div class="container">
  <div class="header">
    <span class="date">2022/06/30</span>
    <h3 class="title"><b><i>Koikatu</i></b> Studio Chara Only Load Body</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v22.06.27.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.10</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li><a href="https://github.com/jim60105/KK/commit/da5156c53ac75cbe3fee010ec2ffa8729fc9f2dc" rel="nofollow" target="_blank">Fix crashing with MoreAccessories 2.x</a> by ManlyMarco</li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2022/05/08</span>
    <h3 class="title"><b><i>Koikatu</i></b> Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v22.05.08.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.9</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li><a href="https://github.com/jim60105/KK/commit/9faa5584743423ccd8ab5569cb64fe7d55e22167" rel="nofollow" target="_blank">Add MoreAccessories 2.x support</a> by ManlyMarco</li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2021/12/25</span>
    <h3 class="title"><b><i>Koikatu</i></b> Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.12.25.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.8.1</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>補上新機能在主動ClearAcc時，未正確清空髮飾品</li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2021/12/24</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.12.23.0</span></div>
      <div>RV.<span class="releaseVersion">v1.4.2</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>新增「在特定的插件資料存在時，關閉飾品選項功能」</li>
    <li>Fix changes on ABMX v4.4.4</li>
    <li>移除MoreAcc相關的RemoveEmptyFromBackToFront功能</li>
    <li>兼容KKS_MoreOutfits</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/12/24</span>
    <h3 class="title"><b><i>Koikatu</i></b> Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.12.23.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.8</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>新增「在特定的插件資料存在時，關閉飾品選項功能」</li>
    <li>Fix NullRefException with HairAccCus Supports</li>
    <li>Fix changes on ABMX v4.4.4 (Also change the dependent version to v4.4.4)</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/12/24</span>
    <h3 class="title">Save Load Compression</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.12.23.0</span></div>
      <div>RV.<span class="releaseVersion">v1.6.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>Chara、Coordinate、Scene的分別選項</li>
    <li>Change default settings</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/12/24</span>
    <h3 class="title">Studio Chara Only Load Body</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.12.23.0</span></div>
      <div>RV.<span class="releaseVersion">v1.4.3</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>兼容KKS_MoreOutfits</li>
  </ol>
</div>

<hr />
<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Chara Light Linked To Camera</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.09.24.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Simple Color On Girls</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.09.24.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Auto Close Loading Scene Window</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.09.27.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.1</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Chika Replacer</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.09.27.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Transgender Loading</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.09.27.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Save Workspace Order Fix</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.09.28.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Reflect FK Fix</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.09.28.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Dual Screen</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.10.04.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
    <li>現在在重新Enable時會自動SetLock(false)</li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">FBI Open Up</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.10.11.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.1</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>重新在原生環境(無插件環境)產生sample_chara.png</li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Text Plugin</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.10.23.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Studio Chara Only Load Body</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.10.24.0</span></div>
      <div>RV.<span class="releaseVersion">v1.4.2</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>調整依賴MoreAcc至2.0</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2021/10/30</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.10.29.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.1</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>調整依賴MoreAcc至2.0</li>
    <li>移除COBOC支援</li>
    <li>修正以在Studio中運作</li>
  </ol>
</div>

<hr />
<div class="container">
  <div class="header">
    <span class="date">2021/08/31</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.08.31.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.2</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>修正和HairAccCus支援相關的Null Reference Exception</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2021/08/30</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.08.29.2</span></div>
      <div>RV.<span class="releaseVersion">v1.2.1</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2021/08/30</span>
    <h3 class="title">PNG Capture Size Modifier</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.08.29.0</span></div>
      <div>RV.<span class="releaseVersion">v1.6.1</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2021/08/30</span>
    <h3 class="title">Save Load Compression</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.08.28.0</span></div>
      <div>RV.<span class="releaseVersion">v1.5.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/08/30</span>
    <h3 class="title">Coordinate Capture Pose Unlock</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.08.28.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<div class="container">
  <div class="header">
    <span class="date">2021/08/30</span>
    <h3 class="title">FBI Open Up</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.08.29.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2021/08/30</span>
    <h3 class="title">Plugin List Tool</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.08.29.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>升級至Koikatsu Sunshine</li>
    <li>升級至.NET Standard 2.0</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2021/01/04</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v21.01.04.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.6</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>更新以配合MaterialEditor v2.5</li>
    <li>升級BepInEx依頼至v5.4.5</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/12/29</span>
    <h3 class="title">Save Load Compression Web</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.12.29.1</span></div>
      <div>RV.<span class="releaseVersion">v-.-.-</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>Init: <a href="https://slcweb.maki0419.com/" target="_blank">https://slcweb.maki0419.com/</a></li>
  </ol>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/12/29</span>
    <h3 class="title">Save Load Compression</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.12.29.0</span></div>
      <div>RV.<span class="releaseVersion">v1.4.0</span></div></span>
  </div>
  <ol style="text-align: left;">
    <li>新增unzip浮水印，解決「舊有壓縮存檔轉存成未壓縮時，圖像上留有zip浮水印」的狀況</li>
    <li>程式重構</li>
    <li>存檔和舊有的完全通用，格式沒改</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/12/25</span>
    <h3 class="title">Studio Menu Scrolling Text</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.12.25.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.1</span></div></span>
  </div>
  修正
  <ol style="text-align: left;">
    <li>(中日文)字元長度計算問題</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/12/02</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.11.28.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.5</span></div></span>
  </div>
  修正:
  <ol style="text-align: left;">
    <li>在無COBOC或HairAcc的環境之錯誤<br />
(調整了幾個null check)</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/11/16</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.11.15.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.4</span></div></span>
  </div>
  調整:
  <ol>
    <li><b>程式重構</b>，這在插件支援部份改了很多，希望我沒有弄壞什麼</li>
    <li>Extension log改為使用BepLogger</li>
  </ol>
  修正:
  <ol style="text-align: left;">
    <li>
      在COBOC上的換衣邏輯錯誤，並補上換衣邏輯圖
      <div style="clear: both; text-align: center;">
        <a href="https://img.maki0419.com/blog/COBOC_Change_Logic.png" style="margin-left: 1em; margin-right: 1em;"><img border="0" data-original-height="265" data-original-width="589" src="https://img.maki0419.com/blog/COBOC_Change_Logic.png" /></a>
      </div>
    </li>
    <li>清空Acc會造成MaterialEditor資料丟失</li>
    <li>
      Maker中，未展開UI(以原生方式讀取)時不會反應飾品、服裝選擇項
    </li>
    <li>
      Maker中，當前選中之飾品為髮飾品，且讀入衣裝之該欄位非髮飾品時，在髮飾品比對會失敗
    </li>
    <li>補回讀取完成音</li>
    <li>讀取時飾品由後數的空欄會被省略，這造成無法用空欄服裝卡覆寫來做部份清除</li>
    <li>修復反選髮飾品功能</li>
    <li>對MaterialEditor Data的Texture Scale/Offset換衣錯誤</li>
    <li>ABMX裙讀入時的變型錯誤</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/10/15</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.10.15.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.1</span></div></span>
  </div>
  修正:
  <ol style="text-align: left;">
    <li>
      Maker中換衣時，HairAccData會覆寫至第一套(校內)並清空其它套服裝的問題
    </li>
    <li>
      Maker中，若原本的HairAccData有啟用ColorMatch，會在換完Acc後把飾品原生顏色回寫為HairMatchColor
    </li>
    <li>清除飾品按鈕，最多會留下40個空格的問題</li>
    <li>Maker中Deselect服裝時的error</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/10/3</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.10.02.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.0</span></div></span>
  </div>
  Maker UI修正:
  <ol style="text-align: left;">
    <li>UI不再顯示於存檔窗格</li>
    <li>如果沒有全勾原生的讀取toggle時，換衣會不完整</li>
    <li>開啟UI時在讀取\存檔窗格切換時，下方的toggle框之隱藏邏輯錯誤</li>
  </ol>
  <p>新增功能:</p>
  <ol style="text-align: left;">
    <li>UI位置記憶，可在ConfigurationManager中Reset</li>
  </ol>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/09/10</span>
    <h3 class="title">What are you saying?</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.09.10.1</span></div>
      <div>RV.<span class="releaseVersion">v1.0.0</span></div></span>
  </div>
  First Release
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/09/10</span>
    <h3 class="title">Studio Menu Scrolling Text</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.09.10.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.0</span></div></span>
  </div>
  增加速度調節功能
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/09/10</span>
    <h3 class="title">Save Load Compression</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.09.07.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.5</span></div></span>
  </div>
  修改token使之能通過CharacterReplacer<br />修改數處字串插值，用正確的方式做格式處理
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/09/04</span>
    <h3 class="title">Studio Menu Scrolling Text</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.09.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.0</span></div></span>
  </div>
  First Release
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/09/04</span>
    <h3 class="title">Studio Transgender Loading</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.30.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.2</span></div></span>
  </div>
  修正:
  <ul style="text-align: left;">
    <li>男轉女後，anim→狀態之乳首滑桿不會出現</li>
    <li>男轉女後，女體特有的調整項不會做動</li>
    <li>男轉女後，頭和頸小一圈；反之亦然<br /></li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/08/22</span>
    <h3 class="title">Chara Overlays Based On Coordinate</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.22.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.8</span></div></span>
  </div>
  修正在Studio中使用IrisSide時身體的白色錯誤
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/21</span>
    <h3 class="title">Save Load Compression</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.21.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.4</span></div></span>
  </div>
  修正壓縮完Compare時的UI文字Overflow問題
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.06.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.1</span></div></span>
  </div>
  原有的Studio Coordinate Load Option，改為<span style="color: #ffa400;">可在Maker中執行
  </span>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title"><strike>Studio Coordinate Load Option</strike></h3>
    <span class="version"><div>PV.<span class="pluginVersion">v--.--.--.-</span></div>
      <div>RV.<span class="releaseVersion">v-.-.-</span></div></span>
  </div>
  <span style="color: red;">淘汰</span>，以Coordinate Load Option取而代之
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Simple Color On Girls</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.2.0</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>
      修正Extension中有關Field、Property、Method的方法，<span style="color: #ffa400;">使之能在無IPAPatcher的環境執行</span>
    </li>
    <li>
      新增:
      <span style="color: lightgreen;">在男角色也新增「重置單色化顏色」功能</span>，選項在Config中分開
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">PNG Capture Size Modifier</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.06.0</span></div>
      <div>RV.<span class="releaseVersion">v1.5.5</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
    <li>修改Extension中有關圖像處理的部份</li>
    <li><span style="color: lightgreen;">新增Maker選窗列數上限</span><br /></li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Dual Screen</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.7</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
    <li><span style="color: #ffa400;">適配VMDPlay v0.2.4</span><br /></li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Transgender Loading</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.1</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Chara Only Load Body</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.9</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>
      修正Extension中有關Field、Property、Method的方法，<span style="color: #ffa400;">使之能在無IPAPatcher的環境執行</span>
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Reflect FK Fix</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.4</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
    <li>修改Extension中有關圖像處理的部份</li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Text Plugin</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.6</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Auto Close Loading Scene Window</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.4</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
    <li>Code整理<br /></li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Plugin List Tool</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.4</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
    <li>移除未使用的NuGet套件<br /></li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">FBI Open Up</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.3</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Chara Overlays Based On Coordinate</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.7</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Chika Replacer</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.1.1</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Chara Light Linked To Camera</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.5.4</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Studio Save Workspace Order Fix</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.1</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Transparent Background</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.1</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Save Load Compression</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.3</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
    <li>修改Extension中有關圖像處理的部份</li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/08/06</span>
    <h3 class="title">Coordinate Capture Pose Unlock</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.08.05.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.1</span></div></span>
  </div>
  <ul style="text-align: left;">
    <li>移除BepInEx.Harmony依賴，升級依賴下限至BepInEx5.1</li>
    <li>
      修正Extension中有關Field、Property、Method的方法，使之能在無IPAPatcher的環境執行
    </li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/07/29</span>
    <h3 class="title">PNG Capture Size Modifier</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.07.28.0</span></div>
      <div>RV.<span class="releaseVersion">v1.5.4</span></div></span>
  </div>
  修正<br />
  <ul style="text-align: left;">
    <li><span style="color: red;">升Bep5.1壞掉的東西</span></li>
    <li>H Scene中開啟服裝選擇清單時的error</li>
    <li>Maker中Chara Window的寬度偏差</li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/07/29</span>
    <h3 class="title">Chara Overlays Based On Coordinate</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.07.27.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.6</span></div></span>
  </div>
  修正<br />
  <ul style="text-align: left;">
    <li>
      Maker中，<span style="color: red;">讀取角色時會受到服裝視窗skin toggle影響</span>的問題<br />
    </li>
    <li>
      在<span style="color: red;">讀取「無CharaOverlay服裝」時IrisSide會初始化</span><br />(設計: Maker在coordinate中無插件資料時，無論有否勾上Load Skin
      toggle都不會做清空)
    </li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/07/29</span>
    <h3 class="title">Studio Transgender Loading</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.07.27.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.0</span></div></span>
  </div>
  <span style="color: #ffa400;">跨性別替換功能</span>，取代全女插件StudioAllGirlsPlugin
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/07/29</span>
    <h3 class="title"><strike>Studio All Girls Plugin</strike></h3>
    <span class="version"><div>PV.<span class="pluginVersion">v--.--.--.-</span></div>
      <div>RV.<span class="releaseVersion">v-.-.-</span></div></span>
  </div>
  <span style="color: red;">淘汰</span>，以Studio Transgender Loading取而代之
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/07/29</span>
    <h3 class="title">Studio Simple Color On Girls</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.07.27.1</span></div>
      <div>RV.<span class="releaseVersion">v1.1.0</span></div></span>
  </div>
  新增
  <span style="color: lightgreen;">在讀入角色/讀入Scene時強制重置單色化顏色</span>
  的功能
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/07/29</span>
    <h3 class="title">Plugin List Tool</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.07.27.1</span></div>
      <div>RV.<span class="releaseVersion">v1.0.3</span></div></span>
  </div>
  修改路徑為相對路徑，對應「第一次產生Default
  Config時的路徑」為暫用路徑造成的問題
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/07/29</span>
    <h3 class="title">Studio Chara Only Load Body</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.07.27.1</span></div>
      <div>RV.<span class="releaseVersion">v1.3.8</span></div></span>
  </div>
  修正圖標，Code整理
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/07/29</span>
    <h3 class="title">Studio Coordinate Load Option</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.07.26.0</span></div>
      <div>RV.<span class="releaseVersion">v3.3.6</span></div></span>
  </div>
  <span style="color: #ffa400;">適配MaterialEditor2.0.7、MoreAcc 1.1.0</span><br />KCOX和ABMX支援做了重寫<br /><span style="color: red;">修正髮FK Bone問題</span>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/06/23</span>
    <h3 class="title">Studio Simple Color On Girls</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.06.23.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.8</span></div></span>
  </div>
  修正 <br />
  <ul style="text-align: left;">
    <li><span style="color: red;">白雞雞問題</span></li>
    <li>會有兩個o_body_a的問題</li>
  </ul>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/06/09</span>
    <h3 class="title">Save Load Compression</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.06.10.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.2</span></div></span>
  </div>
  <div class="content">
    修正當資料夾中有錯誤存檔時，會無法顯示FileWindow內容的問題
  </div>
</div>

<div class="container" style="text-align: left;">
  <div class="header">
    <span class="date">2020/06/09</span>
    <h3 class="title">PNG Capture Size Modifier</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.06.08.0</span></div>
      <div>RV.<span class="releaseVersion">v1.5.2</span></div></span>
  </div>
  <ul>
    <li>可自訂分辨率文字圖像</li>
    <li>可自訂分辨率位置、大小</li>
    <li>分辨率可單獨開啟</li>
  </ul>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/06/09</span>
    <h3 class="title">Coordinate Capture Pose Unlock</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.06.07.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.0</span></div></span>
  </div>
  <div class="content">
    First Release
  </div>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/06/09</span>
    <h3 class="title">Save Load Compression</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.06.09.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.1</span></div></span>
  </div>
  <div class="content">
    First Release
  </div>
</div>

<div class="container">
  <div class="header">
    <span class="date">2020/06/07</span>
    <h3 class="title">Studio Body Overwrite Script</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.05.30.0</span></div>
      <div>RV.<span class="releaseVersion">v1.0.0.1</span></div></span>
  </div>
  <div class="content">
    另存編碼 Big5 → UTF8
  </div>
</div>
<hr />
<div class="container">
  <div class="header">
    <span class="date">2020/05/31</span>
    <h3 class="title">Chara Overlays Based On Coordinate</h3>
    <span class="version"><div>PV.<span class="pluginVersion">v20.05.30.0</span></div>
      <div>RV.<span class="releaseVersion">v1.3.5</span></div></span>
  </div>
  <div class="content">
    修正Studio中存檔時會報錯，因為多加了一個不需要的KKAPI.Studio.SaveLoad.StudioSaveLoadApi.SceneSave
    Event
  </div>
</div>
