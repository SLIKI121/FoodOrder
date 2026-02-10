#!/usr/bin/env powershell

# FoodOrder Application Build Script

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "FoodOrder Application - Build Script" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Set paths
$PROJECT_DIR = "d:\DAP(PROJECTS)\FoodOrder"
$SRC_DIR = "$PROJECT_DIR\src\main\java"
$BUILD_DIR = "$PROJECT_DIR\build\classes"
$WEBAPP_DIR = "$PROJECT_DIR\src\main\webapp"
$LIB_DIR = "$WEBAPP_DIR\WEB-INF\lib"
$TOMCAT_LIB = "$PROJECT_DIR\apache-tomcat-10.1.24\lib"

Write-Host "Project Directory: $PROJECT_DIR" -ForegroundColor Yellow
Write-Host "Source Directory: $SRC_DIR" -ForegroundColor Yellow
Write-Host "Build Directory: $BUILD_DIR" -ForegroundColor Yellow
Write-Host ""

# Create build directories if they don't exist
if (-not (Test-Path $BUILD_DIR)) {
    New-Item -ItemType Directory -Path $BUILD_DIR -Force | Out-Null
    Write-Host "[CREATE] Build directory created" -ForegroundColor Green
}

# Get all Java files
$javaFiles = Get-ChildItem -Path $SRC_DIR -Include "*.java" -Recurse -File

Write-Host "Found $($javaFiles.Count) Java files to compile" -ForegroundColor Cyan
Write-Host ""

# Construct Classpath
$cp = "$LIB_DIR\*;$TOMCAT_LIB\*"

# Compile Java files
Write-Host "Compiling Java files..." -ForegroundColor Cyan

try {
    & javac -d $BUILD_DIR -cp "$cp" -encoding UTF-8 $javaFiles.FullName 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "[SUCCESS] Compilation completed successfully!" -ForegroundColor Green
        
        # Count compiled classes
        $classFiles = Get-ChildItem -Path $BUILD_DIR -Include "*.class" -Recurse -File
        Write-Host "Generated $($classFiles.Count) class files" -ForegroundColor Green
        Write-Host ""
        Write-Host "Build Output:" -ForegroundColor Cyan
        Get-ChildItem -Path $BUILD_DIR -Recurse -Include "*.class" | ForEach-Object { 
            Write-Host "  ✓ $($_.Name)"
        }
    }
    else {
        Write-Host "[ERROR] Compilation failed!" -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "[ERROR] $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "Build process completed!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
