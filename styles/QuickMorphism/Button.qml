import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QuickMorphism

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topInset: 0
    bottomInset: 0
    topPadding: 10
    bottomPadding: 10
    rightPadding: 20
    leftPadding: 20
    spacing: 6
    icon.width: 24
    icon.height: 24

    // Use QuickMorphismConfig.theme for colors - this is the key!
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    readonly property color backgroundColor: currentTheme ? currentTheme.backgroundColor : "#E0E5EC"
    readonly property color foregroundColor: currentTheme ? currentTheme.foregroundColor : "#E0E5EC"
    readonly property color shadowColor: currentTheme ? currentTheme.bottonShadowColor : "#A3B1C6"
    readonly property color highlightColor: currentTheme ? currentTheme.topShadowColor : "#FFFFFF"
    readonly property color textColor: currentTheme ? currentTheme.primaryTextColor : "#666666"
    readonly property color accentColor: currentTheme ? currentTheme.accentColor : "#7CB342"

    icon.color: !enabled ? Qt.rgba(textColor.r, textColor.g, textColor.b, 0.5) : 
                control.flat ? accentColor : textColor

    property int radius: 15
    font.capitalization: Font.MixedCase

    background: Rectangle {
        color: foregroundColor
        radius: control.radius
        implicitWidth: 100
        implicitHeight: 38

        // Neumorphism shadow effect
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            border.width: 0
            
            // Outer shadow (dark)
            Rectangle {
                x: 3; y: 3
                width: parent.width
                height: parent.height
                radius: parent.radius
                color: control.shadowColor
                opacity: control.down ? 0.2 : 0.3
                z: -2
            }
            
            // Inner highlight (light)
            Rectangle {
                x: -3; y: -3
                width: parent.width
                height: parent.height
                radius: parent.radius
                color: control.highlightColor
                opacity: control.down ? 0.1 : 0.4
                z: -1
            }
        }
        
        // Pressed state - inverted shadows
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            visible: control.down
            
            // Inner shadow when pressed
            Rectangle {
                x: 1; y: 1
                width: parent.width - 2
                height: parent.height - 2
                radius: parent.radius - 1
                color: control.shadowColor
                opacity: 0.2
            }
        }
    }

    contentItem: IconLabel {
        icon: control.icon
        text: control.text
        font: control.font
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        color: !control.enabled ? Qt.rgba(textColor.r, textColor.g, textColor.b, 0.5) : 
               control.flat ? accentColor : textColor
    }
}