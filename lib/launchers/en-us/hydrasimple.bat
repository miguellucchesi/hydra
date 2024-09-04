@ECHO OFF
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:init
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"

if '%cmdInvoke%'=='1' goto InvokeCmd 

ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
goto ExecElevation

:InvokeCmd
ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

::::::::::::::::::::::::::::
::START
::::::::::::::::::::::::::::

@echo off
:: Verifica se o script está sendo executado como administrador
openfiles >nul 2>&1 || (
    echo Por favor, execute este script como administrador.
    pause
    exit /b
)

:: Obtém o SID do grupo "Todos" (Everyone) usando o comando wmic
for /f "tokens=2 delims==" %%a in ('wmic group where "Name='Everyone'" get sid /value ^| findstr "="') do (
    set SID=%%a

)
:: Concede permissões para todos os usuários na pasta Hydra (forçando a aplicação)
icacls "C:\Program Files\Hydra" /grant "%SID%:(OI)(CI)(RX)" /T /Q

echo Permissoes concedidas para a pasta C:\Program Files\Hydra.

@echo off
:: Verifica se o script esta sendo executado como administrador
openfiles >nul 2>&1 || (
    echo Por favor, execute este script como administrador.
    pause
    exit /b
)

:: Executa o PowerShell para definir a política de execução como Unrestricted
powershell -Command "Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force"

echo Politica de execucao do PowerShell definida para Unrestricted.

@echo off
cls
title  Hydra - Developed by: Miguel Lucchesi Oliveira.

:simplemenuen
color 3
echo. 
echo                             	 Welcome to simple menu!
echo                             Choose one of the options below
echo.
echo    1) Windows/Office Activator               ^| 10) Optimize Windows
echo    2) Remove Office activation SPAM          ^| 11) More performance mode           
echo    3) TEMP Cleaner                           ^| 12) Delete expired certificates A1         
echo    4) Solve Hard Drive problems              ^| 13) Files Backup                     
echo    5) Solve internet problems                ^| 14) File organizer          
echo    6) Solve printer problems                 ^| 15) Sync Clock                    
echo    7) Solve Windows problems                 ^| 16) Fix Java problems             
echo    8) Fix Windows Update                     ^| 17) Search for DEC and REC files          
echo    9) Update all apps and Softwares          ^| 18) Voltar 
echo.
set/p simpleen= Digite sua opcao:

if %simpleen% equ 1 goto 1
if %simpleen% equ 2 goto 2
if %simpleen% equ 3 goto 3
if %simpleen% equ 4 goto 4
if %simpleen% equ 5 goto 5
if %simpleen% equ 6 goto 6
if %simpleen% equ 7 goto 7
if %simpleen% equ 8 goto 8
if %simpleen% equ 9 goto 9
if %simpleen% equ 10 goto 10
if %simpleen% equ 11 goto 11
if %simpleen% equ 12 goto 12
if %simpleen% equ 13 goto 13
if %simpleen% equ 14 goto 14
if %simpleen% equ 15 goto 15
if %simpleen% equ 16 goto 16
if %simpleen% equ 17 goto 17

echo Invalid option. Try again.
pause
cls
goto simplemenuen

:1

@echo off
powershell -command "irm https://get.activated.win | iex"

cls
goto simplemenuen

:2

@echo off
cd \Program Files\Common Files\microsoft shared\ClickToRun\
OfficeC2rclient.exe /update user updatetoversion=16.0.13801.20266

cls
goto simplemenuen

:3

