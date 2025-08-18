import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 600
    title: "QuickMorphism Style Test - QQuickStyle::setStyle()"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Label {
            text: "QuickMorphism Style via QQuickStyle::setStyle()"
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
        }

        Button {
            text: "Neumorphic Button"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            placeholderText: "Neumorphic TextField"
            anchors.horizontalCenter: parent.horizontalCenter
            width: 200
        }

        Switch {
            text: "Neumorphic Switch"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        CheckBox {
            text: "Neumorphic CheckBox"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            text: "✅ Si esto se ve con efectos neumórficos, ¡el plugin funciona!"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#7CB342"
            wrapMode: Text.WordWrap
            width: 300
            horizontalAlignment: Text.AlignHCenter
        }
    }
}