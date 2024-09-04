# Define a lista de aplicativos a serem removidos
$bloatwareApps = @(
    "Microsoft.3DBuilder",
    "Microsoft.Messaging",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.Office.OneNote",
    "Microsoft.OneConnect",
    "Microsoft.People",
    "Microsoft.Print3D",
    "Microsoft.SkypeApp",
    "Microsoft.StorePurchaseApp",
    "Microsoft.Windows.Photos",
    "Microsoft.WindowsAlarms",
    "Microsoft.WindowsCamera",
    "microsoft.windowscommunicationsapps",
    "Microsoft.WindowsFeedbackHub",
    "Microsoft.WindowsMaps",
    "Microsoft.WindowsSoundRecorder",
    "Microsoft.Xbox.TCUI",
    "Microsoft.XboxApp",
    "Microsoft.XboxGameOverlay",
    "Microsoft.XboxGamingOverlay",
    "Microsoft.XboxIdentityProvider",
    "Microsoft.XboxSpeechToTextOverlay",
    "Microsoft.YourPhone",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "Microsoft.GetHelp",
    "Microsoft.WindowsSoundRecorder"
)

# Remove os aplicativos da lista
foreach ($app in $bloatwareApps) {
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage
    Get-AppXProvisionedPackage -Online | Where DisplayName -EQ $app | Remove-AppxProvisionedPackage -Online
}

Write-Host "Todos os bloatwares foram removidos com sucesso." -ForegroundColor Green
