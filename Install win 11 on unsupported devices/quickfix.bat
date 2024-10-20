@echo off
echo Creating LabConfig key and values...

:: Create the 'LabConfig' key within 'Setup'
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f

:: Create the 'BypassTPMCheck' DWORD value and set it to 1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /v BypassTPMCheck /t REG_DWORD /d 1 /f

:: Create the 'BypassSecureBootCheck' DWORD value and set it to 1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /v BypassSecureBootCheck /t REG_DWORD /d 1 /f

echo LabConfig key and values created successfully.
pause
