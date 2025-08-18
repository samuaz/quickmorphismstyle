import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Basic Test"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Basic Qt Quick Controls Test"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Test Button"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            placeholderText: "Test field"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        CheckBox {
            text: "Test checkbox"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}