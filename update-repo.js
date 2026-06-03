/**
 * update-repo.js
 * =====================================================
 * Clona o actualiza el repositorio portafolio_V3 desde GitHub
 * Uso: node update-repo.js
 * 
 * Si la carpeta no existe → clona el repo
 * Si la carpeta existe → hace pull de cambios
 * =====================================================
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const REPO_URL = 'https://github.com/Zacaryx/portafolio_V3.git';
const REPO_DIR = path.join(__dirname, 'portafolio_V3_repo');
const BRANCH = 'main';

function log(message, type = 'info') {
  const colors = {
    info: '\x1b[36m',    // cyan
    success: '\x1b[32m', // green
    warning: '\x1b[33m', // yellow
    error: '\x1b[31m',   // red
    reset: '\x1b[0m'
  };
  console.log(`${colors[type] || colors.info}${message}${colors.reset}`);
}

function repoExists() {
  return fs.existsSync(REPO_DIR) && fs.existsSync(path.join(REPO_DIR, '.git'));
}

function cloneRepo() {
  try {
    log(`\n📥 Clonando repositorio desde ${REPO_URL}...`, 'info');
    log(`📂 Destino: ${REPO_DIR}\n`, 'info');
    
    execSync(`git clone --branch ${BRANCH} ${REPO_URL} "${REPO_DIR}"`, {
      stdio: 'inherit'
    });
    
    log('✅ Repositorio clonado exitosamente', 'success');
    return true;
  } catch (err) {
    log(`❌ Error al clonar: ${err.message}`, 'error');
    return false;
  }
}

function pullRepo() {
  try {
    log(`\n⬆️  Actualizando repositorio desde ${BRANCH}...`, 'info');
    log(`📂 Ruta: ${REPO_DIR}\n`, 'info');
    
    execSync(`git -C "${REPO_DIR}" pull origin ${BRANCH}`, {
      stdio: 'inherit'
    });
    
    log('✅ Repositorio actualizado exitosamente', 'success');
    return true;
  } catch (err) {
    log(`❌ Error al actualizar: ${err.message}`, 'error');
    return false;
  }
}

function getRepoInfo() {
  try {
    const branch = execSync(`git -C "${REPO_DIR}" rev-parse --abbrev-ref HEAD`, {
      encoding: 'utf-8'
    }).trim();
    
    const commit = execSync(`git -C "${REPO_DIR}" rev-parse --short HEAD`, {
      encoding: 'utf-8'
    }).trim();
    
    const lastUpdate = execSync(`git -C "${REPO_DIR}" log -1 --format=%ai`, {
      encoding: 'utf-8'
    }).trim();
    
    return { branch, commit, lastUpdate };
  } catch {
    return null;
  }
}

async function run() {
  log('\n═══════════════════════════════════════════════════════════════', 'info');
  log('           Gestor de Repositorio — portafolio_V3', 'info');
  log('═══════════════════════════════════════════════════════════════\n', 'info');

  if (repoExists()) {
    log('📦 Repositorio detectado. Buscando actualizaciones...', 'warning');
    const info = getRepoInfo();
    if (info) {
      log(`   Branch: ${info.branch} | Commit: ${info.commit}`, 'info');
      log(`   Última actualización: ${info.lastUpdate}`, 'info');
    }
    pullRepo();
  } else {
    log('📦 Repositorio no encontrado. Realizando clonación inicial...', 'warning');
    cloneRepo();
  }

  const finalInfo = getRepoInfo();
  if (finalInfo) {
    log('\n✨ Estado actual del repositorio:', 'success');
    log(`   ✓ Branch: ${finalInfo.branch}`, 'success');
    log(`   ✓ Commit: ${finalInfo.commit}`, 'success');
    log(`   ✓ Última actualización: ${finalInfo.lastUpdate}`, 'success');
  }

  log('\n═══════════════════════════════════════════════════════════════\n', 'info');
}

run();
