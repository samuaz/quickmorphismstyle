import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

T.Switch {
    id: control

    implicitWidth: Math.max(
                       background ? background.implicitWidth : 0,
                       contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        background ? background.implicitHeight : 0, Math.max(
                            contentItem.implicitHeight,
                            indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding)

    spacing: 12
    padding: 8
    verticalPadding: padding + 7

    // Neumorphism colors - auto-detect dark/light theme
    readonly property color backgroundColor: control.palette.window
    readonly property color foregroundColor: Qt.lighter(backgroundColor, 1.05)
    readonly property color shadowColor: Qt.darker(backgroundColor, 1.15)
    readonly property color highlightColor: Qt.lighter(backgroundColor, 1.15)
    readonly property color textColor: control.palette.windowText
    readonly property color accentColor: control.palette.highlight

    contentItem: IconLabel {
        leftPadding: control.indicator
                     && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator
                      && control.mirrored ? control.indicator.width + control.spacing : 0
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: control.display === IconLabel.IconOnly
                   || control.display === IconLabel.TextUnderIcon ? Qt.AlignCenter : Qt.AlignLeft
        icon: control.icon
        text: control.text
        font: control.font
        color: !control.enabled ? Qt.rgba(textColor.r, textColor.g, textColor.b, 0.5) : textColor
    }

    indicator: Rectangle {
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding
                          + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 45
        implicitHeight: 25
        radius: Math.min(implicitWidth, implicitHeight) / 2
        color: foregroundColor

        // Track neumorphism (inset)
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            
            // Inner shadow for track
            Rectangle {
                x: 1; y: 1
                width: parent.width - 2
                height: parent.height - 2
                radius: parent.radius - 1
                color: control.shadowColor
                opacity: 0.3
                z: -1
            }
        }

        Rectangle {
            id: handle
            x: Math.max(2, Math.min(parent.width - width - 2,
                                    control.visualPosition * (parent.width - width - 4) + 2))
            y: (parent.height - height) / 2
            width: 20
            height: width
            radius: width / 2
            color: control.checked ? control.accentColor : foregroundColor

            // Handle neumorphism (convex)
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: "transparent"
                
                // Outer shadow (dark)
                Rectangle {
                    x: 2; y: 2
                    width: parent.width
                    height: parent.height
                    radius: parent.radius
                    color: control.shadowColor
                    opacity: 0.3
                    z: -2
                }
                
                // Inner highlight (light)
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

            Behavior on x {
                enabled: !control.pressed
                SmoothedAnimation {
                    duration: 300
                }
            }
            
            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
    }
}

