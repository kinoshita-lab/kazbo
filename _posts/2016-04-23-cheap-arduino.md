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
