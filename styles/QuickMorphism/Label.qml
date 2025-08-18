import QtQuick
import QtQuick.Templates as T
import QuickMorphism

T.Label {
    id: control

    // Use QuickMorphismConfig.theme for colors
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    
    color: enabled ? (currentTheme ? currentTheme.primaryTextColor : "#666666") : (currentTheme ? currentTheme.hintTextColor : "#A2A2A2")
    linkColor: currentTheme ? currentTheme.accentColor : "#7CB342"
}