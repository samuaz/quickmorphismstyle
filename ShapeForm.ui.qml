import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Item {
    id: root
    property double radius: 100
    property int w: 120
    property int h: 40
    width: 640
    height: 400

    RectangularGlow {
        id: innerwhite
        anchors.fill: button
        glowRadius: 10
        spread: 0.6
        color: "#ccffffff"
        anchors.leftMargin: 5
        anchors.topMargin: 5
        height: button.background.height
        width: button.background.width
        cornerRadius: root.radius + glowRadius
        visible: false
    }

    RectangularGlow {
        id: innerblack
        anchors.fill: button
        glowRadius: 10
        spread: 0.5
        color: "#cca3b1c6"
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
        height: button.background.height
        width: button.background.width
        cornerRadius: root.radius + glowRadius
        visible: false
    }

    RectangularGlow {
        id: white
        height: button.height
        width: button.width
        anchors.top: button.top
        anchors.left: button.left
        glowRadius: 5
        spread: 0.5
        color: "#ccffffff"
        anchors.topMargin: -5
        anchors.leftMargin: -5
        cornerRadius: root.radius + glowRadius
    }

    RectangularGlow {
        id: black
        height: button.height
        width: button.width
        anchors.top: button.top
        anchors.left: button.left
        glowRadius: 5
        spread: 0.5
        color: "#cca3b1c6"
        anchors.topMargin: 5
        anchors.leftMargin: 5
        cornerRadius: root.radius + glowRadius
    }

    Button {
        id: button
        text: "Button"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle {
            color: "#E0E5EC"
            radius: root.radius
        }
        width: root.w
        height: root.h
    }

    states: [
        State {
            name: "buttonPressed"
            when: button.pressed

            PropertyChanges {
                target: white
                visible: !button.down
            }

            PropertyChanges {
                target: black
                visible: !button.down
            }

            PropertyChanges {
                target: innerwhite
                visible: button.down
            }

            PropertyChanges {
                target: innerblack
                visible: button.down
            }
        }
    ]
}
