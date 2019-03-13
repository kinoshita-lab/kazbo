---
layout: post
title:  中華duinoをmac el capitan以降のmac OSで使う方法まとめ
date:   2016-4-23
tags: arduino TIL
---
激安なarduino互換ボードをmacで使おうとすると、USB<->シリアル変換のICがオリジナルと違うため、ドライバーを別途インストールする必要がある。
ただ、そのドライバーはmac OS的に検証がされてないみたいで、インストールしても互換ボードを認識してくれない。といったことが起きた。
そうならないで使うためには以下の作業でOKだった。

- これをインストール[http://www.wch.cn/download/CH341SER_MAC_ZIP.html](http://www.wch.cn/download/CH341SER_MAC_ZIP.html)
- cmd+r 押しながら起動 ターミナルで

```
csrutil enable --without kext
```

  - 再起動

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="https://rcm-fe.amazon-adsystem.com/e/cm?ref=qf_sp_asin_til&t=kazbo0a-22&m=amazon&o=9&p=8&l=as1&IS1=1&detail=1&asins=B07LG5B2QQ&linkId=7c14f71c91f772d04001900e48300ef0&bc1=ffffff&lt1=_top&fc1=333333&lc1=0066c0&bg1=ffffff&f=ifr">
</iframe>