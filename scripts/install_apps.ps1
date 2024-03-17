#Requires -RunAsAdministrator

Set-ExecutionPolicy Unrestricted

function Enable-WindowsSandbox-And-WSL {
    # Check if virtualization is enabled
    $vmProcessor = Get-WmiObject -Class Win32_Processor | Select-Object -First 1
    if ($vmProcessor.SecondLevelAddressTranslationExtensions -notcontains "True") {
        Write-Warning "Virtualization is not enabled. Please enable virtualization in the BIOS and try again."
        return
    }

    # Enable Windows Sandbox
    Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online -NoRestart

    # Check if WSL is installed and install it if not
    if (!(Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -eq 'Enabled') {
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
    }
}

Enable-WindowsSandbox-And-WSL


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
    'neovim',
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
    'simplewall.install'
    'firefox'
    'vlc',
    'nilesoft-shell',
    'steam-client',
    'vscodium',
    'jetbrainstoolbox',
    'discord',
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
    'dotnet --version=8.0.0'
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
$env:Path += ";C:\tools\cygwin\bin"


$Links = @(
    "https://rsload.net/soft/manager/8313-aida64-extreme-edition1.html",
    "https://rsload.net/soft/manager/23708-ablebits-ultimate-suite-for-excel.html",
    "https://canarymail.io/downloads.html",
    "https://rsload.net/soft/editor/39797-efficient-elements-for-presentations.html",
    "https://rsload.net/repack/kpojiuk/23497-internet-download-manager-repack-kpojiuk.html",
    "https://rsload.net/repack/kpojiuk/23678-adobe-acrobat-repack-kpojiuk.html",
    "https://rsload.net/soft/editor/33771-pvs-studio.html",
    "https://rsload.net/soft/cleaner-disk/11198-ultimatedefrag.html",
    "https://rsload.net/soft/cleaner-disk/12953-partition-assistant.html",
    "https://rsload.net/soft/manager/9407-process-lasso.html",
    "https://rutracker.org/forum/viewtopic.php?t=6183097",
    "https://rutracker.org/forum/viewtopic.php?t=6178172",
    "https://rutracker.org/forum/viewtopic.php?t=6220259",
    "https://rutracker.org/forum/viewtopic.php?t=6454193",
    "https://clonezilla.org/downloads.php",
    "https://key.words.run/en?aid=649af973004a2e5c3821a894",
    "https://browser.yandex.by/"
)

foreach ($Link in $Links) {
    Start-Process $Link
}

if (!(Get-AppxPackage -Name Microsoft.WindowsStore)) {
    "https://github.com/m-jishnu/alt-app-installer"
}

Set-ExecutionPolicy Restricted

Pause