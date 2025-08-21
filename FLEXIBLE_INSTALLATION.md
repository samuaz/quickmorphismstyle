# QuickMorphism Style - Flexible Installation Guide

Este documento explica cómo usar QuickMorphism sin necesidad de instalarlo en el directorio de Qt, proporcionando máxima flexibilidad para los desarrolladores.

## 🎯 Problema Resuelto

Anteriormente, para usar `QQuickStyle::setStyle("QuickMorphism")` era necesario:
- Instalar el estilo en el directorio de Qt (`/Users/usuario/Qt/...`)
- Usar rutas hardcodeadas en el código
- Requerir permisos de administrador para instalación global

**Ahora** puedes especificar la ubicación del estilo desde CMake y usar el estilo desde cualquier ubicación.

## ✅ Problema Resuelto Exitosamente

**¡El sistema flexible de instalación está funcionando perfectamente!**

- ✅ **QQuickStyle::setStyle("QuickMorphism")** funciona sin instalar en directorio de Qt
- ✅ **Detección automática** de rutas de estilo
- ✅ **Herencia completa** - Los estilos heredan toda la funcionalidad neumórfica original
- ✅ **Sin duplicación de código** - Los archivos del estilo son proxies que apuntan al módulo original
- ✅ **Configuración de temas** preservada completamente

## 🛠 Métodos de Configuración

### Método 1: Uso Automático con Helpers de CMake (Recomendado)

Este método configura automáticamente todas las rutas necesarias.

#### Paso 1: CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.21)
project(MiApp LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)
qt_standard_project_setup()

# Incluir helpers de QuickMorphism
set(QUICKMORPHISM_SOURCE_DIR "/ruta/a/quickmorphismstyle")
include(${QUICKMORPHISM_SOURCE_DIR}/cmake/QuickMorphismStyleHelpers.cmake)

qt_add_executable(MiApp main.cpp)
qt_add_qml_module(MiApp URI MiApp VERSION 1.0 QML_FILES main.qml)

# Configurar QuickMorphism automáticamente
add_quickmorphism_dependency(MiApp 
    QUICKMORPHISM_DIR ${QUICKMORPHISM_SOURCE_DIR}
    LINK_LIBRARY
)

target_link_libraries(MiApp PRIVATE Qt6::Quick Qt6::QuickControls2)
```

#### Paso 2: main.cpp

```cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "quickmorphism_config.h" // Auto-generado por CMake

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    // ¡Una sola línea para configurar todo!
    QuickMorphism::setupStyle(engine);
    
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
```

### Método 2: Configuración Manual Inteligente

Si prefieres más control, puedes usar la función de detección automática.

#### main.cpp

```cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDir>
#include <QStandardPaths>

