@echo off
REM =====================================================
REM push-to-github.bat
REM Sube TODO el proyecto a GitHub
REM Uso: Solo haz doble click en este archivo
REM =====================================================

setlocal enabledelayedexpansion

set "REPO_URL=git@github.com:Zacaryx/portafolio_V3.git"
set "BRANCH=main"

cls
echo.
echo ═══════════════════════════════════════════════════════════════
echo             Push a GitHub (SSH) - portafolio_V3
echo ═══════════════════════════════════════════════════════════════
echo.

REM Verificar si git está disponible
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: Git no está instalado o no está en el PATH
    echo.
    pause
    exit /b 1
)

REM Verificar si ya existe .git
if exist ".git" (
    echo 📦 Repositorio git detectado. Actualizando cambios...
    echo.
) else (
    echo 📦 Inicializando repositorio git...
    echo.
    git init
    
    echo ⚙️  Configurando usuario git...
    git config user.name "Eduardo Zacary Vargas"
    git config user.email "eduardozacaryvargasoyola@gmail.com"
    
    echo ⚙️  Agregando remote: %REPO_URL%
    git remote add origin %REPO_URL%
    echo.
)

echo ⬆️  Agregando todos los archivos...
git add .

if %errorlevel% neq 0 (
    echo ❌ Error al agregar archivos
    pause
    exit /b 1
)

echo ⬆️  Creando commit...
git commit -m "Portfolio V3 - Actualización completa con assets y scripts"

if %errorlevel% equ 0 (
    echo.
    echo ⬆️  Haciendo push a %BRANCH%...
    echo.
    git push -u origin %BRANCH%
    
    if %errorlevel% equ 0 (
        echo.
        echo ✅ ¡Push completado exitosamente!
        echo.
        echo 📊 Información del commit:
        for /f "tokens=*" %%A in ('git rev-parse --short HEAD') do set "COMMIT=%%A"
        for /f "tokens=*" %%A in ('git log -1 --format=%%ai') do set "DATE=%%A"
        echo    ✓ Commit: !COMMIT!
        echo    ✓ Fecha: !DATE!
        echo    ✓ URL: %REPO_URL%
    ) else (
        echo.
        echo ❌ Error al hacer push. Asegúrate de que:
        echo    1. Ejecutaste setup-ssh.bat primero
        echo    2. Agregaste la SSH key a GitHub
        echo    3. Tienes conexión a internet
    )
) else (
    echo.
    echo ⚠️  No hay cambios para hacer commit
)

echo.
echo ═══════════════════════════════════════════════════════════════
echo.
pause
