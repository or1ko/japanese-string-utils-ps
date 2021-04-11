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

      $tani2ara = @{
        "十" = 10;
        "百" = 100;
        "千" = 1000;
        "万" = 10000;
        "億" = [Math]::Pow(10, 8);
        "兆" = [Math]::Pow(10, 12);
        "京" = [Math]::Pow(10, 16);
        "垓" = [Math]::Pow(10, 20);
        "𥝱" = [Math]::Pow(10, 24);
        "穣" = [Math]::Pow(10, 28);
        "溝" = [Math]::Pow(10, 32);
        "澗" = [Math]::Pow(10, 36);
        "正" = [Math]::Pow(10, 40);
        "載" = [Math]::Pow(10, 44);
        "極"  = [Math]::Pow(10, 48);
        "恒河沙" = [Math]::Pow(10, 52);
        "阿僧祇" = [Math]::Pow(10, 56);
        "那由他" = [Math]::Pow(10, 60);
        "不可思議" = [Math]::Pow(10, 64);
        "無量大数" = [Math]::Pow(10, 68);
      }

      $result = ""
      $isNum = $false

      $i = 0
      $beforeNum = $null

      $numResult = 0
      while($i -lt $str.Length) {
        $sub = $str.Substring($i);

        $kan2 = $kan2ara.Keys | Where-Object { $sub.StartsWith($_) }
        if ($kan2.Count) {
          $isNum = $true

          $beforeNum = $kan2ara[$kan2 + ""]
          $i = $i + 1
          continue
        }

        $matchedTani = $tani2ara.Keys | Where-Object { $sub.StartsWith($_) }
        if ($matchedTani.Count) {
          $isNum = $true

          if ($null -eq $beforeNum) {
            $baseNum = 1
          } else {
            $baseNum = $beforeNum
          }
          
          $tani = $tani2ara[$matchedTani + ""]

          if ($tani -gt $numResult) {
            if ($null -eq $beforeNum) {
              if ($numResult -eq 0) {
                $numResult = 1 * $tani
              } else {
                $numResult = $numResult * $tani
              }
            } else {
              $numResult = ($numResult + $baseNum) * $tani
            }
          } else {
            $numResult = $numResult + $baseNum * $tani
          }

          $beforeNum = $null;
          $i = $i + $matchedTani.Length
          continue
        }

        if ($isNum) {
          $isNum = $false

          if ($null -ne $beforeNum) {
            $numResult = $numResult + $beforeNum 
            $beforeNum = $null
          }

          $result = $result + $numResult
          $numResult = 0
        }

        $result = $result + $sub[0]
        $i = $i + 1
      }


      if ($isNum) {

        if ($null -ne $beforeNum) {
          $numResult = $numResult + $beforeNum 
          $beforeNum = $null
        }

        $result = $result + $numResult
        $numResult = 0
      }

      $result

    }
}
Export-ModuleMember -Function ConvertFrom-Kansuuji
