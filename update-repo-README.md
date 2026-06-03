# 🔄 Actualizar Repositorio — portafolio_V3

Scripts para clonar y actualizar automáticamente el repositorio `portafolio_V3` desde GitHub.

---

## 📋 ¿Qué hacen?

- **Primera ejecución**: Clona el repositorio completo en `portafolio_V3_repo/`
- **Ejecuciones posteriores**: Actualiza los cambios desde la rama `main`
- **Información**: Muestra branch, commit y última actualización

---

## 🚀 Uso

### Opción 1: Node.js (Recomendado)

```bash
node update-repo.js
```

**Requisitos**: Node.js instalado + `git` disponible en PATH

---

### Opción 2: PowerShell

```powershell
.\update-repo.ps1
```

**Requisitos**: PowerShell + `git` disponible en PATH

---

## 📂 Resultado

Después de ejecutar cualquiera de los scripts, tendrás:

```
portfolio v10/
├── update-repo.js          (este script)
├── update-repo.ps1         (alternativa PowerShell)
├── update-repo-README.md   (este archivo)
└── portafolio_V3_repo/     ← Repositorio clonado aquí
    ├── .git/
    ├── index.html
    ├── assets/
    └── ...
```

---

## ⚙️ Detalles Técnicos

| Parámetro | Valor |
|-----------|-------|
| **URL del Repo** | https://github.com/Zacaryx/portafolio_V3.git |
| **Rama** | `main` |
| **Carpeta de destino** | `portafolio_V3_repo/` (raíz del proyecto) |

---

## 🔄 Automatización

### Agregar a `package.json`:

```json
{
  "scripts": {
    "update-repo": "node update-repo.js"
  }
}
```

Luego ejecutar:
```bash
npm run update-repo
```

---

## ⚠️ Notas Importantes

- Requiere que `git` esté instalado y disponible en el PATH
- Si el repositorio existe, hace `pull` de cambios (no sobrescribe)
- Muestra el estado actual después de cada actualización
- Para clonar de nuevo, borra la carpeta `portafolio_V3_repo/` manualmente

---

## 🐛 Solución de Problemas

### Error: "git: command not found"
→ Instala Git desde https://git-scm.com/

### Error: "Permission denied" (PowerShell)
→ Ejecuta en PowerShell como Administrador o cambia la política:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

**Último actualizado**: 2026-06-02
