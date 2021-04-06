<#
 .Synopsis
  全角文字を半角文字に変換します。

 .Description
  引数の文字列にある全角文字を半角文字に変換します。

 .Parameter Str
  変換対象の文字列

 .Example
   # 全角文字を半角文字に変換 
   ConvertTo-Hankaku "aｂc１23アｲう" 
   abc123ｱｲう
#>
function ConvertTo-Hankaku {
    param([String] $str)

    process {
      Add-Type -AssemblyName Microsoft.VisualBasic
      return [Microsoft.VisualBasic.Strings]::StrConv($str, [Microsoft.VisualBasic.VbStrConv]::Narrow)
    }
}
Export-ModuleMember -Function ConvertTo-Hankaku

<#
 .Synopsis
  半角文字を全角文字に変換します。

 .Description
  引数の文字列にある半角文字を全角文字に変換します。

 .Parameter Str
  変換対象の文字列

 .Example
   # 半角文字を全角文字に変換 
   ConvertTo-Zenkaku "aｂc１23アｲう" 
   ａｂｃ１２３アイう
#>
function ConvertTo-Zenkaku {
    param([String] $str)

    process {
      Add-Type -AssemblyName Microsoft.VisualBasic
      return [Microsoft.VisualBasic.Strings]::StrConv($str, [Microsoft.VisualBasic.VbStrConv]::Wide)
    }
}
Export-ModuleMember -Function ConvertTo-Zenkaku

<#
 .Synopsis
  カタカナをひらがなに変換します。

 .Description
  引数の文字列にあるカタカナをひらがなに変換します。

 .Parameter Str
  変換対象の文字列

 .Example
   # カタカナをひらがなに変換
   ConvertTo-Hiragana "じゃパン" 
   じゃぱん
#>
function ConvertTo-Hiragana {
    param([String] $str)

    process {
      Add-Type -AssemblyName Microsoft.VisualBasic
      return [Microsoft.VisualBasic.Strings]::StrConv($str, [Microsoft.VisualBasic.VbStrConv]::Hiragana)
    }
}
Export-ModuleMember -Function ConvertTo-Hiragana

<#
 .Synopsis
  ひらがなをカタカナに変換します。

 .Description
  引数の文字列にあるひらがなをカタカナに変換します。

 .Parameter Str
  変換対象の文字列

 .Example
   # ひらがなをカタカナに変換
   ConvertTo-Katakana "じゃパン" 
   ジャパン
#>
function ConvertTo-Katakana {
    param([String] $str)

    process {
      Add-Type -AssemblyName Microsoft.VisualBasic
      return [Microsoft.VisualBasic.Strings]::StrConv($str, [Microsoft.VisualBasic.VbStrConv]::Katakana)
    }
}
Export-ModuleMember -Function ConvertTo-Katakana

