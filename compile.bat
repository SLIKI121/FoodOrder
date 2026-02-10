@echo off
set "PROJECT_ROOT=d:\DAP(PROJECTS)\FoodOrder"
set "LIB=%PROJECT_ROOT%\src\main\webapp\WEB-INF\lib\*"
set "TOMCAT_LIB=%PROJECT_ROOT%\apache-tomcat-10.1.24\lib\*"
set "CLASSPATH=.;%LIB%;%TOMCAT_LIB%"
set "BIN=%PROJECT_ROOT%\src\main\webapp\WEB-INF\classes"
set "SRC=%PROJECT_ROOT%\src\main\java"

if not exist "%BIN%" mkdir "%BIN%"

echo Finding all Java files...
dir /s /b "%SRC%\*.java" > sources.txt

echo Compiling...
javac -cp "%CLASSPATH%" -d "%BIN%" @sources.txt

if %ERRORLEVEL% EQU 0 (
    echo Compilation successful!
    del sources.txt
) else (
    echo Compilation failed!
    del sources.txt
    exit /b %ERRORLEVEL%
)
