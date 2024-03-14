pragma Singleton

import QtQuick
import QuickMorphism


QtObject {
    property string name: "QuickMorphismLightTheme"
    property string style: "LIGHT"
    property color backgroundColor: "#E0E5EC"
    property color foregroundColor: "#E0E5EC"
    property color primaryTextColor: "#666666"
    property color secondaryTextColor: "#666666"
    property color hintTextColor: "#A2A2A2"
    property color topShadowColor: "#FFFFFF"
    property color bottonShadowColor: "#A3B1C6"
    property color primaryColor: "#E0E5EC"
    property color secondaryColor: "#E0E5EC"
    property color accentColor: "#7CB342"
    property color errorColor: "#FF0000"
    property color highlightedColor: "#f4f4f4"
    property color hoverColor: "#7CB342"
    property color statusBarColor: "#E0E5EC"
    property color navBarColor: "#E0E5EC"

    // Multipliers y propiedades de sombra
    property double titleSizeMultiplier: 2.0
    property double subTitleSizeMultiplier: 1.5
    property double shadowOpacity: 1.0
    property int shadowGlow: 5
    property int insetShadowGlow: 10
    property double shadowSpread: 0.5
    property double insetShadowSpread: 0.5
    property int shadowOffSet: 5
}
