<#
 .Synopsis
  全角文字を半角文字に変換します。

 .Description
  引数の文字列にある全角文字を半角文字に変換します。

 .Parameter Str
  変換対象の文字列

 .Example
   # 全角文字を半角文字に変換 
   ConvertTo-Hankaku "aｂc１23アｲう．." 
   abc123ｱｲう..
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
   ConvertTo-Zenkaku "aｂc１23アｲう．." 
   ａｂｃ１２３アイう．．
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

<#
 .Synopsis
  漢数字を数値に変換します

 .Description
  引数の文字列の漢数字を数値に変換します

 .Parameter Str
  変換対象の文字列

 .Example
   # ひらがなをカタカナに変換
   ConvertFrom-Kansuuji "一"
   1
#>
function ConvertFrom-Kansuuji {
    param([String] $str)

    process {

      $kan2ara = @{
        "一" = 1;
        "二" = 2;
        "三" = 3;
        "四" = 4;
        "五" = 5;
        "六" = 6;
        "七" = 7;
        "八" = 8;
        "九" = 9;
      }


      $cs = $str.ToCharArray() | 
      ForEach-Object {
        if ($kan2ara.ContainsKey("$_")) {
          $kan2ara["$_"]
        } else {
          $_
        }
      }

      $cs -join ""
    }
}
Export-ModuleMember -Function ConvertFrom-Kansuuji
