@echo off

:: Made by Apix | @Apix0n
:: https://apix0n.github.io/stuff

if defined %1 set %stopnumber%; goto skip

cls
echo ---- FolderSpam ----
echo How many folders should be created? (Type 0 for infinite folders)
echo Press Ctrl+C to stop the creation of folders.
set /p stopnumber=Value: 

:skip
:: If the user chose infinite folders, the script will end at 2147483647 
:: (integer limit for x32 systems)
if %stopnumber%==0 set stopnumber=2147483647
set number=0

:loop
set /a number=%number%+1
mkdir folder%number%
if %number%==%stopnumber% exit
goto loop