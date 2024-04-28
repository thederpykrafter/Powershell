# Start oh-my-posh with shell for nerd font support
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\aliens.omp.json" | Invoke-Expression

# PowerToys CommandNotFound module
Import-Module "C:\Users\thede\AppData\Local\PowerToys\WinUI3Apps\..\WinGetCommandNotFound.psd1"

# Shortcut directory environment variables
$projects = "E:\Projects"
$web = "E:\Projects\Web"
$tools = "E:\Tools"
$vim = "C:\Users\thede\AppData\Local\nvim"
$vscode = "C:\Users\thede\AppData\Roaming\Code\User"
$firefox = "C:\Users\thede\AppData\Roaming\Mozilla\Firefox\Profiles\6b52w6gg.default-nightly-1713989535522\chrome"
$config = "C:\Users\thede\OneDrive\Documents\PowerShell"

# Program shortcut aliases
Set-Alias lvim 'C:\Users\thede\AppData\Roaming\lunarvim\lvim\utils\bin\lvim.ps1'
Set-Alias vim 'nvim'

# Useful shortcuts for traversing directories
function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }

# Exit shortcut
function close {
    exit
}

# Load shell profile changes
function reload-profile {
        & $profile
}

# Create file linux-like
function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

# Speed up Invoke-WebRequest
$ProgressPreference = "SilentlyContinue"

# Get system up-time
function uptime {
    $bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
    $CurrentDate = Get-Date
    $uptime = $CurrentDate - $bootuptime

    # if uptime > 1 day prompt to reboot
    if ($uptime.days -gt 1)
    {
        Write-Output "Uptime is greater than 1 day, consider rebooting"
        Write-Output "Device Uptime --> Days: $($uptime.days), Hours: $($uptime.Hours), Minutes:$($uptime.Minutes)"

        Do {$InputReboot = Read-Host "Do you wish to reboot now? [y/n]"}
        While ("y","n" -notcontains $InputReboot)

        Switch ($InputReboot) {
        "y" {Restart-Computer}
        "n" {Break}
        }
    }
    else
    {
        Write-Output "Device Uptime --> Days: $($uptime.days), Hours: $($uptime.Hours), Minutes:$($uptime.Minutes)"
    }
}
