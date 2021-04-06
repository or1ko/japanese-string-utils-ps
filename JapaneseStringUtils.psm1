<#
 .Synopsis
  全角文字を半角文字に変換します。

 .Description
  引数の文字列にある全角文字を半角文字に変換します。

 .Parameter Str
  変換対象の文字列

 .Example
   # 全角文字を半角文字に変換 
   ConvertTo-Ascii "aｂc１23" 
   abc123
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
   ConvertTo-Zenkaku "aｂc１23" 
   ａｂｃ１２３
#>
function ConvertTo-Zenkaku {
    param([String] $str)

    process {
      Add-Type -AssemblyName Microsoft.VisualBasic
      return [Microsoft.VisualBasic.Strings]::StrConv($str, [Microsoft.VisualBasic.VbStrConv]::Wide)
    }
}
Export-ModuleMember -Function ConvertTo-Zenkaku