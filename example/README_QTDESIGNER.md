# Qt Design Studio Setup para QuickMorphism

## 🎨 Configuración para Desarrolladores

### Prerequisitos
1. Tener Qt Design Studio 4.6+ instalado
2. Haber compilado el proyecto QuickMorphism al menos una vez
3. CMake configurado correctamente

### ⚠️ Error de Archivos .qtds Obsoletos

Si ves el error "No valid settings file could be found", significa que hay archivos `.qtds` de versiones anteriores incompatibles. Para solucionarlo:

1. **Elimina archivos .qtds antiguos:**
   ```bash
   find /ruta/a/quickmorphismstyle/example -name "*.qtds" -delete
   ```

2. **Abre el proyecto limpio:**
   - Abre Qt Design Studio
   - Ve a File → Open Project
   - Selecciona `QuickMorphismStudio.qmlproject`
   - Qt Design Studio creará nuevos archivos de configuración compatibles

### 🎯 Archivo Principal

El proyecto ahora usa `QuickMorphismDemo.qml` como archivo principal, que contiene:
- Un ejemplo simple de estilo neumórfico sin dependencias complejas
- Compatible con Qt Design Studio desde el inicio
- Fácil de modificar y extender

### Configuración de Rutas QML

El archivo `quickmorphism.qmlproject` usa rutas relativas para que funcione en cualquier sistema:

```qml
importPaths: [ 
    "quickmorphismexample",    // Archivos del ejemplo
    "../QuickMorphism",        // Componentes QML principales
    "../../QuickMorphism",     // Ruta alternativa
    "../build",                // Archivos generados por CMake
    "build"                    // Build local
]
```

### Configuración Manual (si es necesario)

Si Qt Design Studio no encuentra los módulos, puedes agregar manualmente:

1. **Abre Qt Design Studio**
2. **Ve a Edit → Preferences → Qt Quick → QML/JS Editing**
3. **Agrega estas rutas en "Path to QML sources":**
   ```
   /ruta/a/tu/proyecto/quickmorphismstyle/QuickMorphism
   /ruta/a/tu/instalacion/Qt/6.9.x/macos/qml  (o linux/windows según tu OS)
   ```

### Variables de Entorno (Alternativa)

Puedes configurar la variable `QML2_IMPORT_PATH`:

```bash
# macOS/Linux
export QML2_IMPORT_PATH="/ruta/a/quickmorphismstyle/QuickMorphism:$QML2_IMPORT_PATH"

# Windows
set QML2_IMPORT_PATH=C:\ruta\a\quickmorphismstyle\QuickMorphism;%QML2_IMPORT_PATH%
```

### Verificación

Para verificar que funciona:

1. Abre `quickmorphismexample/demo.qml` en Qt Design Studio
2. Deberías ver los componentes QuickMorphism en el panel de componentes
3. El import `import QuickMorphism` no debería mostrar errores

### Troubleshooting

Si los componentes no aparecen:

1. **Compila el proyecto primero:**
   ```bash
   cd quickmorphismstyle
   mkdir build && cd build
   cmake .. -DCMAKE_PREFIX_PATH="$QT_DIR"
   make
   ```

2. **Verifica que existe el archivo qmldir:**
   ```bash
   ls QuickMorphism/qmldir
   ```

3. **Comprueba que los componentes están registrados:**
   ```bash
   grep -r "QuickMorphismStyle" build/
   ```