# 🚀 Setup SSH + Push a GitHub

## Pasos rápidos:

### 1️⃣ Configurar SSH (UNA SOLA VEZ)

**Haz doble click en:** `setup-ssh.bat`

Esto va a:
- Generar tu SSH key automáticamente
- Abrir el archivo con tu clave pública
- Mostrar instrucciones

### 2️⃣ Agregar la clave a GitHub

Cuando se abra el Notepad:

1. **Copia TODO** (Ctrl+A, Ctrl+C)
2. **Ve a:** https://github.com/settings/keys
3. **Click en:** "New SSH key"
4. **Pega** la clave (Ctrl+V)
5. **Titulo:** "Mi portafolio V10"
6. **Guarda**

### 3️⃣ Hacer Push

**Haz doble click en:** `push-to-github.bat`

Eso es. Ya subirá todo sin pedir contraseña. 🎉

---

## ¿Por qué SSH?

- ✅ Una sola configuración (nunca más pide autenticación)
- ✅ Más seguro que HTTPS
- ✅ Recomendado por GitHub

---

## Después

Cada vez que hagas cambios:

1. Edita lo que quieras
2. Doble click en `push-to-github.bat`
3. Listo ✅

---

## Si algo falla

1. Verifica que `setup-ssh.bat` completó sin errores
2. Confirma que la SSH key está en GitHub (https://github.com/settings/keys)
3. Ejecuta `push-to-github.bat` de nuevo
