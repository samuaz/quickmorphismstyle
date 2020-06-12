import QtQuick 2.15
import QtQuick.Controls 2.15
import Cutemorphism 1.0
import QtQuick.Timeline 1.0
import QtQuick.Templates 2.15 as T

T.Button {
    id: control

    font: Cutemorphism.font
    implicitWidth: Math.max(
                       background ? background.implicitWidth : 0,
                       contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        background ? background.implicitHeight : 0,
                        contentItem.implicitHeight + topPadding + bottomPadding)
    leftPadding: 4
    rightPadding: 4

    property string color: Cutemorphism.textPrimaryColor

    text: "My Button"
    property int radius: Math.min(width, height) / 2

    Elevation {
        id: shadow
        width: control.width
        height: control.height
        radius: control.radius
        pressed: false
    }

    background: Rectangle {
        color: Cutemorphism.controlsBackgroundColor
        radius: control.radius
        opacity: enabled ? 1 : 0.3
        implicitWidth: 120
        implicitHeight: Cutemorphism.baseSize * 4
    }

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.color
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    states: [
        State {
            name: "buttonPressed"
            when: control.down
            PropertyChanges {
                target: shadow
                pressed: control.down
            }
        },
        State {
            name: "buttonChecked"
            when: control.checked
            PropertyChanges {
                target: shadow
                pressed: control.checked
            }
        }
    ]
}
