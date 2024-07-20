@echo off
setlocal enabledelayedexpansion

:menu
cls
echo Select a Windows utility to execute:
echo 1. ipconfig
echo 2. tasklist
echo 3. taskkill
echo 4. chkdsk
echo 5. format
echo 6. defrag
echo 7. find
echo 8. attrib
set /p choice="Enter your choice (1-8): "

if "%choice%"=="1" goto ipconfig
if "%choice%"=="2" goto tasklist
if "%choice%"=="3" goto taskkill
if "%choice%"=="4" goto chkdsk
if "%choice%"=="5" goto format
if "%choice%"=="6" goto defrag
if "%choice%"=="7" goto find
if "%choice%"=="8" goto attrib
echo Invalid choice. Please try again.
pause
goto menu

:ipconfig
echo Running ipconfig...
ipconfig
goto end

:tasklist
echo Running tasklist...
tasklist
goto end

:taskkill
set /p pid="Enter the PID of the process to kill: "
if "%pid%"=="" (
    echo PID cannot be empty. Returning to menu.
    pause
    goto menu
)
echo Killing process with PID %pid%...
taskkill /PID %pid%
goto end

:chkdsk
set /p drive="Enter the drive letter to check (e.g., C:): "
if "%drive%"=="" (
    echo Drive letter cannot be empty. Returning to menu.
    pause
    goto menu
)
echo Running chkdsk on %drive%...
chkdsk %drive%
goto end

:format
set /p drive="Enter the drive letter to format (e.g., D:): "
if "%drive%"=="" (
    echo Drive letter cannot be empty. Returning to menu.
    pause
    goto menu
)
echo WARNING: Formatting will erase all data on the drive!
set /p confirm="Are you sure you want to format %drive%? (Y/N): "
if /I "%confirm%" NEQ "Y" (
    echo Format canceled. Returning to menu.
    pause
    goto menu
)
echo Formatting %drive%...
format %drive%
goto end

:defrag
set /p drive="Enter the drive letter to defrag (e.g., C:): "
if "%drive%"=="" (
    echo Drive letter cannot be empty. Returning to menu.
    pause
    goto menu
)
echo Running defrag on %drive%...
defrag %drive%
goto end

:find
set /p search="Enter the string to search for: "
set /p file="Enter the file to search in: "
if "%search%"=="" (
    echo Search string cannot be empty. Returning to menu.
    pause
    goto menu
)
if "%file%"=="" (
    echo File name cannot be empty. Returning to menu.
    pause
    goto menu
)
echo Searching for "%search%" in %file%...
find "%search%" %file%
goto end

:attrib
set /p file="Enter the file or directory to change attributes: "
if "%file%"=="" (
    echo File or directory name cannot be empty. Returning to menu.
    pause
    goto menu
)
echo Changing attributes for %file%...
attrib %file%
goto end

:end
echo Done.
pause
goto menu
