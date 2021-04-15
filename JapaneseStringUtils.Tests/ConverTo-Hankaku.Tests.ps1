Describe 'ConvertTo-Hankaku' {
    It 'Given no parameters, it lists all 8 planets' {
        ConvertTo-Hankaku "ａ" | Should
    }
}