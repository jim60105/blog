+++
title = "如何將CAD中導入PADS的2D線轉為板框"
description = "如何將CAD中導入PADS的2D線轉為板框"
date = 2013-11-12T22:47:00.003Z
updated = 2013-11-12T22:47:00.003Z
draft = true
aliases = [ ]

[taxonomies]
tags = [ ]
licenses = [ "GFDL 1.3" ]
+++
## 出處:<http://www.dzjs.net/html/PCBjishu/2008/0923/3375.html>

<!-- more -->

怕文章丟失故轉載，若有任何問題立刻刪除

步驟二使用合併而不是閉合

AUTOCAD 新版有改版
  
越来越多的人用PADS 软件设计PCB，但它的板框设计一直困扰着许多PADS的使用者。  
怎么将CAD 中导入PADS 的2D-Line 或PADS 自画的2D-Line 转为Board-Outline呢？ 各位观众，请看下面：

**一. CAD中板框的处理**1\. 用Auto CAD 打开结构图，先将不须要的部份删除，留下PCB板的部份。如图：  
[![](http://www.dzjs.net/upimg/userup/0809/23091203JH.jpg)](http://www.dzjs.net/upimg/userup/0809/23091203JH.jpg)  
2\. 闭合CAD 的线条 （因为在PP 中，只能将闭合的2D 线转为板框），在CAD中输入 PE ，按空格键（见CAD软件界面的底部命令栏, 注意，AutoCAD中，空格键就代表回车键）如图:  
[![](http://www.dzjs.net/upimg/userup/0809/2309125R1I.jpg)](http://www.dzjs.net/upimg/userup/0809/2309125R1I.jpg)  
按空格键, 显示：[![](http://www.dzjs.net/upimg/userup/0809/230913164117.jpg)](http://www.dzjs.net/upimg/userup/0809/230913164117.jpg) 提示：多条线选< M > ，我们的板框由很多条线组成，就按它的提示输入M 回车, 然后再用光标选取整个要闭合的板框。  
按空格键：[![](http://www.dzjs.net/upimg/userup/0809/2309135b603.jpg)](http://www.dzjs.net/upimg/userup/0809/2309135b603.jpg) 按提示输入Y按空格键: [![](http://www.dzjs.net/upimg/userup/0809/2309143N091.jpg)](http://www.dzjs.net/upimg/userup/0809/2309143N091.jpg) 提示合并输入 C  
按空格键：[![](http://www.dzjs.net/upimg/userup/0809/230914591491.jpg)](http://www.dzjs.net/upimg/userup/0809/230914591491.jpg) 提示输入合并的模糊距离，这个数值大概输入0.01-0.05 即可。输入：0.01 然后再按空格键。又一次的提示：  
[![](http://www.dzjs.net/upimg/userup/0809/2309153TL8.jpg)](http://www.dzjs.net/upimg/userup/0809/2309153TL8.jpg)  
此时不用管它，再按一次空格键，确认。 就这样，板框线条就在CAD 中闭合了。  
单击板框的一条线，发现会将整个板框都选取了，如图：  
[![](http://www.dzjs.net/upimg/userup/0809/2309155M5P.jpg)](http://www.dzjs.net/upimg/userup/0809/2309155M5P.jpg)  
3\. 比例调整， 因CAD与PP转换时，单位的不相同（CAD默认是mm，PP 中是mil），因此须在CAD中将图形的比例做一个调整。  
在CAD中输入 SC 按空格，选取整个板框，按空格。要求指定基点时，时板框的一角或任意地方单击鼠标一下, 出现如下提示：  
[![](http://www.dzjs.net/upimg/userup/0809/2309163260c.jpg)](http://www.dzjs.net/upimg/userup/0809/2309163260c.jpg)  
这个比例因子，就是单位毫米与密尔的换算比例: 39.37 ，输入39.37， 按空格，CAD 中的图形就被放大39.37 倍。  
4\. 另存为dxf 文件。点主菜单文件，再点另存为。格式选DXF 。

**二 . 导入PP并转换为Board-Outline**1．导入文件： 新建一个PP文件，点主菜单: File → Import 弹出如下窗口。  
[![](http://www.dzjs.net/upimg/userup/0809/23091Sb059.jpg)](http://www.dzjs.net/upimg/userup/0809/23091Sb059.jpg)  
选取刚才另存的DXF文件，点打开。  
[![](http://www.dzjs.net/upimg/userup/0809/23092005O41.jpg)](http://www.dzjs.net/upimg/userup/0809/23092005O41.jpg)  
点OK后, CAD 的图形就导进来了, 现在须马上确认尺寸是否正确。如下图：  
[![](http://www.dzjs.net/upimg/userup/0809/230920261230.jpg)](http://www.dzjs.net/upimg/userup/0809/230920261230.jpg)  
在下拉窗中选DXF格式  
直接点OK  
2\. 转换为Board-Outline , 由于导进PP的图形为2D-Line， 须转换为Board-Outline ，在PP 中的空白处右键，点：Select Shapes  
[![](http://www.dzjs.net/upimg/userup/0809/230920531K6.jpg)](http://www.dzjs.net/upimg/userup/0809/230920531K6.jpg)  
单击2D线，选取整个板框图形。再右键，点 Scale ,如图：  
[![](http://www.dzjs.net/upimg/userup/0809/23092112Z50.jpg)](http://www.dzjs.net/upimg/userup/0809/23092112Z50.jpg)  
弹出如下窗口：  
[![](http://www.dzjs.net/upimg/userup/0809/230922211554.jpg)](http://www.dzjs.net/upimg/userup/0809/230922211554.jpg)  
点OK 确定，就这样完成了。  
以上内容如有错误，敬请指正，谢谢！
