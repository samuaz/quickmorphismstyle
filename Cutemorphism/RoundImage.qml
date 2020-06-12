import QtQuick 2.15
import QtQuick.Controls 2.15
import Cutemorphism 1.0

Item {
    id: root
    width: 120
    height: 120

    property alias control: control
    property int radius: Math.min(width, height) / 2
    property bool pressed: true

    Elevation {
        id: shadow
        width: root.width
        height: root.height
        radius: root.radius
        pressed: root.pressed
        normalSpread: 0.9
        pressedSpread: 0.9

    }

    Rectangle {
        width: root.width - 5
        height: root.height - 5
        radius: root.radius
        color: Cutemorphism.backgroundColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: control
            asynchronous: true
            width: parent.width-10
            height: parent.height-10
            verticalAlignment: Image.AlignVCenter
            horizontalAlignment: Image.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
