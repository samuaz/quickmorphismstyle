import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QuickMorphism 1.0

Page {
    id: page
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
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 100
        spacing: 40

        TextField {
            id: textField
            Layout.fillWidth: true
            placeholderText: qsTr("Text Field")
        }

        Button {}

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

