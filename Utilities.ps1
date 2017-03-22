<#
private 
Test the content of 2 files.
Return true if the content is the same, else return false.
#>
function Test-FilePairIsSame {
    Param (
        [Parameter(Mandatory = $true)] $file1,
        [Parameter(Mandatory = $true)] $file2
    )
    $content1 = Get-Content -Path $file1
    $content2 = Get-Content -Path $file2
    if (Compare-Object $content1 $content2) {
        return $false
    }
    return $true
}

Set-StrictMode -Version Latest
<#
.Synopsis
    Return the filenames in the passed zip file. Default is custom case.
.Example
    Get-NamesInZipFile 'c:\temp\ordinaryzip.zip' "c:\temp\StickItHere.txt" $false
    Get-NamesInZipFile 'c:\temp\specialzip.zip' "c:\temp\StickItHere.txt" -isSpecialVersion $true
    Get-NamesInZipFile 'c:\temp\specialzip.zip' "c:\temp\StickItHere.txt" 
#>

function Get-ZipFileNames {
    Param (
        [Parameter(mandatory = $true)] $zipFileLocation,
        [Parameter(mandatory = $true)] $outputFile,
        [Parameter(mandatory = $false)] $isSpecialVersion = $true
    )

    if (-not(Test-Path $zipFileLocation)) {
        Write-Host "File [$zipFileLocation] not found. Exiting..." -BackgroundColor Yellow -ForegroundColor Red
        throw "dont what"
    }

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $entries = [System.IO.Compression.FileSystem]::OpenRead($zipFileLocation).Entries
    Write-Host "Content of [$zipFileLocation]..." -BackgroundColor Yellow -ForegroundColor Black

    if ($isSpecialVersion) {
        "The Special Version zip contains the following files:" | Out-File $outputFile
    }

    $entries | % {
        $currentRecord = $_
        if ($isSpecialVersion) {
            # if the current record ends in a '/', i.e. there is no file just a directory...
            if ($currentRecord -match "/$") {return}
            # custom processing due to known facts about this special version
            $currentRecord = "- " + $currentRecord -replace "Special Version/", ""
            $currentRecord = $currentRecord -replace "/", "\"
        }
        $currentRecord
    } | Out-File $outputFile -Append

    Get-Content $outputFile
    Write-Host "File list is available in [$outputFile]" -BackgroundColor Yellow -ForegroundColor Black
}
