# 🚀 Cómo Usar QuickMorphism Example

## 📋 Configuraciones Disponibles

El directorio `example/quickmorphismexample/` tiene varias configuraciones de CMakeLists.txt para diferentes escenarios:

| Archivo | Propósito | Cuándo usarlo |
|---------|-----------|---------------|
| `CMakeLists.txt` | Desarrollo local actual | Cuando trabajas en el repo completo |
| `CMakeLists_fetchcontent_new.txt` | FetchContent con rama dev | Para probar FetchContent con qt6.9-migration |
| `CMakeLists_local_dev.txt` | Híbrido inteligente | Para distribuir a otros desarrolladores |
| `CMakeLists_simple.txt` | Inclusión directa | Para proyectos que incluyen sources directamente |

## 🛠️ Método 1: Desarrollo Local (Actual)

**Para tu desarrollo diario en el repo:**

```bash
cd quickmorphismstyle/example/quickmorphismexample
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/ruta/a/qt/6.9.1"
make -j$(nproc)
./appquickmorphismexample.app/Contents/MacOS/appquickmorphismexample
```

✅ **Ventajas:**
- Cambios en QuickMorphism se reflejan inmediatamente
- No requiere descargas de internet
- Más rápido para desarrollo iterativo

## 🌐 Método 2: FetchContent (Rama Desarrollo)

**Para probar que FetchContent funciona con qt6.9-migration:**

```bash
cd quickmorphismstyle/example/quickmorphismexample

# Cambiar a configuración FetchContent
cp CMakeLists.txt CMakeLists_backup.txt
cp CMakeLists_fetchcontent_new.txt CMakeLists.txt

# Compilar
mkdir build_fetch && cd build_fetch
cmake .. -DCMAKE_PREFIX_PATH="/ruta/a/qt/6.9.1"
make -j$(nproc)

# Restaurar configuración original
cd ..
mv CMakeLists_backup.txt CMakeLists.txt
mv CMakeLists.txt CMakeLists_fetchcontent_new.txt
```

✅ **Ventajas:**
- Simula cómo otros desarrolladores usarán la librería
- Descarga automáticamente desde GitHub
- Usa la rama qt6.9-migration

⚠️ **Nota:** Requiere conexión a internet y puede ser más lento

## 🎯 Método 3: Híbrido (Recomendado para Distribución)

**Para otros desarrolladores que clonen tu repo:**

```bash
cd quickmorphismstyle/example/quickmorphismexample

# Usar configuración híbrida
cp CMakeLists.txt CMakeLists_backup.txt
cp CMakeLists_local_dev.txt CMakeLists.txt

# Compilar (detecta automáticamente local vs FetchContent)
mkdir build_hybrid && cd build_hybrid
cmake .. -DCMAKE_PREFIX_PATH="/ruta/a/qt/6.9.1"
make -j$(nproc)
```

✅ **Ventajas:**
- **Si hay repo local:** Usa add_subdirectory (rápido)
- **Si no hay repo local:** Usa FetchContent automáticamente
- Perfecto para README de otros desarrolladores

## 📱 Método 4: Para Proyectos Nuevos

**Si alguien quiere usar QuickMorphism en su proyecto nuevo:**

### Paso 1: Crear proyecto
```bash
mkdir mi_proyecto && cd mi_proyecto
```

### Paso 2: Crear CMakeLists.txt
```cmake
cmake_minimum_required(VERSION 3.21)
project(mi_proyecto VERSION 1.0.0 LANGUAGES CXX)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Quick Gui Qml QuickControls2)
qt_standard_project_setup()

# FetchContent para QuickMorphism
include(FetchContent)
FetchContent_Declare(
    QuickMorphism
    GIT_REPOSITORY https://github.com/samuaz/quickmorphismstyle.git
    GIT_TAG qt6.9-migration  # Para desarrollo
    # GIT_TAG v1.0.0         # Para producción
)
FetchContent_MakeAvailable(QuickMorphism)

# Tu aplicación
qt_add_executable(mi_app main.cpp)
qt_add_qml_module(mi_app URI mi_proyecto QML_FILES main.qml)

target_link_libraries(mi_app PRIVATE
    Qt6::Core Qt6::Quick Qt6::Gui Qt6::Qml Qt6::QuickControls2
    QuickMorphism
)

# Para Qt Design Studio
FetchContent_GetProperties(QuickMorphism)
add_custom_command(TARGET mi_app POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${quickmorphism_SOURCE_DIR}/QuickMorphism"
        "${CMAKE_CURRENT_BINARY_DIR}/QuickMorphism"
)
```

### Paso 3: Crear main.qml
```qml
import QtQuick
import QtQuick.Controls
import QuickMorphism

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    
    color: LightTheme.backgroundColor
    
    QuickMorphism.Button {
        text: "Mi Botón Neumórfico"
        anchors.centerIn: parent
    }
}
```

### Paso 4: Compilar
```bash
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/ruta/a/qt/6.9.1"
make -j$(nproc)
```

## 🎨 Para Qt Design Studio

### Configurar .qmlproject
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
    
    importPaths: [
        "build/QuickMorphism",
        "build"
    ]
    
    qt6Project: true
    qdsVersion: "4.6"
}
```

### Usar en Qt Design Studio
1. **Compila tu proyecto primero** (para que copie los QML)
2. **Abre Qt Design Studio**
3. **File → Open Project → tu_proyecto.qmlproject**
4. **Los componentes QuickMorphism aparecerán disponibles**

## 🔧 Troubleshooting

### "QML module not found (QuickMorphism)"

**Solución 1: Verifica que compilaste**
```bash
ls build/QuickMorphism/qmldir  # Debe existir
```

**Solución 2: Verifica QML_IMPORT_PATH**
```bash
grep QML_IMPORT_PATH build/CMakeCache.txt
```

**Solución 3: Recompila desde cero**
```bash
rm -rf build && mkdir build && cd build
cmake .. && make
```

### FetchContent muy lento

**Usar caché local:**
```bash
# Primera vez (lenta)
cmake ..

# Siguientes veces (rápida - usa caché)
make clean && make
```

### Cambiar entre configuraciones

**Script helper:**
```bash
#!/bin/bash
# switch_config.sh

case $1 in
    "local")
        cp CMakeLists_backup.txt CMakeLists.txt 2>/dev/null || echo "Ya usando local"
        ;;
    "fetch")
        cp CMakeLists.txt CMakeLists_backup.txt
        cp CMakeLists_fetchcontent_new.txt CMakeLists.txt
        ;;
    "hybrid")
        cp CMakeLists.txt CMakeLists_backup.txt
        cp CMakeLists_local_dev.txt CMakeLists.txt
        ;;
    *)
        echo "Uso: $0 {local|fetch|hybrid}"
        ;;
esac
```

**Usar:**
```bash
chmod +x switch_config.sh
./switch_config.sh fetch    # Cambiar a FetchContent
./switch_config.sh local    # Volver a desarrollo local
```

## 📋 Resumen Rápido

| Escenario | Comando Rápido |
|-----------|----------------|
| Desarrollo diario | `cmake .. && make` |
| Probar FetchContent | `cp CMakeLists_fetchcontent_new.txt CMakeLists.txt && cmake .. && make` |
| Distribuir ejemplo | `cp CMakeLists_local_dev.txt CMakeLists.txt` |
| Proyecto nuevo | Copiar template de arriba |
| Qt Design Studio | Compilar primero, luego abrir .qmlproject |