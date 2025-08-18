import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: page
    property alias snackbarButton: snackBarButton
    property alias themeSwitch: themeSwitch

    Switch {
        id: themeSwitch
        text: qsTr("DarkMode")
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 25
    }

    ColumnLayout {
        id: content
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 100
        spacing: 40

        // Replace Title with standard Label
        Column {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10
            
            Label {
                text: qsTr("QuickMorphism UI Demo")
                font.pixelSize: 24
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Label {
                text: qsTr("by Samuaz")
                font.pixelSize: 16
                opacity: 0.7
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        TextField {
            id: textField
            Layout.fillWidth: true
            placeholderText: qsTr("Text Field")
        }

        TextField {
            id: textFieldRequired
            Layout.fillWidth: true
            placeholderText: qsTr("Required Text Field")
            // Remove custom properties not available in standard TextField
        }

        TextField {
            id: textFieldPassword
            Layout.fillWidth: true
            placeholderText: qsTr("Password Field")
            echoMode: TextInput.Password
            // Remove custom properties not available in standard TextField
        }

        Button {
            id: snackBarButton
            text: qsTr("Open snackbar!")
        }

        Switch {
            id: element
            text: qsTr("Switch")
        }

        CheckBox {
            id: checkBox
            text: qsTr("Check Box")
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

