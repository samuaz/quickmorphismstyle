import QtQuick 2.12
import QtQuick.Controls 2.12
import Cutemorphism 1.0
import QtQuick.Templates 2.15 as T
import QtQuick.Controls.impl 2.12


T.TextField {
    id: control

    font: Cutemorphism.font

    property int radius: 5

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                   || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding,
                             placeholder.implicitHeight + topPadding + bottomPadding)


    verticalAlignment: TextInput.AlignVCenter
    padding: 10

    placeholderText: qsTr("Description")
    placeholderTextColor: Cutemorphism.textPrimaryColorDisable

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
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    Elevation {
        id: shadow
        width: control.width
        height: control.height
        radius: control.radius
        pressed: true
        z: -2
    }

    background: Rectangle {
        id: background
        color: Cutemorphism.controlsBackgroundColor
        radius: control.radius
        implicitHeight: Cutemorphism.baseSize * 4
        implicitWidth: 200
    }

    cursorVisible: false
    color: Cutemorphism.textPrimaryColor
    selectByMouse: true
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        acceptedButtons: Qt.NoButton
    }

    states: [
        State {
            name: "on"
            when: control.focus
            PropertyChanges {
                target: background
                border.color: Cutemorphism.controlsHighlighterColor
            }
        },
        State {
            name: "off"
            when: !control.focus
            PropertyChanges {
                target: background
                border.color: Cutemorphism.controlsBackgroundColor
            }
        }
    ]
}
