import QtQuick
import QtQuick.Controls
import QuickMorphism

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 360
    width: 360
    height: 640

    title: qsTr("QuickMorphism Style - QQuickStyle Test")

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "QuickMorphism via QQuickStyle::setStyle()"
            font.bold: true
            font.pixelSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
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
            text: "Dark Mode Switch"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        CheckBox {
            text: "Neumorphic CheckBox"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "✅ Si los controles se ven con efectos neumórficos,\n¡el plugin funciona correctamente!"
            color: "#7CB342"
            wrapMode: Text.WordWrap
            width: 300
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
