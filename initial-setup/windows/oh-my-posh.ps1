##########
# CONFIG #
##########
$wingetInstall = "   winget install --exact --source winget --accept-source-agreements --accept-package-agreements --id="


########
# EXEC #
########
if ($env:WT_SESSION -eq $null) {
    Write-Host "(!) Please run this script from Windows Terminal."
    exit 1
}


if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "winget is not installed. Please install it from https://aka.ms/winget"
    exit 1
}

# Install package
$wingetInstallPackage = $wingetInstall + "JanDeDobbeleer.OhMyPosh"
Invoke-Expression $wingetInstallPackage


oh-my-posh font install meslo
Write-Host "(!) Remember to use the font: MesloLGM Nerd Font"


oh-my-posh init powershell --config ~/jandedobbeleer.omp.json | Invoke-Expression


# Create the profile file if it doesn't exist
if (-not (Test-Path $PROFILE)) {
    New-Item -Path $PROFILE -Type File -Force
}


# Append a string to the profile file
Add-Content -Path $PROFILE -Value "`noh-my-posh init powershell | Invoke-Expression`n"


# Source the profile file to apply changes immediately
. $PROFILE


########
# DONE #
########
Write-Host ">>> Done!"
