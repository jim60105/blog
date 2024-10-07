+++
title = "WINDOWS 7開機時自動登入設定 (網域適用)"
description = "WINDOWS 7開機時自動登入設定 (網域適用)"
date = 2017-10-23T01:39:00.006Z
updated = 2021-01-24T09:44:01.677Z
draft = false
aliases = [ "/2017/10/windows-7.html" ]

[taxonomies]
tags = [ ]

[extra]
banner = ""
+++
Win+R: Regedit  
HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon  
  
AutoAdminLogon 1  
DefaultUserName (新增字串值)  
DefaultPassword (新增字串值)  
ForceAutoLogon 1 (新增DWORD 值)  
  
WINDOWS 7開機時自動登入設定 (網域適用) | Fibe-mini 's BLOG  
<http://www.fibe-mini.com.tw/windows-7%E9%96%8B%E6%A9%9F%E6%99%82%E8%87%AA%E5%8B%95%E7%99%BB%E5%85%A5%E8%A8%AD%E5%AE%9A-%E7%B6%B2%E5%9F%9F%E9%81%A9%E7%94%A8.html>  