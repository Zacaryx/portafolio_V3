=========================================

param(
    [switch]$Force = $false
)

$REPO_URL = "https://github.com/Zacaryx/portafolio_V3.git"
$REPO_DIR = Join-Path $PSScriptRoot "portafolio_V3_repo"
$BRANCH = "main"

function Write-Log {
    param(
        [string]$Message,
        [ValidateSet("Info", "Success", "Warning", "Error")]
        [string]$Type = "Info"
    )
    
    $colors = @{
        Info    = "Cyan"
        Success = "Green"
        Warning = "Yellow"
        Error   = "Red"
    }
    
    Write-Host $Message -ForegroundColor $colors[$Type]
}

function Test-RepoExists {
    return (Test-Path $REPO_DIR) -and (Test-Path (Join-Path $REPO_DIR ".git"))
}

function Invoke-CloneRepo {
    try {
        Write-Log "`n📥 Clonando repositorio desde $REPO_URL..." "Info"
        Write-Log "📂 Destino: $REPO_DIR`n" "Info"
        
        & git clone --branch $BRANCH $REPO_URL $REPO_DIR
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "✅ Repositorio clonado exitosamente" "Success"
            return $true
        } else {
            Write-Log "❌ Error al clonar (exit code: $LASTEXITCODE)" "Error"
            return $false
        }
    } catch {
        Write-Log "❌ Error al clonar: $_" "Error"
        return $false
    }
}

function Invoke-PullRepo {
    try {
        Write-Log "`n⬆️  Actualizando repositorio desde $BRANCH..." "Info"
        Write-Log "📂 Ruta: $REPO_DIR`n" "Info"
        
        Push-Location $REPO_DIR
        & git pull origin $BRANCH
        Pop-Location
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "✅ Repositorio actualizado exitosamente" "Success"
            return $true
        } else {
            Write-Log "❌ Error al actualizar (exit code: $LASTEXITCODE)" "Error"
            return $false
        }
    } catch {
        Write-Log "❌ Error al actualizar: $_" "Error"
        return $false
    }
}

function Get-RepoInfo {
    if ((Test-Path $REPO_DIR) -and (Test-Path (Join-Path $REPO_DIR ".git"))) {
        try {
            Push-Location $REPO_DIR
            
            $branch = & git rev-parse --abbrev-ref HEAD
            $commit = & git rev-parse --short HEAD
            $lastUpdate = & git log -1 --format="%ai"
            
            Pop-Location
            
            return @{
                Branch      = $branch
                Commit      = $commit
                LastUpdate  = $lastUpdate
            }
        } catch {
            return $null
        }
    }
    return $null
}

function Main {
    Write-Log "`n═══════════════════════════════════════════════════════════════" "Info"
    Write-Log "           Gestor de Repositorio — portafolio_V3" "Info"
    Write-Log "═══════════════════════════════════════════════════════════════`n" "Info"

    if (Test-RepoExists) {
        Write-Log "📦 Repositorio detectado. Buscando actualizaciones..." "Warning"
        
        $info = Get-RepoInfo
        if ($info) {
            Write-Log "   Branch: $($info.Branch) | Commit: $($info.Commit)" "Info"
            Write-Log "   Última actualización: $($info.LastUpdate)" "Info"
        }
        
        Invoke-PullRepo
    } else {
        Write-Log "📦 Repositorio no encontrado. Realizando clonación inicial..." "Warning"
        Invoke-CloneRepo
    }

    $finalInfo = Get-RepoInfo
    if ($finalInfo) {
        Write-Log "`n✨ Estado actual del repositorio:" "Success"
        Write-Log "   ✓ Branch: $($finalInfo.Branch)" "Success"
        Write-Log "   ✓ Commit: $($finalInfo.Commit)" "Success"
        Write-Log "   ✓ Última actualización: $($finalInfo.LastUpdate)" "Success"
    }

    Write-Log "`n═══════════════════════════════════════════════════════════════`n" "Info"
}

Main
