# TestUtilities

# New-PesterFixture.ps1
New-PesterFixture.ps1

Just to save a few keystrokes in getting get the test/SUT folder structure the way I like it, this wraps New-Fixture to move the test and SUT ps1 files into their own folders, side-by-side. The reference to the SUT in the test ps1 therefore changes as well.

It still uses the failing dummy test for $true -eq $false, and does not (right now) reference the SUT from the dummy test.

