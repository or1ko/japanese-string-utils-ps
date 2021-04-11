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
   ConvertFrom-Kansuuji "１億５千万および百三十一"
   150000000および131
#>
function ConvertFrom-Kansuuji {
    param([String] $str)

    process {

      $str = ConvertTo-Hankaku $str

      $kan2ara = @{
        "零" = 0;
        "〇" = 0;

        "一" = 1;
        "二" = 2;
        "三" = 3;
        "四" = 4;
        "五" = 5;
        "六" = 6;
        "七" = 7;
        "八" = 8;
        "九" = 9;

        "壱" = 1;
        "弐" = 2;
        "参" = 3;

        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
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

        "拾" = 10;
      }

      $converted = ""

      $strIndex = 0
      $isNum = $false # $str[$i]が漢数字中かいなかを示す変数

      # 一つ前の数を保持する変数。
      # 例えば、「二十」の場合に、十を処理している時は2(二)が格納
      $beforeNum = $null

      $num = 0
      while($strIndex -lt $str.Length) {
        $sub = $str.Substring($strIndex);

        # 一～九の数字か調べ、$beforeNumに変換後の値を格納し、次の文字を処理する
        $kan2 = $kan2ara.Keys | Where-Object { $sub.StartsWith($_) }
        if ($kan2.Count) {
          $isNum = $true

          if ($null -ne $beforeNum) {
            $converted = $converted + $beforeNum
          }

          $beforeNum = $kan2ara[$kan2 + ""]
          $strIndex = $strIndex + 1
          continue
        } 

        # 十,千,万などか調べ、一つ前に数字があれば、その値と掛けた値を$numに加算
        # 例えば「二十」の場合、二(2) * 10で$numに20を加算。
        # 加算するのは、例えば「二十」の前に「百」があり「百二十」となっている場合への対応
        $matchedTani = $tani2ara.Keys | Where-Object { $sub.StartsWith($_) }
        if ($matchedTani.Count) {
          $isNum = $true

          if ($null -eq $beforeNum) {
            $baseNum = 1
          } else {
            $baseNum = $beforeNum
          }
          
          $tani = $tani2ara[$matchedTani + ""]
          $mod = $num % $tani
          if ($null -eq $beforeNum) {
            if ($mod -eq 0) {
              $num = $num + (1 * $tani)
            } else {
              $num = ($num - $mod) + ($mod * $tani)
            }
          } else {
            $num = ($num - $mod) + (($mod + $baseNum) * $tani)
          }

          $beforeNum = $null;
          $strIndex = $strIndex + $matchedTani.Length
          continue
        }

        if ($isNum) {
          $isNum = $false
          if ($null -ne $beforeNum) {
            $num = $num + $beforeNum 
            $beforeNum = $null
          }
          $converted = $converted + $num
          $num = 0
        }

        $converted = $converted + $sub[0]
        $strIndex = $strIndex + 1
      }

      if ($isNum) {
        if ($null -ne $beforeNum) {
          $num = $num + $beforeNum 
          $beforeNum = $null
        }
        $converted = $converted + $num
        $num = 0
      }

      $converted
    }
}
Export-ModuleMember -Function ConvertFrom-Kansuuji