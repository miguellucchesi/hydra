@echo off
start chrome https://codeload.github.com/miguellucchesi/hydra/zip/refs/heads/main https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-701br.exe
@echo O Hydra esta sendo baixado, aguarde.
timeout /t 10 > NUL
cd "C:\Users\%USERNAME%\Downloads"
start python-3.10.0-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
start winrar-x64-701br.exe /S
taskkill /im chrome 2> NUL
@echo O Hydra esta sendo instalado.
timeout /t 10 > NUL
copy "C:\Users\%USERNAME%\Downloads\hydra-main.zip" "C:\Program Files\"
setx PATH "%PATH%;C:\Program Files\WinRAR;C:\Users\%username%\AppData\Local\Programs\Python\Python310;C:\Users\%username%\AppData\Local\Programs\Python\Python310\Scripts;C:\Users\%username%\AppData\Local\Programs\Python\Launcher;C:\Users\%username%\AppData\Local\Programs\Python"
"C:\Program Files\WinRAR\winrar.exe" x "C:\Program Files\hydra-main.zip" "C:\Program Files"
mkdir "C:\Program Files\Hydra\logs"
cd "C:\Program Files\"
ren "hydra-main" "Hydra"
del /Q /F "hydra-main.zip"
del /Q /F "C:\Users\%USERNAME%\Downloads\hydra-main.zip"
del /Q /F "C:\Users\%USERNAME%\Downloads\python-3.10.0-amd64.exe"
del /Q /F "C:\Users\%USERNAME%\Downloads\winrar-x64-701br.exe"
powershell "$s=(New-Object -COM WScript.Shell).CreateShortcut('%USERPROFILE%\Desktop\Hydra Launcher.lnk');$s.TargetPath='C:\Program Files\Hydra\Hydra Launcher.bat';$s.WorkingDirectory='C:\Program Files\Hydra';$s.Save()"