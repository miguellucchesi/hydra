# Verifica se o script está sendo executado com privilégios de administrador
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Este script precisa ser executado como administrador."
    pause
    exit
}

# Define a chave do registro para desabilitar aplicativos de segundo plano
$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications"
$registryValueName = "GlobalUserDisabled"
$registryValueType = "DWord"
$registryValueData = 1

try {
    # Verifica se a chave do registro já existe antes de criar
    if (-Not (Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
    }

    # Define o valor do registro para desabilitar aplicativos de segundo plano
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $registryValueData -Type $registryValueType -Force

    Write-Host "Aplicativos de segundo plano foram desabilitados com sucesso!"
} catch {
    Write-Host "Ocorreu um erro ao desabilitar aplicativos de segundo plano: $_"
}

pause
