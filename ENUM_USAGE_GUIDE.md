# QuickMorphism Enum Usage Guide

## 🎨 Using Style Enums

QuickMorphism provides convenient enums for easy theme configuration. Here's how to use them:

### Available Style Constants

```qml
import QuickMorphism 1.0

// Available style constants:
QuickMorphismStyle.light        // 0 - Light theme
QuickMorphismStyle.dark         // 1 - Dark theme  
QuickMorphismStyle.styleFilled  // 2 - Filled style variant
QuickMorphismStyle.auto         // -1 - Auto-detect from system
```

### Basic Usage Examples

#### 1. Setting Theme in Your Application

```qml
import QtQuick
import QtQuick.Controls
import QuickMorphism 1.0

ApplicationWindow {
    visible: true
    
    Component.onCompleted: {
        // Set theme using enum
        QuickMorphismConfig.theme = QuickMorphismStyle.dark === 1 ? DarkTheme : LightTheme
        
        // Or use helper functions
        if (QuickMorphismStyle.isDarkStyle(1)) {
            QuickMorphismConfig.theme = DarkTheme
        }
    }
    
    QuickMorphism.Button {
        text: "Styled Button"
        anchors.centerIn: parent
    }
}
```

#### 2. Custom Theme Configuration

```qml
import QtQuick
import QuickMorphism 1.0

QtObject {
    id: myCustomTheme
    
    // Use enums for style identification
    property int style: QuickMorphismStyle.light
    property string name: "MyCustomTheme"
    
    // Define colors based on style
    property color backgroundColor: style === QuickMorphismStyle.light ? "#F0F0F0" : "#2D2D2D"
    property color textColor: style === QuickMorphismStyle.dark ? "#FFFFFF" : "#333333"
    
    // ... other theme properties
}
```

#### 3. Conditional Styling

```qml
import QtQuick
import QuickMorphism 1.0

QuickMorphism.Button {
    text: "Dynamic Button"
    
    // Use enum for conditional styling
    property int currentStyle: QuickMorphismStyle.light
    
    background.color: {
        switch(currentStyle) {
            case QuickMorphismStyle.light: return "#E0E5EC"
            case QuickMorphismStyle.dark: return "#243441"
            case QuickMorphismStyle.styleFilled: return "#007ACC"
            default: return "#E0E5EC"
        }
    }
}
```

### Helper Functions

QuickMorphismStyle also provides useful helper functions:

```qml
import QuickMorphism 1.0

Component.onCompleted: {
    // Get style name as string
    console.log(QuickMorphismStyle.getStyleName(QuickMorphismStyle.light))  // "Light"
    console.log(QuickMorphismStyle.getStyleName(QuickMorphismStyle.dark))   // "Dark"
    
    // Check style type
    if (QuickMorphismStyle.isLightStyle(QuickMorphismStyle.light)) {
        console.log("This is a light style")
    }
    
    if (QuickMorphismStyle.isDarkStyle(QuickMorphismStyle.dark)) {
        console.log("This is a dark style")
    }
}
```

### QML Naming Convention Note

⚠️ **Important**: Due to QML naming conventions, enum properties start with lowercase:

```qml
// ✅ Correct - QML standard
QuickMorphismStyle.light
QuickMorphismStyle.dark
QuickMorphismStyle.styleFilled
QuickMorphismStyle.auto

// ❌ Incorrect - Would cause QML errors
QuickMorphismStyle.LIGHT  
QuickMorphismStyle.DARK
QuickMorphismStyle.STYLE_FILLED
```

### Integration with QQuickStyle::setStyle()

When using `QQuickStyle::setStyle("QuickMorphism")`, the enums work the same way:

```cpp
// main.cpp
#include <QQuickStyle>
QQuickStyle::setStyle("QuickMorphism");
```

```qml
// main.qml
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    // Controls automatically use QuickMorphism style
    // Enums are still available for custom logic
    
    Button {
        text: "Auto-styled Button"
        
        Component.onCompleted: {
            console.log("Current theme style:", QuickMorphismConfig.theme.style)
            console.log("Is light theme:", QuickMorphismStyle.isLightStyle(QuickMorphismConfig.theme.style))
        }
    }
}
```

### Best Practices

1. **Use enums for clarity**: `QuickMorphismStyle.dark` is more readable than `1`
2. **Leverage helper functions**: Use `isLightStyle()` and `isDarkStyle()` for logic
3. **Consistent naming**: Follow QML camelCase convention
4. **Documentation**: Comment your custom style constants

### Migration from Hard-coded Values

If you were using hard-coded numbers, here's how to migrate:

```qml
// Before (hard-coded)
property int style: 0  // Light
property int style: 1  // Dark

// After (with enums)
property int style: QuickMorphismStyle.light
property int style: QuickMorphismStyle.dark
```

This approach provides better maintainability and readability while following QML best practices! 🎉