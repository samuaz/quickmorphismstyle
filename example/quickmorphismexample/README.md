# QuickMorphism Example Application

Este ejemplo demuestra cómo usar QuickMorphism en tu proyecto con CMake FetchContent.

## 🚀 Cómo Compilar

### Prerequisitos
- Qt 6.2 o superior
- CMake 3.21 o superior
- Conexión a internet (para descargar QuickMorphism)

### Compilación
```bash
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/ruta/a/qt/6.9.x"
make -j$(nproc)
```

### Ejecutar
```bash
# macOS
./appquickmorphismexample.app/Contents/MacOS/appquickmorphismexample

# Linux
./appquickmorphismexample

# Windows
appquickmorphismexample.exe
```

## 🎯 Lo que hace este ejemplo

Este proyecto:
1. **Descarga automáticamente QuickMorphism** desde GitHub usando FetchContent
2. **Usa la rama qt6.9-migration** que tiene soporte completo para Qt6.9
3. **Configura las rutas QML** para Qt Creator y Qt Design Studio
4. **Copia los archivos QML** para que estén disponibles en el editor
5. **Demuestra el uso básico** de componentes neumórficos

## 📁 Estructura del Proyecto

```
quickmorphismexample/
├── CMakeLists.txt          # Configuración FetchContent
├── main.cpp                # Punto de entrada
├── Demo.qml                # Ejemplo de uso de QuickMorphism
├── MainForm.ui.qml         # Formulario UI
├── qtquickcontrols2.conf   # Configuración Qt Controls
└── build/                  # Generado por CMake
    ├── QuickMorphism/      # Componentes copiados para Qt Design Studio
    └── _deps/              # FetchContent cache
        └── quickmorphism-src/
```

## 🎨 Para Qt Design Studio

Después de compilar el proyecto:

1. **Los archivos QML** están disponibles en `build/QuickMorphism/`
2. **Las rutas están configuradas** automáticamente
3. **Los componentes aparecen** en el editor de Qt Design Studio

### Crear proyecto .qmlproject
```qml
import QmlProject 1.3

Project {
    mainFile: "Demo.qml"
    
    QmlFiles {
        directory: "."
    }
    
    QmlFiles {
        directory: "build/QuickMorphism"
    }
    
    importPaths: [
        "build/QuickMorphism",
        "build"
    ]
    
    qt6Project: true
    qdsVersion: "4.6"
}
```

## 💡 Usar en tu Proyecto

### 1. Copia este CMakeLists.txt
```cmake
# Copia la sección FetchContent de este CMakeLists.txt
include(FetchContent)
FetchContent_Declare(
    QuickMorphism
    GIT_REPOSITORY https://github.com/samuaz/quickmorphismstyle.git
    GIT_TAG qt6.9-migration
)
FetchContent_MakeAvailable(QuickMorphism)

# Enlaza la librería
target_link_libraries(tu_app PRIVATE QuickMorphism)
```

### 2. Usa en QML
```qml
import QtQuick
import QtQuick.Controls
import QuickMorphism

ApplicationWindow {
    color: LightTheme.backgroundColor
    
    QuickMorphism.Button {
        text: "Mi Botón Neumórfico"
        anchors.centerIn: parent
    }
    
    StatusBar {
        statusBarColor: LightTheme.statusBarColor
        theme: StatusBar.Light
    }
}
```

## 🔧 Troubleshooting

### "QML module not found (QuickMorphism)"
1. **Compila el proyecto** (para que descargue QuickMorphism)
2. **Verifica que existe** `build/QuickMorphism/qmldir`
3. **Recompila desde cero** si es necesario

### FetchContent muy lento
- **Primera vez**: Descarga completa (puede ser lenta)
- **Siguientes veces**: Usa caché (más rápido)
- **Para limpiar caché**: `rm -rf build/_deps`

### Cambios no aparecen
- QuickMorphism se descarga de GitHub, no cambios locales
- Para desarrollo: consulta el proyecto principal en el directorio padre

## 📋 Ventajas de este Enfoque

✅ **Consistente**: Siempre usa la versión de GitHub  
✅ **Realista**: Como lo usarían otros desarrolladores  
✅ **Automático**: Sin configuración manual de rutas  
✅ **Portable**: Funciona en cualquier máquina  
✅ **Compatible**: Qt Creator y Qt Design Studio  

## 🔗 Enlaces

- **Proyecto principal**: `../..` (directorio padre)
- **Documentación**: `../README.md`
- **Guía FetchContent**: `../README_FETCHCONTENT.md`
- **Repositorio**: https://github.com/samuaz/quickmorphismstyle