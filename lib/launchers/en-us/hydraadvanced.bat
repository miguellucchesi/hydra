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

:menu
echo. 
echo                             Hydra - Compativel com Windows 10-11  MENU SIMPLES
echo    #) Manual     
echo.
echo    *) Instalador de requerimentos                 ^|  24) Reset de interfaces de Rede         ^|
echo    1) Speed test (Desktop Log).Py                 ^|  25) Reset de adaptadores Wifi           ^|
echo    2) Ativador Windows/Office                     ^|  26) Organizador Downloads               ^|
echo    3) Limpeza de Temporarios                      ^|  27) Organizador Desktop                 ^|
echo    4) Limpeza Profunda (Exclui Downloads)         ^|  28) Desfragmentacao Otimizada           ^|
echo    5) Java GOV (adiciona excecoes)                ^|  29) Reverter Botao Direito Win 11       ^|
echo    6) Spooler Clear                               ^|  30) Desativar UAC                       ^|
echo    7) Relatorio de Bateria                        ^|  31) Sincronizar Relogio                 ^|
echo    8) Relatorio WLAN                              ^|  32) Resolver Problemas Excel            ^|
echo    9) Aumentar Cache DNS                          ^|  33) Modo Desempenho (Bateria)           ^|
echo   10) Check-Health / Restore-Health               ^|  34) Modo Desempenho Sysdm.cpl           ^|
echo   11) SFC / SCANNOW                               ^|  35) RED BUTTON                          ^|
echo   12) CHKDSK                                      ^|  36) DEC/REC Hunter                      ^|
echo   13) SET Firewall OFF                            ^|  37) Ingressar em Dominio                ^|
echo   14) SET Firewall ON                             ^|  38) System Info                         ^|
echo   15) Remover Apps da Microsoft Store             ^|  39) Criar Usuario ADMIN                 ^|
echo   16) CIPHER                                      ^|  40) Desabilita Servicos + Cortana       ^|
echo   17) Remover Mensagem de ativacao Office         ^|  41) Obter IP Publico / Provedor / MAC   ^|
echo   18) Excluir Certificados A1 Vencidos            ^|  42) Install PSEXEC                      ^|
echo   19) Desliga PC Remoto                           ^|  43) Comprimir PDF.Py                    ^|
echo   20) Remove Pastas Vazias                        ^|  44) Eraser Files Hunter.Py              ^|
echo   21) Desativa aplicativos em segundo plano       ^|  45) EXIT                                ^|
echo   22) Windows Update FIX                                                                     ^|
echo   23) Backup - Imagens + Documentos                                                          ^|
echo.                                                                                             ^|
echo.                                                                                             ^|
set/p op= Digite sua opcao:
