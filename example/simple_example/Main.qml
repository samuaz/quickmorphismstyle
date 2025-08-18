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

            Label {
                text: "QuickMorphism Style Demo"
                font.pixelSize: 24
                font.bold: true
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: "Current style: " + (Qt.application.styleHints ? "QuickMorphism" : "Unknown")
                Layout.alignment: Qt.AlignHCenter
                opacity: 0.7
            }

            Button {
                text: "Neumorphic Button"
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 200
            }

            Button {
                text: "Flat Button"
                flat: true
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 200
            }

            TextField {
                placeholderText: "Enter text here..."
                Layout.preferredWidth: 250
                Layout.alignment: Qt.AlignHCenter
            }

            TextField {
                placeholderText: "Password field..."
                echoMode: TextInput.Password
                Layout.preferredWidth: 250
                Layout.alignment: Qt.AlignHCenter
            }

            CheckBox {
                text: "Check this box"
                Layout.alignment: Qt.AlignHCenter
            }

            Switch {
                text: "Toggle switch"
                Layout.alignment: Qt.AlignHCenter
                onCheckedChanged: {
                    // Toggle between light and dark theme
                    if (checked) {
                        window.palette.window = "#2b2b2b"
                        window.palette.windowText = "#ffffff"
                    } else {
                        window.palette.window = "#E0E5EC"
                        window.palette.windowText = "#333333"
                    }
                }
            }
        }
    }
}