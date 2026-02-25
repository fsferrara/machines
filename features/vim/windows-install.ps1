###########
# INSTALL #
###########
Write-Host "`n`n>> Installing...`n";
winget install --exact --source winget --accept-source-agreements --accept-package-agreements --id=vim.vim

winget install --exact --source winget --accept-source-agreements --accept-package-agreements --id=junegunn.fzf
winget install --exact --source winget --accept-source-agreements --accept-package-agreements --id=JFLarvoire.Ag
winget install --exact --source winget --accept-source-agreements --accept-package-agreements --id=BurntSushi.ripgrep.GNU
winget install --exact --source winget --accept-source-agreements --accept-package-agreements --id=dandavison.delta
winget install --exact --source winget --accept-source-agreements --accept-package-agreements --id=sharkdp.bat


##########
# CONFIG #
##########
Write-Host "`n`n>> Configuring...`n";
robocopy config\ $HOME /E /COPY:DAT /V



########
# DONE #
########
Write-Host "`n`n>> Done!`n";
