@echo off
setlocal enabledelayedexpansion

:menu
echo Please select a shape:
echo 1. Circle
echo 2. Triangle
echo 3. Quadrilateral
set /p shape="Enter your choice (1/2/3): "

if "%shape%"=="1" goto circle
if "%shape%"=="2" goto triangle
if "%shape%"=="3" goto quadrilateral
echo Invalid choice. Please try again.
goto menu

:circle
set /p radius="Enter the radius of the circle: "
set /a area=314*radius*radius/100
echo The area of the circle is: !area!
goto end

:triangle
set /p a="Enter the length of side a: "
set /p b="Enter the length of side b: "
set /p c="Enter the length of side c: "
call :triangleArea %a% %b% %c%
call :triangleType %a% %b% %c%
goto end

:triangleArea
set a=%1
set b=%2
set c=%3
powershell -command ^
    $a=%a%; $b=%b%; $c=%c%; ^
    $s=($a + $b + $c) / 2; ^
    $area=[math]::Sqrt($s * ($s - $a) * ($s - $b) * ($s - $c)); ^
    [math]::Round($area, 2) | Out-File -FilePath area.txt -NoNewline
set /p area=<area.txt
del area.txt
echo The area of the triangle is: %area%
exit /b

:triangleType
set a=%1
set b=%2
set c=%3
if %a%==%b% if %b%==%c% (
    echo The triangle is equilateral.
) else if %a%==%b% if not %b%==%c% (
    echo The triangle is isosceles.
) else if not %a%==%b% if %b%==%c% (
    echo The triangle is isosceles.
) else if %a%==%c% if not %b%==%c% (
    echo The triangle is isosceles.
) else (
    echo The triangle is scalene.
)
exit /b

:quadrilateral
set /p length="Enter the length: "
set /p width="Enter the width: "
set /a area=length*width
echo The area of the quadrilateral is: !area!
if %length%==%width% (
    echo The quadrilateral is a square.
) else (
    echo The quadrilateral is a rectangle.
)
goto end

:end
echo Done.
pause
