function RenameWslDistro {
    param (
        [string]$OldDistroName,
        [string]$NewDistroName
    )

    Clear-Host
    Write-Warning "This function performs a rename operation on the Windows Registry."

    $confirm = Read-Host "Do you want to proceed? (y/n)"

    if ($confirm -ne "y") {
        Write-Output "Operation cancelled."
        return
    }

    Clear-Host
    $registryPath = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss"

    try {
        $folders = Get-ChildItem -Path "Registry::$registryPath"
        $renamed = $false

        foreach ($folder in $folders) {
            $obj = Get-ItemProperty -Path $folder.PSPath -Name "DistributionName" -ErrorAction SilentlyContinue

            if ($obj -and $obj.DistributionName -eq $OldDistroName) {
                Write-Host "Found distro '$OldDistroName' (Path: '$folder')" -ForegroundColor Green

                Write-Host "Shutdown WSL ..."
                wsl --shutdown

                Write-Host "Rename distro from '$OldDistroName' to '$NewDistroName' ..."
                Set-ItemProperty -Path $folder.PSPath -Name "DistributionName" -Value $NewDistroName

                Write-Host "Restart WSL Service ..."
                Get-Service WSLService | Restart-Service # LxssManager
                Write-Host "WSL Service restarted .."

                $confirmDistroStart = Read-Host "Do you want to start the distro '$NewDistroName'? (y/n)"

                if ($confirmDistroStart -eq "y") {
                    Write-Host "Start distro '$NewDistroName'"
                    wsl --distribution $NewDistroName
                }

                $renamed = $true
                break
            }
        }

        if (-not $renamed) {
            Write-Warning "No distro with name '$OldDistroName' found in the registry."
        }
    } catch {
        Write-Error "Failed to access registry path: $registryPath"
    }
}