echo Browsers will be finished, are you sure you want to continue?
echo Yes: Press any button
echo No:  Close script
pause
takeown /A /R /D Y /F C:\Users\%USERNAME%\AppData\Local\Temp\
icacls C:\Users\%USERNAME%\AppData\Local\Temp\ /grant administradores:F /T /C
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Temp\
md C:\Users\%USERNAME%\AppData\Local\Temp\
rd /s /q C:\$recycle.bin
takeown /A /R /D Y /F C:\windows\temp
icacls C:\windows\temp /grant administradores:F /T /C
rmdir /q /s c:\windows\temp
md c:\windows\temp
del c:\windows\logs\cbs\*.log
del C:\Windows\Logs\MoSetup\*.log
del C:\Windows\Panther\*.log /s /q
del C:\Windows\inf\*.log /s /q
del C:\Windows\logs\*.log /s /q
del C:\Windows\SoftwareDistribution\*.log /s /q
del C:\Windows\Microsoft.NET\*.log /s /q
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\SettingSync\*.log /s /q
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.tmp /s /q
del C:\Users\%USERNAME%\AppData\Local\Microsoft\"Terminal Server Client"\Cache\*.bin /s /q
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCache\
taskkill /F /IM "msedge.exe"
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\f*.
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\index.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\GrShaderCache\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\ShaderCache\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Storage\ext\
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Cache\f*.
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Cache\index.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Storage\ext\
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Cache\f*.
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Cache\index.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Storage\ext\
taskkill /F /IM "firefox.exe"
REM define qual é a pasta Profile do usuário e apaga os arquivos temporários dali
set parentfolder=C:\Users\%USERNAME%\AppData\Local\Mozilla\Firefox\Profiles\
for /f "tokens=*" %%a in ('"dir /b "%parentfolder%"|findstr ".*\.default-release""') do set folder=%%a
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\entries\*.
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.bin
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.lz*
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\index*.*
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.little
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\*.log /s /q
taskkill /F /IM "vivaldi.exe"
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Cache\f*.
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Cache\index.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\GrShaderCache\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\ShaderCache\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Storage\ext\
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\Cache\f*.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\Storage\ext\
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\Cache\f*.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\Storage\ext\
taskkill /F /IM "brave.exe"
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\f*.
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\index.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\GrShaderCache\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\ShaderCache\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Storage\ext\
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\Cache\f*.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\Storage\ext\
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\Cache\f*.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\Storage\ext\
taskkill /F /IM "chrome.exe"
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache\f*.
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache\index.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\GrShaderCache\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\ShaderCache\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Storage\ext\
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\Cache\f*.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\Storage\ext\
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\Cache\data*.
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\Cache\f*.
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\"Service Worker"\Database\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\"Service Worker"\CacheStorage\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\"Service Worker"\ScriptCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\GPUCache\
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\Storage\ext\
del C:\Windows\SoftwareDistribution\Download\*.* /s /q

cls
goto simplemenuen

:4
@echo off
chkdsk /f /r
echo For the tool start you will need to restart your computer
echo.
echo The disk checking process can be quite time-consuming
echo.
echo I suggest you restart your computer at the best time

pause
cls
goto simplemenuen

:5
@echo off
netsh winsock reset
timeout /t 3 /nobreak > null
netsh int ip reset
timeout /t 3 /nobreak > null
netsh advfirewall reset
timeout /t 3 /nobreak > null
ipconfig /flushdns
timeout /t 3 /nobreak > null
ipconfig /release
timeout /t 3 /nobreak > null
ipconfig /renew
timeout /t 3 /nobreak > null
echo Correction completed. Restart your computer and try again.

cls
goto simplemenuen

:6

@echo off
echo Stopping the printing service
echo.
net stop spooler
echo Deleting jobs in the print queue
echo.
del /Q /F /S %systemroot%\System32\Spool\Printers\*.*
echo Restarting the printing service
echo.
net start spooler
echo Print queue cleaning is complete.
Pause

cls
goto simplemenuen

:7

@echo off
dism /online /cleanup-image /CheckHealth
timeout /t 3 /nobreak > null
dism /online /cleanup-image /restorehealth
timeout /t 3 /nobreak > null
sfc /scannow
echo Script is running repair tools for Windows
echo.
echo During this process your computer may slow down, but don't worry.
echo.
echo If necessary, feel free to continue using the machine.
timeout /t 10 /nobreak > null

cls
goto simplemenuen

:8

@echo off
echo Fixing Windows Update Issues
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old
regsvr32 /s wuaueng.dll
regsvr32 /s wuapi.dll
regsvr32 /s wups.dll
regsvr32 /s wucltux.dll
regsvr32 /s wuwebv.dll
regsvr32 /s jscript.dll
regsvr32 /s atl.dll
regsvr32 /s cryptdlg.dll
regsvr32 /s wups2.dll
regsvr32 /s mshtml.dll
regsvr32 /s shdocvw.dll
regsvr32 /s browseui.dll
regsvr32 /s qmgr.dll
regsvr32 /s muweb.dll
regsvr32 /s wucltux.dll
regsvr32 /s wuwebv.dll
regsvr32 /s wuaueng.dll
regsvr32 /s wuapi.dll
regsvr32 /s wups.dll
regsvr32 /s wucltui.dll
regsvr32 /s wuaueng1.dll
regsvr32 /s wucltui.dll
regsvr32 /s wups.dll
regsvr32 /s wuweb.dll
regsvr32 /s wuapi.dll
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
timeout /t 10 /nobreak > null
echo Correction completed. Please restart your computer and try again.

