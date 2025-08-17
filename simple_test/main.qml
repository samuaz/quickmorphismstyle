import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: "QuickMorphism Qt6.9 Test"

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"

        Text {
            anchors.centerIn: parent
            text: "QuickMorphism migrado exitosamente a Qt 6.9!"
            font.pointSize: 18
            color: "#333"
        }
    }
}