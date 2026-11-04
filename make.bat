@echo off
setlocal
cd /d "%~dp0"

where latexmk >nul 2>nul || (
    echo latexmk was not found. Install TeX Live 2026 and add it to PATH.
    exit /b 1
)
where zhmakeindex >nul 2>nul || (
    echo zhmakeindex was not found. Add it to PATH.
    exit /b 1
)
where biber >nul 2>nul || (
    echo Biber was not found. Install biblatex and add Biber to PATH.
    exit /b 1
)
where python >nul 2>nul || (
    echo Python 3 was not found. Add it to PATH.
    exit /b 1
)

set "TARGET=%~1"
if "%TARGET%"=="" set "TARGET=Chinese-Standard-Template"

if /i "%TARGET%"=="clean" (
    set "TARGET=%~2"
    if "%TARGET%"=="" set "TARGET=Chinese-Standard-Template"
    latexmk -C "%TARGET%"
    exit /b %errorlevel%
)

latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error "%TARGET%"
exit /b %errorlevel%
