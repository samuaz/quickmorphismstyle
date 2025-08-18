import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

T.CheckBox {
    id: control
    property int radius: 5

    implicitWidth: Math.max(
                       background ? background.implicitWidth : 0,
                       contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        background ? background.implicitHeight : 0, Math.max(
                            contentItem.implicitHeight,
                            indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding)

    spacing: 10
    padding: 8
    verticalPadding: padding + 7

    // Neumorphism colors - auto-detect dark/light theme
    readonly property color backgroundColor: control.palette.window
    readonly property color foregroundColor: Qt.lighter(backgroundColor, 1.05)
    readonly property color shadowColor: Qt.darker(backgroundColor, 1.15)
    readonly property color highlightColor: Qt.lighter(backgroundColor, 1.15)
    readonly property color textColor: control.palette.windowText
    readonly property color accentColor: control.palette.highlight

    icon.color: !enabled ? Qt.rgba(textColor.r, textColor.g, textColor.b, 0.5) : textColor

    indicator: Rectangle {
        id: indicator
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding
                          + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 20
        implicitHeight: 20
        radius: control.radius
        color: foregroundColor

        // Neumorphism shadow effect
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

        // Check mark
        Text {
            id: checkMark
            anchors.centerIn: parent
            text: "✓"
            font.pixelSize: parent.width * 0.7
            font.bold: true
            color: control.checked ? control.accentColor : "transparent"
            visible: control.checked
            
            Behavior on color {
                ColorAnimation { duration: 150 }
            }
        }
        
        // Inner pressed effect
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: control.shadowColor
            opacity: control.pressed ? 0.1 : 0
            
            Behavior on opacity {
                NumberAnimation { duration: 100 }
            }
        }
    }

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
}
