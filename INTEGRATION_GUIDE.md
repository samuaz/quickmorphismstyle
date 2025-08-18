# QuickMorphism Integration Guide

QuickMorphismStyle para Qt6.9 ofrece dos formas de integración:

## 🎨 Enfoque 1: Estilo Simple (Recomendado para la mayoría de casos)

Usa QuickMorphism como un estilo oficial de Qt Quick Controls:

### C++ Setup
```cpp
#include <QQuickStyle>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    
    // Establece QuickMorphism como el estilo global
    QQuickStyle::setStyle("QuickMorphism");
    
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    
    return app.exec();
}
```

### QML Usage
```qml
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    
    // Todos los controles automáticamente usan el estilo neumórfico
    Column {
        anchors.centerIn: parent
        spacing: 20
        
        Button {
            text: "Neumorphic Button"
        }
        
        TextField {
            placeholderText: "Neumorphic TextField"
        }
        
        Switch {
            text: "Neumorphic Switch"
        }
    }
}
```

### Características:
- ✅ **Fácil de usar**: Solo una línea en C++
- ✅ **Automático**: Todos los controles Qt Quick Controls usan neumorfismo
- ✅ **Compatible**: Funciona con cualquier aplicación Qt Quick
- ✅ **Sin dependencias**: No requiere importar módulos adicionales
- ⚠️ **Limitado**: Usa tema Light fijo (por ahora)

---

## 🛠 Enfoque 2: Integración Avanzada con Temas Personalizados

Para control completo sobre temas y personalización:

### CMakeLists.txt
```cmake
# Agrega QuickMorphism como dependencia
add_subdirectory(path/to/quickmorphismstyle)
target_link_libraries(your_app PRIVATE QuickMorphism)
```

### C++ Setup
```cpp
#include <QuickMorphismStyle/quickmorphism.h>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    
    QQmlApplicationEngine engine;
    
    // Inicializa QuickMorphism (registra tipos QML)
    QuickMorphism::init(engine);
    
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    
    return app.exec();
}
```

### QML Usage
```qml
import QtQuick
import QtQuick.Controls
import QuickMorphism

ApplicationWindow {
    visible: true
    width: 400
    height: 600
    
    // Temas personalizados
    QuickMorphismTheme {
        id: customLightTheme
        style: QuickMorphismStyle.LIGHT
        backgroundColor: "#E0E5EC"
        primaryTextColor: "#666666"
        accentColor: "#7CB342"
        topShadowColor: "#FFFFFF"
        bottonShadowColor: "#A3B1C6"
        // ... más propiedades personalizables
    }
    
    QuickMorphismTheme {
        id: customDarkTheme
        style: QuickMorphismStyle.DARK
        backgroundColor: "#2b2b2b"
        primaryTextColor: "#ffffff"
        accentColor: "#7CB342"
        topShadowColor: "#404040"
        bottonShadowColor: "#1a1a1a"
        // ... más propiedades personalizables
    }
    
    // Inicializador global de temas
    QuickMorphismUI {
        id: quickMorphismUI
        theme: isDarkMode ? customDarkTheme : customLightTheme
    }
    
    property bool isDarkMode: false
    color: quickMorphismUI.theme.backgroundColor
    
    Column {
        anchors.centerIn: parent
        spacing: 20
        
        Switch {
            text: "Dark Mode"
            onCheckedChanged: {
                // Cambio dinámico de tema
                isDarkMode = checked
                // Todos los controles se actualizan automáticamente
            }
        }
        
        // Componentes QuickMorphism personalizados
        QuickMorphism.Button {
            text: "Custom Neumorphic Button"
        }
        
        QuickMorphism.TextField {
            placeholderText: "Custom TextField"
        }
    }
}
```

### Características:
- ✅ **Control total**: Personaliza colores, sombras, y efectos
- ✅ **Temas dinámicos**: Cambia entre Light/Dark en tiempo real
- ✅ **Extensible**: Crea tus propios temas personalizados
- ✅ **Componentes nativos**: Acceso a todos los componentes QuickMorphism
- ✅ **C++ Integration**: Control programático desde C++
- ⚠️ **Más complejo**: Requiere configuración adicional

---

## 🎯 ¿Cuál elegir?

### Usa **Enfoque 1** si:
- Quieres agregar neumorfismo rápidamente a una app existente
- No necesitas personalización avanzada de temas
- Prefieres simplicidad sobre flexibilidad
- Solo necesitas el tema Light

### Usa **Enfoque 2** si:
- Necesitas temas Light y Dark
- Quieres colores personalizados
- Planeas crear múltiples temas
- Necesitas cambios dinámicos de tema
- Quieres acceso completo al sistema QuickMorphism

---

## 📚 Componentes Disponibles

Ambos enfoques soportan estos controles neumórficos:

- **ApplicationWindow** - Ventana con fondo neumórfico
- **Button** - Botón con efectos de sombra convexa/cóncava
- **TextField** - Campo de texto con bordes neumórficos
- **Switch** - Interruptor con animaciones suaves
- **CheckBox** - Checkbox con efectos de presión
- **Page** - Página con fondo neumórfico

---

## 🚀 Próximas Características

- [ ] Soporte para tema dinámico en Enfoque 1
- [ ] Más controles neumórficos (Slider, ProgressBar, etc.)
- [ ] Temas predefinidos adicionales
- [ ] Configuración automática de Dark/Light basada en sistema