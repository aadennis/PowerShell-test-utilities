<#
private 
Test the content of 2 files.
Return true if the content is the same, else return false.
#>
function Test-FilePairIsSame ($file1, $file2) {
    $content1 = Get-Content -Path $file1
    $content2 = Get-Content -Path $file2
    if (Compare-Object $content1 $content2) {
        return $false
    }
    return $true
}