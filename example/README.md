# QuickMorphism Style - Ejemplo Qt6.9

Este directorio contiene un proyecto de ejemplo que demuestra cómo usar QuickMorphismStyle en tus aplicaciones Qt6.9.

## 📁 Estructura

```
example/
├── quickmorphismexample/
│   ├── CMakeLists.txt                 # Configuración principal (usa add_subdirectory)
│   ├── CMakeLists_fetchcontent.txt   # Alternativa usando FetchContent desde Git
│   ├── CMakeLists_simple.txt         # Versión simple con archivos incluidos directamente
│   ├── main.cpp                      # Aplicación principal
│   ├── demo.qml                      # Interfaz de demostración
│   └── MainForm.ui.qml              # Formulario UI
└── README.md                         # Este archivo
```

## 🔧 Métodos de Integración

### Método 1: Dependencia Local (Recomendado para desarrollo)

Usa `CMakeLists.txt` que incluye QuickMorphism como subdirectorio:

```bash
cd quickmorphismexample
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/ruta/a/Qt/6.9.1/macos"
make
```

### Método 2: FetchContent desde Git

Para proyectos que quieren obtener QuickMorphism automáticamente:

```bash
cd quickmorphismexample
mkdir build && cd build
cmake .. -f ../CMakeLists_fetchcontent.txt -DCMAKE_PREFIX_PATH="/ruta/a/Qt/6.9.1/macos"
make
```

### Método 3: Archivos Incluidos Directamente

Para proyectos que prefieren incluir los archivos fuente directamente:

```bash
cd quickmorphismexample
mkdir build && cd build
cmake .. -f ../CMakeLists_simple.txt -DCMAKE_PREFIX_PATH="/ruta/a/Qt/6.9.1/macos"
make
```

## 🚀 Uso en tus Proyectos

### 1. Usando add_subdirectory (Desarrollo local)

```cmake
# En tu CMakeLists.txt
add_subdirectory(path/to/quickmorphismstyle)

target_link_libraries(tu_app PRIVATE QuickMorphism)
```

### 2. Usando FetchContent (Producción)

```cmake
include(FetchContent)

FetchContent_Declare(
    QuickMorphism
    GIT_REPOSITORY https://github.com/samuaz/quickmorphismstyle.git
    GIT_TAG qt6.9-migration
)

FetchContent_MakeAvailable(QuickMorphism)
target_link_libraries(tu_app PRIVATE QuickMorphism)
```

### 3. Usando find_package (Instalación del sistema)

```cmake
find_package(QuickMorphism REQUIRED)
target_link_libraries(tu_app PRIVATE QuickMorphism::QuickMorphism)
```

## 📝 Código QML

En tus archivos QML:

```qml
import QtQuick
import QtQuick.Controls
import QuickMorphism

ApplicationWindow {
    id: window
    visible: true
    
    QuickMorphism.Button {
        text: "Mi botón neumorphic"
        anchors.centerIn: parent
    }
    
    StatusBar {
        statusBarColor: "#E0E5EC"
        theme: StatusBar.Light
    }
}
```

## 🎨 Temas Disponibles

- `DefaultQuickMorphismLightTheme` - Tema claro predeterminado
- `DefaultQuickMorphismDarkTheme` - Tema oscuro predeterminado
- Crear temas personalizados con `QuickMorphismTheme`

## 📱 Componentes Disponibles

- **ApplicationWindow** - Ventana principal con estilo neumorphic
- **Button** - Botón con efectos de sombra
- **TextField** - Campo de texto estilizado
- **CheckBox** - Casilla de verificación
- **Switch** - Interruptor
- **Label** - Etiqueta de texto
- **Page** - Página contenedora
- **ToolBar** - Barra de herramientas
- **SnackBar** - Notificaciones tipo snackbar
- **RoundImage** - Imagen circular
- **ScrollableContainer** - Contenedor desplazable
- **StatusBar** - Control de barra de estado del sistema

## 🛠 Requisitos

- Qt 6.2 o superior (recomendado Qt 6.9.1)
- CMake 3.21 o superior
- Compilador C++17

## 📄 Configuración para Conan (Futuro)

Para uso futuro con Conan, el proyecto incluirá un `conanfile.py`:

```python
# Ejemplo futuro de uso con Conan
[requires]
quickmorphism/1.0@samuaz/stable

[generators]
CMakeDeps
CMakeToolchain
```

## 🐛 Solución de Problemas

### Error de MOC en compilación

Si encuentras errores relacionados con MOC durante la compilación, usa el método 3 (CMakeLists_simple.txt) que incluye los archivos directamente.

### QML import no encontrado

Asegúrate de que `QML_IMPORT_PATH` esté configurado correctamente en tu CMakeLists.txt:

```cmake
set(QML_IMPORT_PATH "${CMAKE_BINARY_DIR}" CACHE STRING "" FORCE)
```