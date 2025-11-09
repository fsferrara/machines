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
$wingetInstallPackage = $wingetInstall + "Fastfetch-cli.Fastfetch"
Invoke-Expression $wingetInstallPackage


# Append a string to the profile file
Add-Content -Path $PROFILE -Value "`nfastfetch`n"


# Source the profile file to apply changes immediately
. $PROFILE


########
# DONE #
########
Write-Host ">>> Done!"
