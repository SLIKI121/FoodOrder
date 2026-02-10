$ErrorActionPreference = "Stop"

$PROJECT_DIR = "d:\DAP(PROJECTS)\FoodOrder"
$TOMCAT_DIR = "$PROJECT_DIR\apache-tomcat-10.1.24"
$WEBAPP_DIR = "$TOMCAT_DIR\webapps\FoodOrder"
$BUILD_DIR = "$PROJECT_DIR\build\classes"

Write-Host "FoodOrder Application - Build Script" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Building and Deploying FoodOrder..." -ForegroundColor Cyan

# 1. Compile
Write-Host "1. Compiling..."
if (-not (Test-Path $BUILD_DIR)) { New-Item -ItemType Directory -Path $BUILD_DIR -Force }
$src = "$PROJECT_DIR\src\main\java"
$javaFiles = Get-ChildItem -Path $src -Include "*.java" -Recurse
$webInfLib = "$PROJECT_DIR\src\main\webapp\WEB-INF\lib"
$tomcatLib = "$TOMCAT_DIR\lib"

# Construct Classpath
$classpath = "$webInfLib\*;$tomcatLib\*"

javac -d "$BUILD_DIR" -cp "$classpath" -encoding UTF-8 $javaFiles.FullName
if ($LASTEXITCODE -ne 0) { throw "Compilation failed" }

# 2. Deploy
Write-Host "2. Deploying to $WEBAPP_DIR..."
# Clean old
if (Test-Path $WEBAPP_DIR) { Remove-Item -Path $WEBAPP_DIR -Recurse -Force }
New-Item -ItemType Directory -Path $WEBAPP_DIR -Force

# Copy WebContent
Copy-Item "$PROJECT_DIR\src\main\webapp\*" "$WEBAPP_DIR" -Recurse

# Copy Compiled Classes
$destClasses = "$WEBAPP_DIR\WEB-INF\classes"
if (-not (Test-Path $destClasses)) { New-Item -ItemType Directory -Path $destClasses -Force }
Copy-Item "$BUILD_DIR\*" "$destClasses" -Recurse

Write-Host "Deployment ready." -ForegroundColor Green

# 3. Start Tomcat
Write-Host "3. Starting Tomcat..."
$process = Get-Process -Name "java" -ErrorAction SilentlyContinue | Where-Object { $_.Path -like "*tomcat*" }
if ($process) {
    Write-Host "Tomcat is already running. Restarting..." -ForegroundColor Yellow
    Stop-Process -Id $process.Id -Force
    Start-Sleep -s 5
}

Start-Process -FilePath "startup.bat" -WorkingDirectory "$TOMCAT_DIR\bin" -WindowStyle Minimized

Write-Host "Tomcat started. Please wait a few seconds then check http://localhost:8081/FoodOrder" -ForegroundColor Yellow
