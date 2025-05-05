# Prompt
# Colors
$BLUE_FG = "`e[34m"
$GREEN_FG = "`e[32m"

function prompt_username {
        Write-Output "┌─$BLUE_FG$($env:USERNAME)`e[0m`e"
}

function prompt_hostname {
        Write-Output "$GREEN_FG$($env:COMPUTERNAME)`e[0m─"
}

function prompt_divider {
        $prompt_divider_width = $env:USERNAME.Length + $env:COMPUTERNAME.Length + 2
        Write-Output "$('─' * ($Host.UI.RawUI.WindowSize.Width - $prompt_divider_width))`e"
}

function prompt_directory {
        Write-Output "├$($PWD)"
}


function prompt {
        "$(prompt_username) $(prompt_divider) $(prompt_hostname)
$(prompt_directory)
└$('>' * ($nestedPromptLevel + 1)) "
}

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


#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

if ((Get-Item -Path "HKLM:\System\CurrentControlSet\Control\TimeZoneInformation").GetValue("RealTimeIsUniversal") -ne 0) {
    Write-Output "Fixing Real Time.."

    $startprocessParams = @{
        FilePath     = "$Env:SystemRoot\REGEDIT.exe"
        ArgumentList = '/s', 'C:\Users\thede\OneDrive\Documents\PowerShell\TimeFix.reg'
        Verb         = 'RunAs'
        PassThru     = $true
        Wait         = $true
    }
    $proc = Start-Process @startprocessParams

    if ($proc.ExitCode -eq 0) {
        'Success!'
    }
    else {
        "Fail! Exit code: $($Proc.ExitCode)"
    }
    
    Write-Output "Done!"
}