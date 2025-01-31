@echo off
echo Starting file synchronization tasks...

:: Lenovo <-> Lat_7450 bi-directional synchronization
:: rem /XN: Excludes newer files in the destination (compared to the source) from being overwritten.
:: rem /XX: Excludes "extra" files or folders in the destination that don't exist in the source from being deleted.

:: Lenovo Command 1: Copy Lenovo work folder to SKhynix NVMe
robocopy "C:\Users\mdzamarija\Documents\strucno" "\\tsclient\D\strucno" /MIR /E /DCOPY:T /COPY:DAT /R:2 /W:5 /NDL /NFL /ETA /XX /XN

:: Lenovo Command 1: Copy SKhynix NVMe work folder to Lenovo
robocopy "\\tsclient\D\strucno" "C:\Users\mdzamarija\Documents\strucno" /MIR /E /DCOPY:T /COPY:DAT /R:2 /W:5 /NDL /NFL /ETA /XX /XN

:: Lenovo Command 2: Copy Lenovo personal folder to SKhynix NVMe
robocopy "C:\Users\mdzamarija\Documents\privatno" "\\tsclient\D\privatno" /MIR /E /DCOPY:T /COPY:DAT /R:2 /W:5 /NDL /NFL /ETA /XX /XN

:: Lenovo Command 2: Copy SKhynix NVMe personal folder to Lenovo
robocopy "\\tsclient\D\privatno" "C:\Users\mdzamarija\Documents\privatno" /MIR /E /DCOPY:T /COPY:DAT /R:2 /W:5 /NDL /NFL /ETA /XX /XN

echo Lenovo file synchronization tasks completed.
pause