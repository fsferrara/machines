##########
# CONFIG #
##########
Write-Host "`n`n>> Checking for updates...`n";
winget list --upgrade-available --include-unknown

Write-Host "`n`n>> To upgrade a single package, run:`n";
Write-Host "   winget upgrade --id <Package.Id>`n";


########
# DONE #
########
Write-Host "`n`n>> Done!`n";
