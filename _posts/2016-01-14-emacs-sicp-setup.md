---
layout: post
title:  emacsに引きこもる
date:   2016-01-14
tags: sicp
---
SICPやるときに色々とアプリケーション切り替えるのがめんどくさい。emacsだけで全部終わればいいのに。

schemeをemacsで使うときに便利な[quack.el](http://www.neilvandyke.org/quack/)。
これ使うとマニュアルへのリンクがメニューにできて、クリックするとブラウザが開いて表示される。
マニュアル類は自分で追加や削除ができる。

emacsには24.4以降[eww](https://www.gnu.org/software/emacs/manual/html_node/eww/index.html#Top)
というWEBブラウザが入っている。これemacs内のデフォルトブラウザに指定すればquackのマニュアル類はemacs上で見ることができるようになる。

まずewwの設定。emacs内でのデフォルトブラウザをewwにする。
{% highlight emacs %}
(setq browse-url-browser-function 'eww-browse-url)
{% endhighlight %}


[Emacs24.4組み込みブラウザewwで目の疲れを1/10にする方法](http://rubikitch.com/2014/11/19/eww-nocolor/)の設定を追加。
{% highlight emacs %}
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))
{% endhighlight %}

quackの設定関係は、M-x customizeで入れていった。関係ありそうなところを抜き出すとこんな感じ。
quackそのままだとリンク切れのマニュアルとかあるし、使わないのが大量に入ってる。
日本語版SICPとかgaucheのマニュアルは日本語のやつにしたりした。
{% highlight emacs %}
;; M-x customizes
(custom-set-variables
 '(quack-manuals
   (quote
	((r6rs "R5RS" "http://www.r6rs.org/final/html/r6rs/r6rs-Z-H-2.html#node_toc_start" nil)
	 (gauche "Gauche Reference Manual" "http://practical-scheme.net/gauche/man/gauche-refj.html" nil)
	 (tspl "Scheme Programming Language (Dybvig)" "http://www.scheme.com/tspl/" nil)
	 (sicp "Structure and Interpretation of Computer Programs(JP)" "http://sicp.iijlab.net/fulltext/xcont.html" nil))))
)
;; git-gutter
{% endhighlight %}


これでとりあえず別のソフトを立ち上げないでSICPできる環境ができた。
