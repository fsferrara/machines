# Set up Windows Subsystem for Linux (WSL) with FedoraLinux-42

# Enable WSL feature
Write-Host "Enabling WSL feature..."
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# Enable Virtual Machine Platform
Write-Host "Enabling Virtual Machine Platform..."
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart

Write-Host "WSL setup complete. Please restart your computer to apply changes."
