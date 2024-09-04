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
color 3
cls

title  Hydra - Desenvolvido por: Miguel Lucchesi Oliveira.

:launcher
echo. 
echo                             Hydra - Compativel com Windows 10-11  
echo.                Seja bem vindo ao Hydra Launcher! Escolha uma das opcoes abaixo
echo.
echo    1) Menu Simplificado PT-BR                     ^|  3) Menu Simplificado EN-US              ^|
echo    2) Menu Avancado PT-BR                         ^|  4) Menu Avancado EN-US                  ^|
echo.    
echo    5) Sair
echo.

set/p launcher= Digite sua opcao:

if %launcher% equ 1 goto 1
if %launcher% equ 2 goto 2
if %launcher% equ 3 goto 3
if %launcher% equ 4 goto 4
if %launcher% equ 5 goto 5

:1
@echo off
"C:\Program Files\Hydra\lib\launchers\PT-BR\hydrasimples.bat"
exit

:2
@echo off
"C:\Program Files\Hydra\lib\launchers\PT-BR\hydraavancado.bat"
exit

:3
@echo off
"C:\Program Files\Hydra\lib\launchers\EN-US\hydrasimple.bat"
exit

:4
@echo off
"C:\Program Files\Hydra\lib\launchers\EN-US\hydraadvanced.bat"
exit

:5
exit