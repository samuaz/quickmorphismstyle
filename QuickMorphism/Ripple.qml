import QtQuick

Rectangle {
    property Item control
    property bool colored: false

    radius: width / 2
    scale: 2.5
    color: colored ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.backgroundColor
    opacity: 0.2

    Behavior on opacity {
        NumberAnimation {}
    }
}
