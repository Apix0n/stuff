@echo off

:: Made by Apix | @Apix0n
:: https://github.com/Apix0n/stuff

if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" && exit

mkdir GPK_files
mkdir tmpGPK_%computername%
attrib +h tmpGPK_%computername%
set dir=%~dp0%
cd %dir%

:oem
wmic path softwarelicensingservice get OA3xOriginalProductKey > .\tmpGPK_%computername%\pk-oem.txt

:reg
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v BackupProductKeyDefault > .\tmpGPK_%computername%\pk-reg.txt

:next
wmic os get Caption, BuildNumber /value > .\tmpGPK_%computername%\ebn-info.txt
powershell Compress-Archive -Force .\tmpGPK_%computername%\* .\GPK_files\GPK_%computername%.zip
rmdir /s /q tmpGPK_%computername%
exit