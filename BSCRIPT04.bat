@echo off
setlocal enabledelayedexpansion

:: Define source and destination directories
set source_dir=C:\path\to\your\files
set archive_dir=Z:\archive

:: Create the archive directory if it doesn't exist
if not exist "%archive_dir%" mkdir "%archive_dir%"

:: Get today's date
for /f "tokens=2 delims==" %%i in ('wmic OS Get localdatetime /value') do set datetime=%%i
set date=%datetime:~0,8%

:: Archive older files to archive directory and sort them by size
echo Archiving older files...
forfiles /p "%source_dir%" /s /d -30 /c "cmd /c move @file %archive_dir%\"

echo Sorting archived files by size...
for /f "delims=" %%A in ('dir /b /s /o:s "%archive_dir%\*"') do (
    set "file=%%A"
    echo !file!
)

:: Prompt user for permission to delete old large files
echo.
echo The following files are old and large:
for /f "delims=" %%A in ('dir /b /s /o:s "%archive_dir%\*"') do (
    set "file=%%A"
    set "size="
    for /f "tokens=3" %%B in ('dir "%%A"^|findstr /R /C:"[0-9][0-9,]* bytes"') do set "size=%%B"
    echo File: !file! Size: !size!
    set /p deletefile=Do you want to delete this file (Y/N)? 
    if /i !deletefile!==Y del /f "%%A"
)

echo Done.
pause
