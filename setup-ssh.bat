@echo off
REM =====================================================
REM setup-ssh.bat
REM Genera SSH key y la agrega a GitHub
REM Uso: Solo haz doble click en este archivo
REM =====================================================

setlocal enabledelayedexpansion

cls
echo.
echo ═══════════════════════════════════════════════════════════════
echo                  Configurar SSH para GitHub
echo ═══════════════════════════════════════════════════════════════
echo.

REM Verificar si ssh-keygen está disponible
ssh-keygen -? >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERROR: SSH no está disponible en tu sistema
    echo.
    echo Git Bash debería incluir ssh-keygen automáticamente
    echo Intenta reinstalar Git desde https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

REM Verificar si ya existe key
if exist "%USERPROFILE%\.ssh\id_rsa" (
    echo ✅ SSH key ya existe
    echo.
    echo 📂 Ubicación: %USERPROFILE%\.ssh\id_rsa
    echo.
    goto show_key
)

REM Generar nueva SSH key
echo 🔐 Generando nueva SSH key...
echo.

ssh-keygen -t rsa -b 4096 -f "%USERPROFILE%\.ssh\id_rsa" -N ""

if %errorlevel% equ 0 (
    echo.
    echo ✅ SSH key generada exitosamente
    echo.
    goto show_key
) else (
    echo.
    echo ❌ Error al generar SSH key
    echo.
    pause
    exit /b 1
)

:show_key
echo.
echo ═══════════════════════════════════════════════════════════════
echo                    ⚠️  INSTRUCCIONES IMPORTANTES
echo ═══════════════════════════════════════════════════════════════
echo.
echo 1️⃣  Abre el archivo de clave pública (se abrirá ahora):
echo    %USERPROFILE%\.ssh\id_rsa.pub
echo.
echo 2️⃣  Copia TODO el contenido (Ctrl+A, Ctrl+C)
echo.
echo 3️⃣  Ve a GitHub: https://github.com/settings/keys
echo.
echo 4️⃣  Click en "New SSH key"
echo.
echo 5️⃣  Pega la clave y guardala
echo.
echo Después, tu script de push funcionará sin pedir contraseña
echo.
echo ═══════════════════════════════════════════════════════════════
echo.

REM Abrir el archivo de clave pública
start notepad "%USERPROFILE%\.ssh\id_rsa.pub"

echo 📋 Se abrió la clave pública en Notepad
echo    Cópiala y agrégala a GitHub
echo.
pause
