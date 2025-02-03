@echo off
echo Starting file synchronization tasks...

:: Lat_E7450 Command 1: Copy Documents folder
robocopy "C:\Users\mario\Documents" "D:\Lat_back" /PURGE /E /DCOPY:T /COPY:DAT /R:2 /W:5 /NDL /NFL /ETA /XD "Downloaded Installations" "PTI" "com.pieces.*" /XF "*.rdp" "desktop.ini"

:: Lat_E7450 Command 2: Copy WSL2 home directory
robocopy "\\wsl$\Ubuntu-22.04\home\madz" "D:\WSL2" /PURGE /E /DCOPY:T /COPY:DAT /R:2 /W:5 /NDL /NFL /ETA  /XD "miniforge3" ".vscode-server-insiders" "snap" /XF "*Zone.Identifier"

echo Lat_7450 file synchronization tasks completed.
pause