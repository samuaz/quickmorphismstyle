import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QuickMorphism 1.0

Page {
    id: page

    QuickMorphismUI {
        theme: LightTheme
    }

    Button {
        id: button
        height: 60
        text: qsTr("Button")
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.right: parent.right
        anchors.rightMargin: 40
        anchors.left: parent.left
        anchors.leftMargin: 40
    }

    Button {
        id: button1
        x: 40
        width: 560
        height: 60
        text: qsTr("Button")
        anchors.top: button.bottom
        anchors.topMargin: 40
    }

    CheckBox {
        id: checkBox
        x: 30
        y: 268
        text: qsTr("Check Box")
    }

    Switch {
        id: element
        x: 30
        y: 324
        text: qsTr("Switch")
    }

    Button {
        id: button2
        x: 360
        y: 306
        text: qsTr("Button")
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}D{i:2;anchors_x:30;anchors_y:75}
D{i:3;anchors_y:175}
}
##^##*/

