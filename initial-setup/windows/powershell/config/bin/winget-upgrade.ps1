##########
# CONFIG #
##########
Write-Host "`n`n>> Applying updates...`n";
winget upgrade --all --silent --accept-source-agreements


########
# DONE #
########
Write-Host "`n`n>> Done!`n";
