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