import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl

T.TextField {
    id: control
    property int radius: 5

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset || Math.max(
                       contentWidth,
                       placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(
                        implicitBackgroundHeight + topInset + bottomInset,
                        contentHeight + topPadding + bottomPadding,
                        placeholder.implicitHeight + topPadding + bottomPadding)

    verticalAlignment: TextInput.AlignVCenter
    padding: 10

    // Neumorphism colors - auto-detect dark/light theme
    readonly property color backgroundColor: control.palette.window
    readonly property color foregroundColor: Qt.lighter(backgroundColor, 1.05)
    readonly property color shadowColor: Qt.darker(backgroundColor, 1.15)
    readonly property color highlightColor: Qt.lighter(backgroundColor, 1.15)
    readonly property color textColor: control.palette.windowText
    readonly property color accentColor: control.palette.highlight

    placeholderTextColor: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.5)

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText
                 && (!control.activeFocus
                     || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    background: Rectangle {
        id: background
        color: foregroundColor
        radius: control.radius
        implicitHeight: 38
        implicitWidth: 200
        border.width: control.activeFocus ? 2 : 0
        border.color: control.activeFocus ? control.accentColor : "transparent"

        // Neumorphism inset shadow effect (concave)
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            
            // Inner shadow (dark) - top-left
            Rectangle {
                x: 1; y: 1
                width: parent.width - 2
                height: parent.height - 2
                radius: parent.radius - 1
                color: control.shadowColor
                opacity: 0.2
                z: -2
            }
            
            // Inner highlight (light) - bottom-right (subtle)
            Rectangle {
                x: -1; y: -1
                width: parent.width + 2
                height: parent.height + 2
                radius: parent.radius + 1
                color: control.highlightColor
                opacity: 0.1
                z: -1
                visible: !control.activeFocus
            }
        }
    }

    color: !control.enabled ? Qt.rgba(textColor.r, textColor.g, textColor.b, 0.5) : textColor
    selectByMouse: true

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        acceptedButtons: Qt.NoButton
    }
}