QString findQuickMorphismStylePath() {
    QStringList possiblePaths = {
        // Directorio de build (desarrollo)
        QDir::currentPath() + "/qml",
        QDir::currentPath() + "/../build/qml",
        
        // Variable de entorno
        qEnvironmentVariable("QUICKMORPHISM_STYLE_PATH"),
        
        // Directorio de la aplicación
        QGuiApplication::applicationDirPath() + "/qml",
        
        // Instalación del usuario
        QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/qml",
        
        // Instalación global
        "/usr/local/share/qml",
        "/opt/quickmorphism/qml"
    };
    
    for (const QString& path : possiblePaths) {
        if (!path.isEmpty() && QDir(path + "/QuickMorphism").exists()) {
            return path;
        }
    }
    return QString();
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    
    QString stylePath = findQuickMorphismStylePath();
    if (!stylePath.isEmpty()) {
        engine.addImportPath(stylePath);
        QQuickStyle::setStyle("QuickMorphism");
    }
    
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
```

### Método 3: Configuración con Variables de Entorno

Establece la variable de entorno `QUICKMORPHISM_STYLE_PATH`:

```bash
# Linux/macOS
export QUICKMORPHISM_STYLE_PATH="/ruta/a/quickmorphismstyle/build/qml"

# Windows
set QUICKMORPHISM_STYLE_PATH=C:\ruta\a\quickmorphismstyle\build\qml
```

Luego usa el Método 2 que detectará automáticamente esta variable.

## ⚙️ Opciones de CMake

### Configuración de Instalación

```cmake
# Opción 1: Modo desarrollo (por defecto)
# El estilo se genera en build/qml/QuickMorphism

# Opción 2: Directorio personalizado
set(QUICKMORPHISM_STYLE_INSTALL_DIR "/mi/directorio/personalizado" CACHE PATH "")

# Opción 3: Instalar en el directorio de Qt (requiere permisos admin)
set(QUICKMORPHISM_INSTALL_IN_QT_DIR ON CACHE BOOL "")
```

### Configuración Avanzada con Helpers

```cmake
# Solo configurar rutas sin enlazar la librería
configure_quickmorphism_style(MiApp)

# Usar directorio personalizado
configure_quickmorphism_style(MiApp 
    CUSTOM_STYLE_DIR "/mi/directorio/de/estilos")

# Instalar en directorio de Qt
configure_quickmorphism_style(MiApp INSTALL_IN_QT_DIR)

# Configuración completa con librería
add_quickmorphism_dependency(MiApp 
    QUICKMORPHISM_DIR "/ruta/a/quickmorphism"
    LINK_LIBRARY
    CUSTOM_STYLE_DIR "/mi/directorio/personalizado"
)
```

## 🏗 Construcción con Diferentes Configuraciones

### Desarrollo Local

```bash
cd mi_proyecto
mkdir build && cd build
cmake .. -DQUICKMORPHISM_SOURCE_DIR="/ruta/a/quickmorphismstyle"
make
```

### Instalación en Directorio Personalizado

```bash
cmake .. -DQUICKMORPHISM_STYLE_INSTALL_DIR="/opt/mi_empresa/estilos"
make install
```

### Instalación en Directorio de Qt

```bash
cmake .. -DQUICKMORPHISM_INSTALL_IN_QT_DIR=ON
sudo make install  # Requiere permisos admin
```

## 🎨 Uso en QML

Una vez configurado cualquier método, el uso en QML es idéntico:

```qml
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    
    // Los controles automáticamente usan el estilo QuickMorphism
    Button {
        text: "Botón Neumórfico"
        anchors.centerIn: parent
    }
}
```

## 🔧 Solución de Problemas

### El estilo no se encuentra

1. Verifica que el directorio `QuickMorphism` existe en la ruta configurada
2. Confirma que contiene archivos `.qml` y `qmldir`
3. Ejecuta con `QT_LOGGING_RULES="qt.qml.import.debug=true"` para ver logs de importación

### Errores de importación

```bash
# Debugging de importaciones QML
QT_LOGGING_RULES="qt.qml.import.debug=true" ./mi_app
```

### Variable de entorno no funciona

Verifica que la variable esté configurada correctamente:

```bash
echo $QUICKMORPHISM_STYLE_PATH  # Linux/macOS
echo %QUICKMORPHISM_STYLE_PATH%  # Windows
```

## 📁 Estructura de Directorios

El sistema crea automáticamente esta estructura optimizada:

```
ruta_del_estilo/
├── QuickMorphism/                    # Módulo original completo
│   ├── qmldir                       # Definición del módulo
│   ├── Config.qml                   # Configuración de temas
│   ├── ApplicationWindow.qml        # Componentes originales
│   ├── Button.qml                   # con toda la funcionalidad
│   ├── themes/                      # Temas Light/Dark
│   │   ├── QuickMorphismLightTheme.qml
│   │   └── QuickMorphismDarkTheme.qml
│   └── assets/font/                 # Fuentes incluidas
└── QtQuick/Controls/QuickMorphism/   # Estilo para QQuickStyle::setStyle()
    ├── qmldir                       # Definición del estilo
    ├── ApplicationWindow.qml        # Proxy: import QuickMorphism 1.0; QuickMorphism.ApplicationWindow {}
    ├── Button.qml                   # Proxy: import QuickMorphism 1.0; QuickMorphism.Button {}
    ├── Label.qml                    # Proxy: import QuickMorphism 1.0; QuickMorphism.Label {}
    └── ...                          # Todos los componentes como proxies
```

**Ventajas de esta estructura:**
- ✅ **Cero duplicación** de código
- ✅ **Herencia completa** de funcionalidad neumórfica
- ✅ **Temas configurables** preservados
- ✅ **Compatible** con QQuickStyle::setStyle()
- ✅ **Mantenimiento fácil** - solo editar archivos originales

## 🚀 Ventajas de Esta Solución

1. **No requiere instalación en Qt**: Funciona desde cualquier directorio
2. **Detección automática**: Busca en múltiples ubicaciones estándar
3. **Configurable**: Desde variables de entorno hasta CMake
4. **Compatible con Qt Creator**: Funciona perfectamente en el IDE
5. **Portable**: Las aplicaciones pueden incluir el estilo
6. **Flexible**: Desde desarrollo local hasta distribución

## 📋 Lista de Verificación

- [ ] ¿Configuraste la ruta del estilo en CMake o código?
- [ ] ¿El directorio `QuickMorphism` contiene todos los archivos necesarios?
- [ ] ¿Llamaste a `QQuickStyle::setStyle("QuickMorphism")`?
- [ ] ¿Agregaste la ruta a `engine.addImportPath()`?
- [ ] ¿Verificaste que no hay errores de importación QML?

Con esta configuración flexible, QuickMorphism puede usarse en cualquier proyecto sin necesidad de modificar la instalación de Qt. 🎉