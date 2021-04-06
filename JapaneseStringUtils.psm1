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