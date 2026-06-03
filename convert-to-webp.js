/**
 * convert-to-webp.js
 * =====================================================
 * Convierte todas las imágenes de assets/images/ a WebP.
 * Uso: node convert-to-webp.js
 *
 * Requiere: npm install sharp
 * =====================================================
 */

const sharp = require('sharp');
const fs    = require('fs');
const path  = require('path');

const INPUT_DIR  = path.join(__dirname, 'assets', 'images');
const OUTPUT_DIR = INPUT_DIR; // los .webp quedan en la misma carpeta
const QUALITY    = 85;        // calidad WebP (0-100)

// Extensiones soportadas
const SUPPORTED = ['.png', '.jpg', '.jpeg', '.gif', '.tiff', '.bmp', '.avif'];

async function convertImage(filePath) {
  const ext  = path.extname(filePath).toLowerCase();
  const base = path.basename(filePath, ext);
  const dir  = path.dirname(filePath);
  const out  = path.join(dir, base + '.webp');

  // Evita reconvertir si el .webp ya existe y es más reciente
  if (fs.existsSync(out)) {
    const srcStat = fs.statSync(filePath);
    const dstStat = fs.statSync(out);
    if (dstStat.mtimeMs >= srcStat.mtimeMs) {
      console.log(`  ⏭  Omitido (ya existe): ${base}.webp`);
      return;
    }
  }

  try {
    const info = await sharp(filePath)
      .webp({ quality: QUALITY })
      .toFile(out);

    const srcSize = fs.statSync(filePath).size;
    const dstSize = info.size;
    const saving  = (((srcSize - dstSize) / srcSize) * 100).toFixed(1);

    console.log(`  ✅  ${path.basename(filePath)} → ${base}.webp  (${(srcSize/1024).toFixed(0)}KB → ${(dstSize/1024).toFixed(0)}KB, ahorro: ${saving}%)`);
  } catch (err) {
    console.error(`  ❌  Error convirtiendo ${path.basename(filePath)}: ${err.message}`);
  }
}

async function run() {
  if (!fs.existsSync(INPUT_DIR)) {
    console.error(`No existe la carpeta: ${INPUT_DIR}`);
    process.exit(1);
  }

  const files = fs.readdirSync(INPUT_DIR).filter(f => {
    const ext = path.extname(f).toLowerCase();
    return SUPPORTED.includes(ext) && !f.endsWith('.webp');
  });

  if (files.length === 0) {
    console.log('No se encontraron imágenes para convertir.');
    return;
  }

  console.log(`\nConvirtiendo ${files.length} imágen(es) a WebP (calidad ${QUALITY})...\n`);

  for (const file of files) {
    await convertImage(path.join(INPUT_DIR, file));
  }

  console.log('\n¡Conversión completada!');
  console.log('Recuerda: el script ya actualizó las rutas a .webp en index.html.');
}

run();
