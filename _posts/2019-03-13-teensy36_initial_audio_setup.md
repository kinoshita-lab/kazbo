---
layout: post
title:  teensy3.6を買ってきて音が出るまで
date:  2019-03-13
tags: teensy TIL
---
BBBのライブで使うために[teensy3.6](https://www.pjrc.com/store/teensy36.html)を買った。
ここから音を出したい。Teensyのサンプルスケッチでは、オーディオ出力はSGTL5000経由になっているので、そのままでは使えない。
ドキュメントが整備されてなくて、あまり説明されてなさそうなので、手探りで音がでるところまでやってみた。

## Teensyduinoをインストールする
[Teensyduino](https://www.pjrc.com/teensy/teensyduino.html)のサイトへ行きダウンロードしてきてインストールした。

## Audio Design ToolからソースをExportする
[https://www.pjrc.com/teensy/gui/index.html](https://www.pjrc.com/teensy/gui/index.html)でパッチを組んでExportボタンを押す。

Teensy3.6のDAC0, DAC1から音を出すには、 output セクションにある "dacs" を使う。**dacではない**ので注意。
動かしてみて判明したのだけど、dacsにある2つの入力には別々のソースを入れる必要があるようだ。

つまり、

![ng]({{ site.baseurl }}/images/teensy_ng_connection.png)

こういうことは画面上では可能だが、実際にはこうするとDAC1からは音は出ない。

こういう風にすることで、両方から音が出るようになった(dacsの2つある入力のうち、上がDAC0、下がDAC1)。
![ok]({{ site.baseurl }}/images/teensy_ok_connection.png)

後々、パンニングとかを実装したくなった時はどうしたらいいのだろう？というのがちょっと気になった。


## Arduino IDEでスケッチを書く
- Board: Teensy3.6
- USB Type: Serial
とした。

Audio Design Toolからはソース片のようなものしか出ないので、そこに必要なコードを書いて動くようにする。
上のDAC0, 1の両方から音を出すには、例えばこのような感じにすればいいようだ。

{% highlight cpp %}

// ここから↓
#include <Audio.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <SerialFlash.h>

// GUItool: begin automatically generated code
AudioSynthWaveformSine   sine1;          //xy=333,282
AudioSynthWaveformSine   sine2;          //xy=346,361
AudioOutputAnalogStereo  dacs1;          //xy=659,282
AudioConnection          patchCord1(sine1, 0, dacs1, 0);
AudioConnection          patchCord2(sine2, 0, dacs1, 1);
// GUItool: end automatically generated code
// ここまではツールがはきだすコード

auto setup() -> void {     
    AudioMemory(15); // ここの数値が何を意味しているのか不明。10とか15とか。
    
    AudioNoInterrupts(); // Audioの割り込みを止める
    
    // DAC0側につないだsineの設定
    sine1.amplitude(1.0); 
    sine1.frequency(440.0);
    sine1.phase(0);

    // DAC1側につないだsineの設定
    sine2.amplitude(1.0);
    sine2.frequency(880.0);
    sine2.phase(0);

    AudioInterrupts(); // Audioの割り込み再開
}

auto loop() -> void {
    // ここでやることは特にない
}
{% endhighlight %}

これを書きこんだらサイン波が聞こえた。

## その他tips
- Serial Monitorにsetup()内で何かを表示させようとしても何も出ないかもしれない（深くは検証してない）
- Serial Monitorのwindowは開きっぱななしにしておいたほうが楽かも
- MsTimer2はTeensyでも使えた。TeensyduinoにもMsTimer2が同梱されているみたいで、コンパイル時に
```
Multiple libraries were found for "MsTimer2.h"
 Used: /home/kazbo/Arduino/libraries/MsTimer2
 Not used: /usr/share/arduino/hardware/teensy/avr/libraries/MsTimer2
 ```
このような警告（のようなもの）が出る。Teensyduino側のものを使っていない。ここは設定方法はあるのだろうか。動作の不具合などはなく、特別困ってはいないので放置。

