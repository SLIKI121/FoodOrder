@echo off
REM Build Script for FoodOrder Application
REM This script compiles all Java files and creates the necessary directory structure

setlocal enabledelayedexpansion

REM Set paths
set PROJECT_DIR=d:\DAP(PROJECTS)\FoodOrder
set SRC_DIR=%PROJECT_DIR%\src\main\java
set BUILD_DIR=%PROJECT_DIR%\build\classes
set WEBAPP_DIR=%PROJECT_DIR%\src\main\webapp
set WEB_INF=%WEBAPP_DIR%\WEB-INF

REM Create build directories if they don't exist
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
if not exist "%BUILD_DIR%\com\tap" mkdir "%BUILD_DIR%\com\tap"

echo.
echo ============================================
echo FoodOrder Application - Build Script
echo ============================================
echo.
echo Project Directory: %PROJECT_DIR%
echo Source Directory: %SRC_DIR%
echo Build Directory: %BUILD_DIR%
echo.

REM Change to source directory
cd /d "%SRC_DIR%"

REM Compile all Java files
echo Compiling Java files...
echo.

REM Get all java files and compile them
for /r "%SRC_DIR%" %%f in (*.java) do (
    echo Compiling: %%f
)

echo Compiling with javac...
set "LIBS=%WEB_INF%\lib\*"
set "TOMCAT_LIBS=%PROJECT_DIR%\apache-tomcat-10.1.24\lib\*"
set "CP=%LIBS%;%TOMCAT_LIBS%"

javac -d "%BUILD_DIR%" -cp "%CP%" -encoding UTF-8 ^
    "%SRC_DIR%\com\tap\Servlets\*.java" ^
    "%SRC_DIR%\com\tap\model\*.java" ^
    "%SRC_DIR%\com\tap\dao\*.java" ^
    "%SRC_DIR%\com\tap\dapimplementation\*.java" ^
    "%SRC_DIR%\com\tap\utilty\*.java" 2>build_errors.txt

REM Check if compilation was successful
if errorlevel 1 (
    echo.
    echo [ERROR] Compilation failed!
    echo Check build_errors.txt for details
    type build_errors.txt
    exit /b 1
) else (
    echo.
    echo [SUCCESS] Compilation completed successfully!
    echo Compiled files are in: %BUILD_DIR%
    echo.
    
    REM List compiled classes
    echo.
    echo Generated Classes:
    dir /s /b "%BUILD_DIR%\*.class" | findstr /c:".class"
)

echo.
echo Build process completed!
echo.
pause
