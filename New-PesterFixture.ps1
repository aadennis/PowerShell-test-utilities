function Get-TestTemplate {
return @" 
`$here = Split-Path -Parent `$MyInvocation.MyCommand.Path
`$sut = (Split-Path -Leaf `$MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "`$here\..\$productionDir\`$sut"

Describe "$applicationName" {
    It "does something useful" {
        `$true | Should Be `$false
    }
}
"@
}

<#
.Synopsis
  Create a production/test structure using New-Fixture to kick things off, including a dummy test   
.Description
  By default, beneath the current folder, the function creates a Production folder and a sibling Tests folder.
  The default name of the created application is Calculator.
  By default, New-Fixture (outside the control of this function) creates a single function inside (the default) Calculator.ps1,
  with the same name as the SUT file, i.e. "Calculator".
  The test inside the generated Calculator.tests.ps1 tests the result of $true -eq $false and therefore a) fails, b) is not bound
  at first to the SUT.
.Example
   New-PesterFixture
#>
function New-PesterFixture (

    $productionDir = "./Production",
    $testDir = "./Tests",
    $applicationName = "Calculator"
    ) {
   
    New-Fixture -Path $testDir -Name $applicationName
    Get-TestTemplate > "$testDir/$applicationName.tests.ps1"
    New-Item -Path "$productionDir" -Type Directory
    Move-Item -Path "$testDir/$applicationName.ps1" -Destination "$productionDir/$applicationName.ps1"
}

cd /temp/SomeRepoRoot
New-PesterFixture
Invoke-Pester

<#
   rm -r *.ps1                                                                                                                                                         
   rm -r .\Production                                                                                                                                                  
   rm -r .\Tests 
#>
