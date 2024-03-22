import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QuickMorphism

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

        Title {
            id: title
            pageTitle: qsTr("QuickMorphism UI Demo")
            subTitle: qsTr("by Samuaz")
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
            isRequired: true
            errorMessage: qsTr("This field is Mandatory")
        }

        TextField {
            id: textFieldPassword
            Layout.fillWidth: true
            placeholderText: qsTr("Required Text Field")
            isRequired: true
            isPassword: true
            errorMessage: qsTr("This field is Mandatory")
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

