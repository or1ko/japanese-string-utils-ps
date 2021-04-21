# japanese-string-utils-ps

日本語テキストをひらがな、カタカナ、全角、半角、数字などへ変換するためのユーティリティです。

下記のJavaScriptを参考にして作成しました。

https://github.com/yomotsu/japanese-string-utils


![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/JapaneseStringUtils) [![GitHub license](https://img.shields.io/github/license/or1ko/japanese-string-utils-ps)](https://github.com/or1ko/japanese-string-utils-ps/blob/main/LICENSE)

## 利用方法

インストール

```powershell
> Install-Module -Name JapaneseStringUtils
```

利用例

```powershell
> ConvertTo-Hankaku "アいうえおＡ０１２"
ｱいうえおA012
> ConvertTo-Zenkaku "aいうえおA012ｱ"
ａいうえおＡ０１２ア
> ConvertTo-Hiragana "じゃパン"
じゃぱん
> ConvertTo-Katakana "じゃパン"
ジャパン
> ConvertFrom-Kansuuji "１億５千万一および百三十一"
150000001および131
```

