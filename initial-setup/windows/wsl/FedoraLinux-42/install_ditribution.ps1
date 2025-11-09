# Set up Windows Subsystem for Linux (WSL) with FedoraLinux-42

# Enable WSL feature
Write-Host "Enabling WSL feature..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# Enable Virtual Machine Platform
Write-Host "Enabling Virtual Machine Platform..."
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

# Install FedoraLinux-42 from the Microsoft Store
Write-Host "Installing FedoraLinux-42..."
winget install --id FedoraProject.FedoraLinux_42 -e --accept-source-agreements --accept-package-agreements

# Set FedoraLinux-42 as the default WSL distro
Write-Host "Setting FedoraLinux-42 as the default WSL distro..."
wsl --set-default FedoraLinux-42

Write-Host "WSL setup complete. Please restart your computer to apply changes."
