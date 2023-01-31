@echo off

:: Made by Apix | @Apix0n
:: https://github.com/Apix0n/stuff

:: The command prompt restarts minimized.
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" && exit

:: Creates 
mkdir GPK_files
mkdir tmpGPK_%computername%
attrib +h tmpGPK_%computername%
set dir=%~dp0%
cd %dir%

:: Gets the OEM key (if it exists).
:oem
wmic path softwarelicensingservice get OA3xOriginalProductKey > .\tmpGPK_%computername%\pk-oem.txt

:: Gets the Backup Product Key in the registry. (< Windows 8)
:reg
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v BackupProductKeyDefault > .\tmpGPK_%computername%\pk-reg.txt

:: Gets the system's edition and its Build Number.
:ebn
wmic os get Caption, BuildNumber /value > .\tmpGPK_%computername%\ebn-info.txt

:: Gets the Digital key
:digital
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId > .\tmpGPK_%computername%\pk-dig.txt

:: Compress the folder and deletes it. If powershell isn't available/error, it keeps the folder.
:compress
powershell Compress-Archive -Force .\tmpGPK_%computername%\* .\GPK_files\GPK_%computername%.zip && rmdir /s /q tmpGPK_%computername%