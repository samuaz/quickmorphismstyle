import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: "QuickMorphism Style Test"

    Page {
        anchors.fill: parent

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 20

            Text {
                text: "QuickMorphism Style Test"
                font.pixelSize: 24
                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                text: "Neumorphic Button"
                Layout.alignment: Qt.AlignHCenter
            }

            Button {
                text: "Flat Button"
                flat: true
                Layout.alignment: Qt.AlignHCenter
            }

            TextField {
                placeholderText: "Enter text here..."
                Layout.preferredWidth: 200
                Layout.alignment: Qt.AlignHCenter
            }

            CheckBox {
                text: "Check this box"
                Layout.alignment: Qt.AlignHCenter
            }

            Switch {
                text: "Toggle switch"
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                
                Text {
                    text: "Current style:"
                }
                
                Text {
                    text: "QuickMorphism"
                    font.bold: true
                    color: "#0066CC"
                }
            }
        }
    }
}