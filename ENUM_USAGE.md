# Uso de Enums en QuickMorphism

## 🎯 Enums Disponibles

QuickMorphism proporciona enums para facilitar el uso y mejorar la legibilidad del código:

### QuickMorphismStyle
```qml
QuickMorphismStyle.LIGHT    // = 0
QuickMorphismStyle.DARK     // = 1  
QuickMorphismStyle.STYLE_FILLED // = 2
```

## ✅ Formas Correctas de Usar los Enums

### 1. En Temas Personalizados
```qml
import QtQuick
import QuickMorphism

QuickMorphismTheme {
    id: myTheme
    style: QuickMorphismStyle.DARK  // ✅ Correcto
    backgroundColor: "#2b2b2b"
    primaryTextColor: "#ffffff"
    // ... otras propiedades
}
```

### 2. En Comparaciones
```qml
Text {
    text: {
        if (currentTheme.style === QuickMorphismStyle.LIGHT) {
            return "Tema Claro Activo"
        } else if (currentTheme.style === QuickMorphismStyle.DARK) {
            return "Tema Oscuro Activo"
        }
        return "Tema Desconocido"
    }
    color: currentTheme.style === QuickMorphismStyle.LIGHT ? "#333" : "#fff"
}
```

### 3. En Condiciones
```qml
Button {
    text: "Mi Botón"
    enabled: appTheme.style === QuickMorphismStyle.LIGHT
    visible: userPreferences.style !== QuickMorphismStyle.DARK
}
```

### 4. Con StatusBar
```qml
StatusBar {
    theme: currentStyle === QuickMorphismStyle.LIGHT ? StatusBar.Light : StatusBar.Dark
    statusBarColor: backgroundColors[currentStyle]
}
```

## ❌ Evitar Números Mágicos

### Incorrecto:
```qml
// ❌ No hagas esto
QuickMorphismTheme {
    style: 1  // ¿Qué significa 1?
}

// ❌ Evita comparaciones con números
if (theme.style === 0) { ... }
```

### Correcto:
```qml
// ✅ Haz esto en su lugar
QuickMorphismTheme {
    style: QuickMorphismStyle.DARK  // Claro y legible
}

// ✅ Comparaciones legibles
if (theme.style === QuickMorphismStyle.LIGHT) { ... }
```

## 🔧 Configuración Técnica

Los enums están registrados automáticamente cuando inicializas QuickMorphism:

```cpp
// En C++
QuickMorphism::init(engine);

// Esto registra automáticamente:
// qmlRegisterUncreatableMetaObject(
//     StyleNamespace::staticMetaObject, 
//     "QuickMorphism", 1, 0, 
//     "QuickMorphismStyle", 
//     "Not creatable as it is an enum type"
// );
```

## 📝 Ejemplos Prácticos

### Selector de Tema
```qml
Column {
    RadioButton {
        text: "Tema Claro"
        checked: appTheme.style === QuickMorphismStyle.LIGHT
        onClicked: appTheme.style = QuickMorphismStyle.LIGHT
    }
    
    RadioButton {
        text: "Tema Oscuro"
        checked: appTheme.style === QuickMorphismStyle.DARK
        onClicked: appTheme.style = QuickMorphismStyle.DARK
    }
}
```

### Switch de Tema Dinámico
```qml
Switch {
    text: "Tema Oscuro"
    checked: currentTheme.style === QuickMorphismStyle.DARK
    
    onToggled: {
        currentTheme.style = checked ? 
            QuickMorphismStyle.DARK : 
            QuickMorphismStyle.LIGHT
    }
}
```

### Aplicación de Estilos Condicionales
```qml
Rectangle {
    color: {
        switch(appTheme.style) {
            case QuickMorphismStyle.LIGHT:
                return "#f0f0f0"
            case QuickMorphismStyle.DARK:
                return "#2b2b2b"
            default:
                return "#cccccc"
        }
    }
}
```

## 🎨 Temas Predefinidos

Los temas incluidos ya usan los enums correctamente:

```qml
// LightTheme (singleton)
property int style: QuickMorphismStyle.LIGHT

// DarkTheme (singleton)  
property int style: QuickMorphismStyle.DARK
```

Puedes acceder a ellos directamente:
```qml
Text {
    color: LightTheme.style === QuickMorphismStyle.LIGHT ? 
           LightTheme.primaryTextColor : 
           DarkTheme.primaryTextColor
}
```

## 🚀 Ventajas de Usar Enums

1. **Legibilidad**: `QuickMorphismStyle.DARK` es más claro que `1`
2. **Mantenibilidad**: Si cambian los valores, el código sigue funcionando
3. **Autocompletado**: IDEs pueden sugerir valores válidos
4. **Detección de errores**: Errores de tipeo son detectados en tiempo de compilación
5. **Documentación**: El código se autodocumenta

## 📋 Archivo de Ejemplo

Consulta `example/ENUM_USAGE_EXAMPLE.qml` para ver ejemplos completos de uso de enums en QuickMorphism.