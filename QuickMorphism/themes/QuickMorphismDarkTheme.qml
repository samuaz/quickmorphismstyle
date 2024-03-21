pragma Singleton

import QtQuick

QtObject {
    property string name: "QuickMorphismDarkTheme"
    property string style: QuickMorphismStyle.DARK
    property color backgroundColor: "#243441"
    property color foregroundColor: "#243441"
    property color primaryTextColor: "#ebebeb"
    property color secondaryTextColor: "#ebebeb"
    property color hintTextColor: "#959EA8"
    property color topShadowColor: "#293a46"
    property color bottonShadowColor: "#092836"
    property color primaryColor: "#243441"
    property color secondaryColor: "#243441"
    property color accentColor: "#0affef"
    property color errorColor: "#FF0000"
    property color highlightedColor: "#4d5e6c"
    property color hoverColor: "#7CB342"
    property color statusBarColor: "#243441"
    property color navBarColor: "#243441"

    property double titleSizeMultiplier: 2.0
    property double subTitleSizeMultiplier: 1.5
    property double shadowOpacity: 1.0
    property int shadowGlow: 5
    property int insetShadowGlow: 10
    property double shadowSpread: 0.5
    property double insetShadowSpread: 0.5
    property int shadowOffSet: 5
}

