#Requires -RunAsAdministrator

# Set-ExecutionPolicy Unrestricted

# Function to install packages via Chocolatey
function Install-Packages {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Packages
    )

    # Check if Chocolatey is installed and install it if not
    if (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

    # Install each package
    $i = 0
    $total = $Packages.Count
    foreach ($package in $Packages) {
        $i++
        $percent = ($i / $total) * 100
        $status = "Installing $package ($i/$total)"
        Write-Progress -Activity $status -PercentComplete $percent

        choco install $package -y | Out-File -FilePath "$env:USERPROFILE\choco_installation.log" -Append
    }
}

# List of packages to install
$packages = @(
    'obsidian',
    'chocolateygui',
    'attributechanger',
    'bulk-crap-uninstaller',
    'gitkraken',
    'python',
    'thunderbird',
    'neovim',
    'syncthing'
    'clink',
    'doublecmd'
    'nushell',
    'vulkan-sdk'
    'starship',
    'rapidee',
    'qbittorrent',
    '7zip.install',
    'nodejs',
    'cmake',
    'simplewall.install',
    'firefox',
    'vlc',
    'nilesoft-shell',
    'steam-client',
    'spotify',
    'vscodium',
    'gpg4win',
    'jetbrainstoolbox',
    'discord',
    'microsoft-windows-terminal',
    'openjdk',
    'everything',
    'geogebra',
    'winmerge',
    'git',
    'hashtab',
    'imhex',
    'jdk8',
    'llvm',
    'memreduct',
    'sysinternals',
    'powertoys',
    'msys2',
    'dotnet --version=8.0.0',
    'nmap',
    'wireshark',
    'obs-studio',
    'nvidia-display-driver',
    'winaero-tweaker',
    'processhacker',
    'psiphon',
    'protonvpn'
    'telegram',
    'teracopy',
    'wiztree',
    'x64dbg.portable',
    'mpv',
    'ghidra',
    'dotnet',
    'office-tool',
    'okular',
    'windows-sdk-10-version-2004-windbg',
    'cheatengine',
    'pvs-studio',
    'cpu-z',
    'autohotkey',
    'sharex',
    'fiddler',
    'notepadplusplus',
    'belarcadvisor',
    'virtualbox',
	'cygwin',
    'visualstudio2022enterprise'
)

# Install the packages
Install-Packages -Packages $packages

# Upgrade all packages
choco upgrade all -y | Out-File -FilePath "$env:USERPROFILE\windows_automated_apps_setup.log" -Append

# Adding UNIX-like cmd utils (e.g. `ls`, `pwd` and etc.)
$folderPath += ";C:\tools\cygwin\bin"

# Get the current PATH variable
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Append the new folder to the PATH
$newPath = $currentPath + ";" + $folderPath

# Set the new PATH variable
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

Pause