# nerd font support
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\aliens.omp.json" | Invoke-Expression

# Environment Variables
$dev = "E:\"
$projects = "E:\Projects"
$tools = "E:\Tools"
$vim = "C:\Users\thede\AppData\Local\nvim"
$config = "E:\Tools\configs"

# aliases
New-Alias -Name vim -Value nvim
New-Alias -Name vi -Value nvim

# Useful shortcuts for traversing directories
function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }

# useful functions

function close {
    exit
}

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

function reload-profile {
        & $profile
}



# linux-like functions
function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

# Speed up Invoke-WebRequest
$ProgressPreference = "SilentlyContinue"



#PowerToys CommandNotFound module
Import-Module "C:\Users\thede\AppData\Local\PowerToys\WinUI3Apps\..\WinGetCommandNotFound.psd1"
