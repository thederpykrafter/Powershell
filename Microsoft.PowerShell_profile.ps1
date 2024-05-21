# Prompt
# Colors
$BLUE_FG = "`e[34m"
$GREEN_FG = "`e[32m"

function prompt_username {
        Write-Output "┌─$BLUE_FG$($env:USERNAME)`e[0m`e"
}

function prompt_hostname {
        Write-Output "$GREEN_FG$($env:COMPUTERNAME)`e[0m─┐"
}

function prompt_divider {
        $prompt_divider_width = $env:USERNAME.Length + $env:COMPUTERNAME.Length + 3
        Write-Output "$('─' * ($Host.UI.RawUI.WindowSize.Width - $prompt_divider_width))`e"
}

function get_prompt_directory {
        Write-Output "$PWD"
}

function prompt_directory_divider {
        Write-Output "$(' ' * ($Host.UI.RawUI.WindowSize.Width - $(get_prompt_directory).Length - 3)) ┘"
}

function prompt_directory {
        Write-Output "├$($PWD)$(prompt_directory_divider)"
}


function prompt {
        "$(prompt_username) $(prompt_divider) $(prompt_hostname)
$(prompt_directory)
└$('>' * ($nestedPromptLevel + 1)) "
}

# Start oh-my-posh with shell for nerd font support
#oh-my-posh init pwsh --config "$config\Oh-My-Posh\cryptic.omp.json" | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\chips.omp.json" | Invoke-Expression
# amro, chips, di4am0nd, easy-term, emodipt-extend, kali, sim-web

# Remove VS Code Insiders Shortcut from Desktop
# Only nescesarry because installed from winget
if ( Test-Path "C:\Users\Public\Desktop\Visual Studio Code - Insiders.lnk" ) 
{
  Remove-Item "C:\Users\Public\Desktop\Visual Studio Code - Insiders.lnk"
}

# Shortcut directory environment variables
$wsl = "\\wsl.localhost\Ubuntu-24.04\home\thederpykrafter\"
$dev = "D:\"
$notes = "C:\Users\thede\Dropbox\Apps\remotely-save\Notes"
$config = "C:\Users\thede\OneDrive\Documents\Powershell"
$nvim = "C:\Users\thede\AppData\local\nvim"

Set-Alias vi "nvim"
Set-Alias ls "lsd"

# Useful shortcuts for traversing directories
function cd... { Set-Location ..\.. }
function cd.... { Set-Location ..\..\.. }

# Reboot
function reboot
{
  Do { $InputReboot = Read-Host "Do you wish to reboot now? [y/n]" }
  While ( "y","n" -notcontains $InputReboot )
    Switch ( $InputReboot ) 
    {
      "y" { Restart-Computer }
      "n" { Break }
    }
}

# Load shell profile changes
function reload { & $profile }

# Speed up Invoke-WebRequest
$ProgressPreference = "SilentlyContinue"

# Get system up-time
function tdk_uptime
{
  $bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
  $CurrentDate = Get-Date
  $uptime = $CurrentDate - $bootuptime
  # if uptime > 1 day prompt to reboot
  if ($uptime.days -gt 0)
  {
    Write-Output "Device Uptime --> Days: $($uptime.days), Hours: $($uptime.Hours), Minutes:$($uptime.Minutes)"
    Do
    { $InputReboot = Read-Host "Uptime is greater than 1 day, Reboot now? [y/n]" }
    While ("y","n" -notcontains $InputReboot)
    Switch ($InputReboot)
    {
      "y" { Restart-Computer }
      "n" { Break }
    }
  } else
  { Write-Output "Device Uptime --> Days: $($uptime.days), Hours: $($uptime.Hours), Minutes:$($uptime.Minutes)" }
}

# delete empty directories
function remove-empty-dirs {
    Get-ChildItem -Directory -Recurse | Where-Object { $_.GetFiles().Count -eq 0 -and $_.GetDirectories().Count -eq 0 } | Remove-Item -Force
}

#Clear-Host # Remove if error gets hidden
tdk_uptime # Check uptime on launch/reload


#34de4b3d-13a8-4540-b76d-b9e8d3851756 PowerToys CommandNotFound module
Import-Module "C:\Users\thede\AppData\Local\PowerToys\WinUI3Apps\..\WinGetCommandNotFound.psd1"
#34de4b3d-13a8-4540-b76d-b9e8d3851756
