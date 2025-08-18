import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QuickMorphism

T.TextField {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    topPadding: 12
    bottomPadding: 12
    leftPadding: 16
    rightPadding: 16

    // Use QuickMorphismConfig.theme for colors
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    readonly property color backgroundColor: currentTheme ? currentTheme.backgroundColor : "#E0E5EC"
    readonly property color foregroundColor: currentTheme ? currentTheme.foregroundColor : "#E0E5EC"
    readonly property color shadowColor: currentTheme ? currentTheme.bottonShadowColor : "#A3B1C6"
    readonly property color highlightColor: currentTheme ? currentTheme.topShadowColor : "#FFFFFF"
    readonly property color textColor: currentTheme ? currentTheme.primaryTextColor : "#666666"
    readonly property color hintTextColor: currentTheme ? currentTheme.hintTextColor : "#A2A2A2"
    readonly property color accentColor: currentTheme ? currentTheme.accentColor : "#7CB342"

    color: textColor
    selectionColor: Qt.rgba(accentColor.r, accentColor.g, accentColor.b, 0.3)
    selectedTextColor: textColor
    placeholderTextColor: hintTextColor
    verticalAlignment: TextInput.AlignVCenter

    property int radius: 15

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        color: foregroundColor
        radius: control.radius

        // Inset neumorphism effect for text field
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            
            // Inner shadow (inset effect)
            Rectangle {
                x: 2; y: 2
                width: parent.width - 4
                height: parent.height - 4
                radius: parent.radius - 2
                color: control.shadowColor
                opacity: 0.2
                z: -1
            }
            
            // Inner highlight (opposite corner)
            Rectangle {
                x: -1; y: -1
                width: parent.width - 2
                height: parent.height - 2
                radius: parent.radius - 1
                color: control.highlightColor
                opacity: 0.1
                z: -2
            }
        }

        // Focus indicator
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.color: control.activeFocus ? accentColor : "transparent"
            border.width: control.activeFocus ? 2 : 0
            opacity: 0.6
        }
    }
}