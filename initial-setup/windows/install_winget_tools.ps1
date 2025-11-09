##########
# CONFIG #
##########
$wingetInstall = "   winget install --exact --source winget --accept-source-agreements --accept-package-agreements --id="

$developmentPackages = @(
    'OpenJS.NodeJS',
    'Python.Python.3',
    'Docker.DockerDesktop',
    'Mirantis.Lens',
    'Insomnia.Insomnia',
    'Notepad++.Notepad++',
    'SublimeHQ.SublimeText.4',
    'SublimeHQ.SublimeMerge',
    'Microsoft.VisualStudioCode',
    'VSCodium.VSCodium',
    'Fork.Fork',
    'Microsoft.WinDbg'
)

$collaborationPackages = @(
    'HexChat.HexChat',
    'Zoom.Zoom.EXE',
    'SlackTechnologies.Slack',
    'Discord.Discord',
    'OBSProject.OBSStudio'
)

$personalizationPackages = @(
    'Microsoft.PowerToys',
    'Piriform.Speccy'
)

$virtualizationPackages = @(
    'Oracle.VirtualBox # remember to install the Extension Pack manually',
    'Oracle.JavaRuntimeEnvironment'
)

$networkingPackages = @(
    'GlavSoft.TightVNC',
    'PuTTY.PuTTY',
    'Transmission.Transmission',
    'TimKosse.FileZilla.Client # manual download from https://filezilla-project.org/',
    'WiresharkFoundation.Wireshark',
    'PortSwigger.BurpSuite.Community',
    'Insecure.Nmap'
)

$generalPackages = @(
    'Obsidian.Obsidian',
    'Google.Chrome',
    'Mozilla.Firefox'
    'Bitwarden.Bitwarden',
    'Balena.Etcher',
    'RaspberryPiFoundation.RaspberryPiImager',
    'Dropbox.Dropbox',
    'Google.GoogleDrive',
    'TheDocumentFoundation.LibreOffice',
    'GIMP.GIMP.3',
    'Inkscape.Inkscape',
    'VideoLAN.VLC',
    'calibre.calibre',
    'Adobe.Acrobat.Reader.64-bit',
    '7zip.7zip'
)


$cliPackages = @(
    'Git.Git',
    'vim.vim',
    'stedolan.jq',
    'yt-dlp.yt-dlp',
    'Fastfetch-cli.Fastfetch',
    'GNU.MidnightCommander',
    'GNU.Nano',
    'GNU.Emacs',
    'GNU.Wget2',
    'GnuPG.GnuPG',
    'GnuWin32.Bison',
    'GnuWin32.Cpio',
    'GnuWin32.DiffUtils',
    'GnuWin32.File',
    'GnuWin32.FindUtils',
    'GnuWin32.Flex',
    'GnuWin32.GetText',
    'GnuWin32.Gperf',
    'GnuWin32.Grep',
    'GnuWin32.Gzip',
    'GnuWin32.M4',
    'GnuWin32.Make',
    'GnuWin32.Patch',
    'GnuWin32.Tar',
    'GnuWin32.Tree',
    'GnuWin32.UnZip',
    'GnuWin32.Which',
    'GnuWin32.Zip'
)






########
# EXEC #
########
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "winget is not installed. Please install it from https://aka.ms/winget"
    exit 1
}

# Install each package
Write-Host ">>> Development Essentials..."
foreach ($package in $developmentPackages) {
    $wingetInstallPackage = $wingetInstall + $package
    Write-Host $wingetInstallPackage
}

Write-Host ">>> Collaboration..."
foreach ($package in $collaborationPackages) {
    $wingetInstallPackage = $wingetInstall + $package
    Write-Host $wingetInstallPackage
}

Write-Host ">>> Personalization..."
foreach ($package in $personalizationPackages) {
    $wingetInstallPackage = $wingetInstall + $package
    Write-Host $wingetInstallPackage
}

Write-Host ">>> Virtualization..."
foreach ($package in $virtualizationPackages) {
    $wingetInstallPackage = $wingetInstall + $package
    Write-Host $wingetInstallPackage
}

Write-Host ">>> Networking..."
foreach ($package in $networkingPackages) {
    $wingetInstallPackage = $wingetInstall + $package
    Write-Host $wingetInstallPackage
}

Write-Host ">>> General Software..."
foreach ($package in $generalPackages) {
    $wingetInstallPackage = $wingetInstall + $package
    Write-Host $wingetInstallPackage
}

Write-Host ">>> Command Line..."
foreach ($package in $cliPackages) {
    $wingetInstallPackage = $wingetInstall + $package
    Write-Host $wingetInstallPackage
}

########
# DONE #
########
Write-Host ">>> Done! I didn't installed anything :-)\n...it is up to you to copy/paste the commands"
