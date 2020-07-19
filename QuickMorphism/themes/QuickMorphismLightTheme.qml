pragma Singleton

import QtQuick 2.15

QtObject {
    readonly property string name: "QuickMorphismLight"
    readonly property int style: 0
    readonly property color backgroundColor: "#E0E5EC"
    readonly property color foregroundColor: "#E0E5EC"
    readonly property color primaryTextColor: "#666666"
    readonly property color secondaryTextColor: "#666666"
    readonly property color hintTextColor: "#A2A2A2"
    readonly property color topShadowColor: "#FFFFFF"
    readonly property color bottonShadowColor: "#A3B1C6"
    readonly property color primaryColor: "#E0E5EC"
    readonly property color sencondaryColor: "#E0E5EC"
    readonly property color accentColor: "#7CB342"
    readonly property color errorColor: "#FF0000"
    readonly property color highlightedColor: "#f4f4f4"
    readonly property color hoverColor: "#7CB342"
    readonly property color statusBarColor: "#E0E5EC"
    readonly property color navBarColor: "#E0E5EC"
    readonly property double shadowOpacity: 1.0
    readonly property int shadowGlow: 5
    readonly property int insetShadowGlow: 10
    readonly property double shadowSpread: 0.5
    readonly property double insetShadowSpread: 0.5
    readonly property int shadowOffSet: 5
    readonly property double titleSize: Qt.application.font.pixelSize * 1.6
    readonly property double subTitleSize: Qt.application.font.pixelSize * 1.1
}
