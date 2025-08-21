pragma Singleton

import QtQuick
import QuickMorphism 1.0

QtObject {
    // Expose C++ enums as convenient properties
    // These map directly to the C++ StyleNamespace::Style enum
    // Use as: QuickMorphismStyle.light, QuickMorphismStyle.dark, etc.
    readonly property int light: 0        // StyleNamespace::Style::LIGHT
    readonly property int dark: 1         // StyleNamespace::Style::DARK  
    readonly property int styleFilled: 2  // StyleNamespace::Style::STYLE_FILLED
    
    // Helper functions for better usability
    function getStyleName(style) {
        switch(style) {
            case light: return "Light"
            case dark: return "Dark" 
            case styleFilled: return "Filled"
            default: return "Unknown"
        }
    }
    
    function isLightStyle(style) {
        return style === light
    }
    
    function isDarkStyle(style) {
        return style === dark
    }
    
    function isFilledStyle(style) {
        return style === styleFilled
    }
}