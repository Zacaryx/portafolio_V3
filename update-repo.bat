@echo off
REM =====================================================
REM update-repo.bat
REM Clona o actualiza el repositorio portafolio_V3
REM Uso: Solo haz doble click en este archivo
REM =====================================================

setlocal enabledelayedexpansion

set "REPO_URL=https://github.com/Zacaryx/portafolio_V3.git"
set "REPO_DIR=%CD%\portafolio_V3_repo"
set "BRANCH=main"

cls
echo.
echo ═══════════════════════════════════════════════════════════════
echo            Gestor de Repositorio - portafolio_V3
echo ═══════════════════════════════════════════════════════════════
echo.

REM Verificar si git está disponible
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: Git no está instalado o no está en el PATH
    echo.
    echo Solución: Descarga e instala Git desde https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

REM Verificar si el repositorio ya existe
if exist "%REPO_DIR%\.git" (
    echo 📦 Repositorio detectado. Actualizando...
    echo 📂 Ruta: %REPO_DIR%
    echo.
    
    cd /d "%REPO_DIR%"
    echo ⬆️  Haciendo pull desde %BRANCH%...
    echo.
    git pull origin %BRANCH%
    
    if %errorlevel% equ 0 (
        echo.
        echo ✅ Repositorio actualizado exitosamente
        for /f "tokens=*" %%A in ('git rev-parse --short HEAD') do set "COMMIT=%%A"
        for /f "tokens=*" %%A in ('git log -1 --format=%%ai') do set "DATE=%%A"
        echo    ✓ Commit: !COMMIT!
        echo    ✓ Fecha: !DATE!
    ) else (
        echo.
        echo ❌ Error al actualizar el repositorio
    )
) else (
    echo 📦 Repositorio no encontrado. Clonando...
    echo 📥 Origen: %REPO_URL%
    echo 📂 Destino: %REPO_DIR%
    echo.
    
    git clone --branch %BRANCH% %REPO_URL% "%REPO_DIR%"
    
    if %errorlevel% equ 0 (
        echo.
        echo ✅ Repositorio clonado exitosamente
        cd /d "%REPO_DIR%"
        for /f "tokens=*" %%A in ('git rev-parse --short HEAD') do set "COMMIT=%%A"
        for /f "tokens=*" %%A in ('git log -1 --format=%%ai') do set "DATE=%%A"
        echo    ✓ Commit: !COMMIT!
        echo    ✓ Fecha: !DATE!
    ) else (
        echo.
        echo ❌ Error al clonar el repositorio
    )
)

echo.
echo ═══════════════════════════════════════════════════════════════
echo.
pause
