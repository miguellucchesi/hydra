# Executar com permissões de administrador
$ErrorActionPreference = "SilentlyContinue"

# Remove 32-bit Office installations
$office32 = Get-WmiObject -Query "Select * from Win32_Product Where Name like 'Microsoft Office%'" | Where-Object { $_.Vendor -like "Microsoft*" }
foreach ($app in $office32) {
    $app.Uninstall()
}

# Remove 64-bit Office installations
$office64 = Get-WmiObject -Query "Select * from Win32_Product Where Name like 'Microsoft Office%'" | Where-Object { $_.Vendor -like "Microsoft*" }
foreach ($app in $office64) {
    $app.Uninstall()
}

# Remove Office registry entries
$keys = @(
    "HKCU:\Software\Microsoft\Office",
    "HKCU:\Software\Microsoft\Office\16.0",
    "HKCU:\Software\Microsoft\Office\15.0",
    "HKCU:\Software\Microsoft\Office\14.0",
    "HKCU:\Software\Microsoft\Office\13.0",
    "HKCU:\Software\Microsoft\Office\12.0",
    "HKCU:\Software\Microsoft\Office\11.0",
    "HKCU:\Software\Microsoft\Office\10.0",
    "HKCU:\Software\Microsoft\Office\9.0",
    "HKCU:\Software\Microsoft\Office\8.0",
    "HKCU:\Software\Microsoft\Office\7.0",
    "HKLM:\Software\Microsoft\Office",
    "HKLM:\Software\Microsoft\Office\16.0",
    "HKLM:\Software\Microsoft\Office\15.0",
    "HKLM:\Software\Microsoft\Office\14.0",
    "HKLM:\Software\Microsoft\Office\13.0",
    "HKLM:\Software\Microsoft\Office\12.0",
    "HKLM:\Software\Microsoft\Office\11.0",
    "HKLM:\Software\Microsoft\Office\10.0",
    "HKLM:\Software\Microsoft\Office\9.0",
    "HKLM:\Software\Microsoft\Office\8.0",
    "HKLM:\Software\Microsoft\Office\7.0"
)

foreach ($key in $keys) {
    if (Test-Path $key) {
        Remove-Item -Path $key -Recurse -Force
    }
}

# Remove Office directories
$paths = @(
    "C:\Program Files\Microsoft Office",
    "C:\Program Files (x86)\Microsoft Office",
    "C:\Program Files\Common Files\Microsoft Shared",
    "C:\Program Files (x86)\Common Files\Microsoft Shared"
)

foreach ($path in $paths) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force
    }
}

# Remove Office directories from %appdata%
$appdataPaths = @(
    "$env:APPDATA\Microsoft\Office",
    "$env:APPDATA\Microsoft\Templates",
    "$env:APPDATA\Microsoft\Excel",
    "$env:APPDATA\Microsoft\Word",
    "$env:APPDATA\Microsoft\PowerPoint"
)

foreach ($appdataPath in $appdataPaths) {
    if (Test-Path $appdataPath) {
        Remove-Item -Path $appdataPath -Recurse -Force
    }
}

# Cleanup environment variables
[Environment]::SetEnvironmentVariable('Path', ([Environment]::GetEnvironmentVariable('Path') -replace ';C:\\Program Files\\Microsoft Office\\Office\d+', ''))
[Environment]::SetEnvironmentVariable('Path', ([Environment]::GetEnvironmentVariable('Path') -replace ';C:\\Program Files (x86)\\Microsoft Office\\Office\d+', ''))

# Restart the system to complete the uninstallation process
Restart-Computer -Force
