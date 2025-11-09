# Rename WSL Distro

for the script you need source it first (notice . in front)

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass
. .\RenameWslDistro.ps1
...

and then we can call the function inside

```shell
RenameWslDistro -OldDistroName "FedoraLinux-42" -NewDistroName "FedoraLinux-43"
```