cls
goto simplemenuen

:9

echo yes | winget update --all

cls
goto simplemenuen

:10

echo Cortana will be disabled, are you sure you want to continue?
echo Yes: Press any button
echo No: Close script
pause
sc config AdobeLMService start=disabled
sc config FastUserSwitchingCompatibility start=disabled
sc config FTPPublishing start=disabled
sc config helpsvc start=disabled
sc config nvsvc start=disabled
sc config WMC_SchedulerSvc start=disabled
sc config SCardSvr start=disabled
sc config WPCSvc start=disabled
sc config TabletInputService start=disabled
sc config seclogon start=disabled
sc config Fax start=disabled
sc config wscsvc start=disabled
sc config WerSvc start=disabled
sc config DPS start=disabled
sc config dmwappushservice start=disabled
sc config MapsBroker start=disabled
sc config SysMain start=disabled
echo Servicos desnecessarios desabilitados
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges. Run the command prompt as administrator and try again.
    pause
    exit /b
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
echo Cortana disabled
powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Hydra\lib\scripts\ps1\disablebackgroundapps.ps1"
echo Background apps disabled
powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Hydra\lib\scripts\ps1\removebloatwares.ps1"
echo Bloatwares removed
timeout /t 5 /nobreak > null

cls
goto simplemenuen

:11

@echo off
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Hydra\lib\scripts\ps1\systemperformance.ps1"
echo Windows has been set to maximum performance mode.
timeout /t 5 /nobreak > null

cls
goto simplemenuen

:12
powershell -Command "Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object { $_.NotAfter -lt (Get-Date) } | ForEach-Object { Remove-Item -Path $_.PSPath }"
cls
echo.
echo Successfully deleted expired certificates.
echo.
timeout /t 4 >nul

goto simplemenuen
cls

:13

@echo off
xcopy "C:\Users\%username%\Desktop" "C:\Users\%username%\Area de trabalho" /E /I /Y
mkdir "C:\Users\%username%\Desktop\Backup"
xcopy "C:\Users\%username%\Downloads" "C:\Users\%username%\Desktop\Backup\Downloads" /E /I /Y
xcopy "C:\Users\%username%\Documents" "C:\Users\%username%\Desktop\Backup\Documentos" /E /I /Y
xcopy "C:\Users\%username%\Pictures" "C:\Users\%username%\Desktop\Backup\Imagens" /E /I /Y
move "C:\Users\%username%\Area de trabalho" "C:\Users\%username%\Desktop\Backup"
"C:\Program Files\WinRAR\WinRAR.exe" a -ep1 "C:\Users\%username%\Desktop\Backup.rar" "C:\Users\%username%\Desktop\Backup"
rmdir /s /q "C:\Users\%username%\Desktop\Backup"

cls
goto simplemenuen

:14

@echo off
cd "C:\Program Files\Hydra\lib\scripts\python"
python organizer.py
echo.
echo Os itens foram organizados com sucesso, de uma olhada nas pastas selecionadas!
pause
cls
goto simplemenuen

:15
@echo off

cd "C:\Program Files\Hydra\lib\scripts\python"
python clock.py
pause
cls
goto simplemenuen

:16

@echo off
setlocal enabledelayedexpansion

REM Definir o caminho do arquivo de destino
set "destino=%SYSTEMDRIVE%\Users\%USERNAME%\AppData\LocalLow\Sun\Java\Deployment\security\exception.sites"

REM Verificar se o arquivo de destino existe, caso contrário, criar o diretório
if not exist "%destino%" (
    echo O arquivo %destino% não existe. Criando o diretório e o arquivo...
    mkdir "%SYSTEMDRIVE%\Users\%USERNAME%\AppData\LocalLow\Sun\Java\Deployment\security"
    type nul > "%destino%"
) else (
    echo O arquivo %destino% já existe.
)

