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
color 3
title  Hydra - Desenvolvido por: Miguel Lucchesi Oliveira.

:menuavancadobr
echo. 
echo                             Hydra - Compativel com Windows 10-11  MENU AVANCADO
echo.
echo   1) Ativador Windows/Office                      ^| 16) Corrigir problemas do Java
echo   2) Remover mensagem de ativacao do Office       ^| 17) Buscar arquivos de IRPF
echo   3) Limpeza de temporarios                       ^| 18) Speed Test
echo   4) Resolver problemas com HD                    ^| 19) Relatorio de Bateria
echo   5) Resolver problemas com internet              ^| 20) Relatorio WLAN
echo   6) Resolver problemas com impressoras           ^| 21) Firewall Off/On fazer menu
echo   7) Resolver problemas com Windows               ^| 22) resetar adaptadores wifi (excluir perfis de rede)
echo   8) Corrigir atualizacao do Windows              ^| 23) desfragmentação otimizada
echo   9) Atualizar todos os programas                 ^| 24) desativar UAC
echo   10) Otimizar o Windows                          ^| 25) systeminfo
echo   11) Modo mais desempenho                        ^| 26) ip publico, provedor e mac
echo   12) Excluir certificados vencidos               ^| 27) excluir arquivos por extensao/caminho
echo   13) Backup de arquivos                          ^| 28) Remover office completamente
echo   14) Organizar Area de trabalho e Downloads      ^| 
echo   15) Sincronizar Relogio                         ^| 
echo.                                                                                           
set/p avancadobr= Digite sua opcao:

if %avancadobr% equ 1 goto 1
if %avancadobr% equ 2 goto 2
if %avancadobr% equ 3 goto 3
if %avancadobr% equ 4 goto 4
if %avancadobr% equ 5 goto 5
if %avancadobr% equ 6 goto 6
if %avancadobr% equ 7 goto 7
if %avancadobr% equ 8 goto 8
if %avancadobr% equ 9 goto 9
if %avancadobr% equ 10 goto 10
if %avancadobr% equ 11 goto 11
if %avancadobr% equ 12 goto 12
if %avancadobr% equ 13 goto 13
if %avancadobr% equ 14 goto 14
if %avancadobr% equ 15 goto 15
if %avancadobr% equ 16 goto 16
if %avancadobr% equ 17 goto 17
if %avancadobr% equ 18 goto 18
if %avancadobr% equ 19 goto 19
if %avancadobr% equ 20 goto 20
if %avancadobr% equ 21 goto 21
if %avancadobr% equ 22 goto 22
if %avancadobr% equ 23 goto 23
if %avancadobr% equ 24 goto 24
if %avancadobr% equ 25 goto 25
if %avancadobr% equ 26 goto 26
if %avancadobr% equ 27 goto 27

:1

@echo off
powershell -command "irm https://get.activated.win | iex"

cls
goto menuavancadobr

:2

@echo off
cd \Program Files\Common Files\microsoft shared\ClickToRun\
OfficeC2rclient.exe /update user updatetoversion=16.0.13801.20266

cls
goto menuavancadobr

:3

echo Os navegadores serão finalizados tem certeza que deseja continuar?
echo Sim: Pressione qualquer tecla
echo Não: Feche o Script
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
goto menuavancadobr

:4
@echo off
chkdsk /f /r
echo Para a ferramenta iniciar você precisara reiniciar o computador
echo.
echo O processo de verificacao de disco pode ser bem demorado
echo.
echo Sugiro que reinicie o computador no melhor momento

pause
cls
goto menuavancadobr

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
echo Correcao concluida. Reinicie o computador e tente novamente.

cls
goto menuavancadobr

:6

@echo off
echo Interrompendo o servico de impressao
echo.
net stop spooler
echo Deletando os trabalhos na fila de impressao
echo.
del /Q /F /S %systemroot%\System32\Spool\Printers\*.*
echo Reiniciando o servico de impressao
echo.
net start spooler
echo Limpeza da fila de impressao concluida.
Pause

cls
goto menuavancadobr

:7

@echo off
dism /online /cleanup-image /CheckHealth
timeout /t 3 /nobreak > null
dism /online /cleanup-image /restorehealth
timeout /t 3 /nobreak > null
sfc /scannow
echo O Script esta executando as ferramentas de reparo para o Windows
echo.
echo Durante este processo o computador podera ficar lento, mas nao se preocupe
echo.
echo Caso haja necessidade sinta-se a vontade para continuar usando a maquina
timeout /t 10 /nobreak > null

cls
goto menuavancadobr

:8

@echo off
echo Corrigindo problemas de atualização do Windows
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
echo Correcao concluida. Por favor, reinicie o computador e tente novamente.

cls
goto menuavancadobr

:9

echo yes | winget update --all

cls
goto menuavancadobr

:10

echo A Cortana sera desabilitada tem certeza que deseja continuar?
echo Sim: Pressione qualquer tecla
echo Não: Feche o Script
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
    echo Este script requer privilégios de administrador. Execute o prompt de comando como administrador e tente novamente.
    pause
    exit /b
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
echo Cortana desativada
powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Hydra\lib\scripts\ps1\disablebackgroundapps.ps1"
echo Aplicativos em segundo plano desabilitados
powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Hydra\lib\scripts\ps1\removebloatwares.ps1"
echo Aplicativos desnecessarios removidos
timeout /t 5 /nobreak > null

cls
goto menuavancadobr

:11

@echo off
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\Hydra\lib\scripts\ps1\systemperformance.ps1"
echo O Windows foi configurado para o modo de desempenho maximo.
timeout /t 5 /nobreak > null

cls
goto menuavancadobr

:12
powershell -Command "Get-ChildItem -Path Cert:\CurrentUser\My | Where-Object { $_.NotAfter -lt (Get-Date) } | ForEach-Object { Remove-Item -Path $_.PSPath }"
cls
echo.
echo Certificados vencidos excluidos com sucesso.
echo.
timeout /t 4 >nul

goto menuavancadobr
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
goto menuavancadobr

:14

@echo off
cd "C:\Program Files\Hydra\lib\scripts\python"
python organizer.py
echo.
echo Os itens foram organizados com sucesso, de uma olhada nas pastas selecionadas!
pause
cls
goto menuavancadobr

:15
@echo off

cd "C:\Program Files\Hydra\lib\scripts\python"
python clock.py
pause
cls
goto menuavancadobr

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

goto menuavancadobr

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

goto menuavancadobr