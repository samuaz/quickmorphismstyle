import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QuickMorphism

T.Switch {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topPadding: 6
    bottomPadding: 6
    leftPadding: 12
    rightPadding: 12
    spacing: 12

    // Use QuickMorphismConfig.theme for colors
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    readonly property color backgroundColor: currentTheme ? currentTheme.backgroundColor : "#E0E5EC"
    readonly property color foregroundColor: currentTheme ? currentTheme.foregroundColor : "#E0E5EC"
    readonly property color shadowColor: currentTheme ? currentTheme.bottonShadowColor : "#A3B1C6"
    readonly property color highlightColor: currentTheme ? currentTheme.topShadowColor : "#FFFFFF"
    readonly property color textColor: currentTheme ? currentTheme.primaryTextColor : "#666666"
    readonly property color accentColor: currentTheme ? currentTheme.accentColor : "#7CB342"

    indicator: Rectangle {
        implicitWidth: 56
        implicitHeight: 28
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        radius: 14
        color: control.checked ? control.accentColor : control.foregroundColor

        // Track neumorphism shadow
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            
            // Inset shadow for track
            Rectangle {
                x: 2; y: 2
                width: parent.width - 4
                height: parent.height - 4
                radius: parent.radius - 2
                color: control.shadowColor
                opacity: control.checked ? 0.1 : 0.3
                z: -1
            }
        }

        // Switch handle
        Rectangle {
            x: control.checked ? parent.width - width - 4 : 4
            y: 4
            width: 20
            height: 20
            radius: 10
            color: control.foregroundColor

            Behavior on x {
                enabled: !control.down
                SmoothedAnimation { velocity: 200 }
            }

            // Handle neumorphism effect
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: "transparent"
                
                // Outer shadow for handle
                Rectangle {
                    x: 2; y: 2
                    width: parent.width
                    height: parent.height
                    radius: parent.radius
                    color: control.shadowColor
                    opacity: 0.3
                    z: -2
                }
                
                // Inner highlight for handle
                Rectangle {
                    x: -2; y: -2
                    width: parent.width
                    height: parent.height
                    radius: parent.radius
                    color: control.highlightColor
                    opacity: 0.4
                    z: -1
                }
            }
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.textColor
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
    }
}