REM Lista de URLs a serem adicionados
set temp_urls_file=%TEMP%urls.txt
(
    echo http://www.receita.fazenda.gov.br/
    echo https://conectividade.caixa.gov.br/
    echo https://www14.receita.fazenda.gov.br/
    echo http://conectividade.caixa.gov.br/
    echo https://banklineplus.itau.com.br/
    echo http://cmt.caixa.gov.br/cse/
    echo https://cmt.caixa.gov.br/cse/
    echo http://www.emissornfe.fazenda.sp.gov.br/
    echo https://www.emissornfe.fazenda.sp.gov.br/
    echo http://cmt.caixa.gov.br/
    echo https://aapj.bb.com.br/
    echo https://www.jucesp.sp.gov.br/
    echo https://www.jucesponline.sp.gov.br/
    echo https://www.fazenda.sp.gov.br/
    echo https://www.identify.fazenda.sp.gov.br/
    echo http://www.transmissornfp.fazenda.sp.gov.br/
    echo https://cav.receita.fazenda.gov.br/
    echo https://www.receita.fazenda.gov.br/
    echo https://www3.cav.receita.fazenda.gov.br/
    echo http://caged.maisemprego.mte.gov.br/
    echo http://mte.caixa.gov.br/
    echo https://caged.maisemprego.mte.gov.br/
    echo http://conectividade.caixa.gov.br:80/static/sicnsregistro/applet/assinar1.jar
    echo http://conectividade.caixa.gov.br:80/static/procuracao/applet/assinar.jar
    echo http://conectividade.caixa.gov.br:80/static/cxpostal/applet/msgenvio.jar
    echo http://conectividade.caixa.gov.br:80/static/cxpostal/applet/cnsenvio.jar
    echo http://www.emissornfe.fazenda.sp.gov.br/
    echo http://mte.caixa.gov.br/
    echo http://www.emissornfe.fazenda.sp.gov.br/
    echo http://www.transmissornfp.fazenda.sp.gov.br/
    echo https://caged.maisemprego.mte.gov.br/
    echo https://cav.receita.fazenda.gov.br
    echo https://www.receita.fazenda.gov.br/
    echo https://www14.receita.fazenda.gov.br/https://www3.cav.receita.fazenda.gov.br/
    echo https://www3.cav.receita.fazenda.gov.br/
    echo http://caged.maisemprego.mte.gov.br/
) > %temp_urls_file%

REM Adicionar URLs ao arquivo de destino se não existirem
for /f "usebackq delims=" %%i in ("%temp_urls_file%") do (
    echo Verificando %%i...
    findstr /c:"%%i" "%destino%" >nul
    if errorlevel 1 (
        echo %%i não encontrado. Adicionando ao arquivo...
        echo %%i >> "%destino%"
    ) else (
        echo %%i já está presente no arquivo.
    )
)

REM Limpar o arquivo temporário
del %temp_urls_file%

echo URLs adicionados ao arquivo %destino%.
pause
cls

goto simplemenuen

:17
echo Este Script pode demorar alguns instantes considerando o desempenho do seu computador.
echo Realizando varredura.
@echo off
setlocal enabledelayedexpansion

set "search_dir=C:\"
set "backup_folder=%systemdrive%\Users\%username%\Desktop\BACKUP ARQUIVOS IRPF"

if not exist "%backup_folder%" (
    mkdir "%backup_folder%"
)

set "rec_folder=%backup_folder%\REC"
set "dec_folder=%backup_folder%\DEC"

if not exist "%rec_folder%" (
    mkdir "%rec_folder%"
)

if not exist "%dec_folder%" (
    mkdir "%dec_folder%"
)

for /r "%search_dir%" %%F in (*.dec, *.rec) do (
    if /i "%%~xF"==".rec" (
        copy "%%F" "%rec_folder%"
    ) else if /i "%%~xF"==".dec" (
        copy "%%F" "%dec_folder%"
    )
)

echo.
echo Varredura concluida! Os arquivos DEC e REC estão localizados na sua area de trabalho dentro da pasta "BACKUP ARQUIVOS IRPF"
echo.
echo Caso as pastas estejam vazias significa que nao haviam arquivos DEC e REC pois o script faz a varredura em todo o computador.
pause
cls

goto simplemenuen