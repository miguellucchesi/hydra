# Define o valor para a opção "Ajustar para obter melhor desempenho"
$PerformanceOption = 2

# Define a chave do registro para alterar as configurações de desempenho
$RegistryKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"

# Define o valor a ser alterado na chave do registro
Set-ItemProperty -Path $RegistryKey -Name VisualFXSetting -Value $PerformanceOption

# Reinicia o Explorer para que as alterações tenham efeito
Stop-Process -name explorer
