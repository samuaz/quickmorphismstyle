# Usando QuickMorphism con FetchContent

## 🚀 Configuración para Nuevos Proyectos

Para usar QuickMorphism en tu proyecto con CMake FetchContent, sigue estos pasos:

### 1. Configuración de CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.21)
project(tu_proyecto VERSION 1.0.0 LANGUAGES CXX)

# Configuración Qt6
find_package(Qt6 6.2 REQUIRED COMPONENTS Core Quick Gui Qml QuickControls2)
qt_standard_project_setup()

# ===================================
# FetchContent para QuickMorphism
# ===================================
include(FetchContent)

FetchContent_Declare(
    QuickMorphism
    GIT_REPOSITORY https://github.com/samuaz/quickmorphismstyle.git
    GIT_TAG qt6.9-migration  # Rama de desarrollo actual con Qt6.9
    # Para producción usar: GIT_TAG v1.0.0  # O el tag estable
)

FetchContent_MakeAvailable(QuickMorphism)

# Crear tu ejecutable
qt_add_executable(tu_app main.cpp)

# Agregar módulo QML de tu proyecto
qt_add_qml_module(tu_app
    URI tu_proyecto
    VERSION ${PROJECT_VERSION}
    QML_FILES main.qml
)

# Enlazar librerías
target_link_libraries(tu_app PRIVATE
    Qt6::Core Qt6::Quick Qt6::Gui Qt6::Qml Qt6::QuickControls2
    QuickMorphism  # ← Esta es la librería de QuickMorphism
)

# ===================================
# Configuración para Qt Design Studio
# ===================================

# Obtener información de FetchContent
FetchContent_GetProperties(QuickMorphism)
if(NOT quickmorphism_POPULATED)
    FetchContent_Populate(QuickMorphism)
endif()

# Configurar rutas de importación QML
set(QML_IMPORT_PATH 
    "${quickmorphism_SOURCE_DIR}/QuickMorphism"  # Archivos QML fuente
    "${CMAKE_CURRENT_BINARY_DIR}"                # Build actual
    CACHE STRING "Qt Creator import paths" FORCE
)

# Copiar archivos QML para Qt Design Studio
add_custom_command(TARGET tu_app POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${quickmorphism_SOURCE_DIR}/QuickMorphism"
        "${CMAKE_CURRENT_BINARY_DIR}/QuickMorphism"
    COMMENT "Copying QuickMorphism QML files for Qt Design Studio"
)
```

### 2. Usando en QML

```qml
import QtQuick
import QtQuick.Controls
import QuickMorphism  // ← Import del módulo

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    
    // Usar tema de QuickMorphism
    color: LightTheme.backgroundColor
    
    Column {
        anchors.centerIn: parent
        spacing: 20
        
        QuickMorphism.Button {
            text: "Mi Botón Neumórfico"
        }
        
        QuickMorphism.TextField {
            placeholderText: "Escribe algo..."
        }
    }
    
    StatusBar {
        statusBarColor: LightTheme.statusBarColor
        theme: StatusBar.Light
    }
}
```

### 3. Configuración para Qt Design Studio

#### Crear archivo `.qmlproject`

```qml
import QmlProject 1.3

Project {
    mainFile: "main.qml"
    
    QmlFiles {
        directory: "."
    }
    
    QmlFiles {
        directory: "build/QuickMorphism"
    }
    
    Files {
        filter: "qmldir"
        directory: "build/QuickMorphism"
    }
    
    importPaths: [
        "build/QuickMorphism",  // Archivos copiados por CMake
        "build"                 // Build output
    ]
    
    qt6Project: true
    qdsVersion: "4.6"
}
```

### 4. Compilación

```bash
# Crear y configurar build
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="ruta/a/qt/6.9.x"

# Compilar
make -j$(nproc)  # Linux/macOS
# o cmake --build . --parallel  # Cross-platform
```

## 🎯 Ventajas de FetchContent

### ✅ Para Desarrolladores
- **Automático**: Descarga automáticamente QuickMorphism
- **Versionado**: Puedes especificar tags/branches específicos
- **Sin dependencias manuales**: No necesitas clonar repos manualmente
- **Actualizable**: Fácil cambiar de versión

### ✅ Para Qt Design Studio
- **Componentes disponibles**: Los componentes QuickMorphism aparecen en el editor
- **Autocompletado**: Funciona el autocompletado de propiedades
- **Vista previa**: Puedes ver los componentes en tiempo real
- **Sin configuración manual**: Las rutas se configuran automáticamente

### ✅ Para CI/CD
- **Reproducible**: Builds consistentes en cualquier máquina
- **Sin repositorios anidados**: No necesitas git submodules
- **Cache inteligente**: CMake cachea las descargas

## 🔧 Troubleshooting

### "QML module not found (QuickMorphism)"

1. **Verifica que compilaste el proyecto:**
   ```bash
   make -j$(nproc)
   ```

2. **Verifica que existe el directorio copiado:**
   ```bash
   ls build/QuickMorphism/qmldir
   ```

3. **Verifica CMakeCache.txt:**
   ```bash
   grep QML_IMPORT_PATH build/CMakeCache.txt
   ```

### Qt Design Studio no encuentra componentes

1. **Compila el proyecto primero**
2. **Verifica el archivo .qmlproject**
3. **Abre el archivo principal desde Qt Design Studio**

### Actualizar QuickMorphism

```bash
# Limpiar cache de FetchContent
rm -rf build/_deps/quickmorphism-*
# Recompilar
cmake --build build
```

## 📁 Estructura del Proyecto

```
tu_proyecto/
├── CMakeLists.txt           # Con FetchContent configurado
├── main.cpp                 # Archivo principal
├── main.qml                 # QML principal  
├── proyecto.qmlproject      # Para Qt Design Studio
└── build/                   # Generado por CMake
    ├── QuickMorphism/       # Componentes copiados
    │   ├── qmldir
    │   ├── Button.qml
    │   └── ...
    └── _deps/               # FetchContent cache
        └── quickmorphism-src/
```

## 🚀 Para Desarrollo vs Producción

### Desarrollo (rama qt6.9-migration):
```cmake
FetchContent_Declare(
    QuickMorphism
    GIT_REPOSITORY https://github.com/samuaz/quickmorphismstyle.git
    GIT_TAG qt6.9-migration  # Últimos cambios de desarrollo
)
```

### Producción (tag estable):
```cmake
FetchContent_Declare(
    QuickMorphism
    GIT_REPOSITORY https://github.com/samuaz/quickmorphismstyle.git
    GIT_TAG v1.0.0  # Tag estable específico
)
```

### Híbrido (local + FetchContent):
Consulta `CMakeLists_local_dev.txt` para una configuración que usa desarrollo local cuando está disponible y FetchContent como fallback.

## 🎨 Ejemplo Completo

Consulta el directorio `example/quickmorphismexample/` para ver:
- **CMakeLists.txt**: Configuración local de desarrollo  
- **CMakeLists_fetchcontent_new.txt**: Configuración con FetchContent
- **Demo.qml**: Ejemplo de uso completo
- **README.md**: Guía de integración