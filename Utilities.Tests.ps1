$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Get-TestFilePairIsSame" {
    It "returns $true if files are the same" {
        $newFile1 = New-Item -Path TestDrive:/"x1.txt"
        $newFile2 = New-Item -Path TestDrive:/"x2.txt"
        Set-Content -Path $newFile1 -Value "This stuff"
        Set-Content -Path $newFile2 -Value "This stuff"

        Test-FilePairIsSame $newFile1 $newFile2 | Should Be $true

        Remove-Item -Path TestDrive:/"x1.txt"
        Remove-Item -Path TestDrive:/"x2.txt"
        
    }

    It "returns $false if files are different" {
        $newFile1 = New-Item -Path TestDrive:/"x1.txt"
        $newFile2 = New-Item -Path TestDrive:/"x2.txt"
        Set-Content -Path $newFile1 -Value "This stuff"
        Set-Content -Path $newFile2 -Value "This stuff and more"

        Test-FilePairIsSame $newFile1 $newFile2 | Should Be $false

        Remove-Item -Path TestDrive:/"x1.txt"
        Remove-Item -Path TestDrive:/"x2.txt"

    }

}