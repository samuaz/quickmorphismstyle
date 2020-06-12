import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Cutemorphism 1.0
import "Cutemorphism" as C

Rectangle {
    id: rectangle
    width: Cutemorphism.width
    height: Cutemorphism.height

    color: Cutemorphism.backgroundColor

    Label {
        id: title
        text: "PAPAYA"
        font.pointSize: 40
        anchors.top: parent.top
        anchors.topMargin: 40
        anchors.horizontalCenter: parent.horizontalCenter
        color: Cutemorphism.textPrimaryColor
    }

    ColumnLayout {
        id: row
        spacing: 40
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.top: title.bottom
        anchors.topMargin: 40

        C.RoundImage {
            Layout.preferredHeight: 200
            Layout.preferredWidth: 200
            radius: 100
            control.source: "images/welcomepicture.png"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        TextField {
            id: username
            Layout.preferredHeight: 40
            Layout.preferredWidth: 280
            Layout.fillWidth: true
            placeholderText: qsTr("UserName")
            cursorVisible: true
        }

        TextField {
            id: password
            Layout.preferredHeight: 40
            Layout.preferredWidth: 280
            Layout.fillWidth: true
            cursorVisible: true
            placeholderText: "Password"
            echoMode: TextInput.PasswordEchoOnEdit
        }

        Button {
            width: 120
            Layout.preferredHeight: 40
            Layout.preferredWidth: 120
            Layout.topMargin: 40
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        CheckBox {
            id: checkBox
            text: qsTr("Check Box")
        }

        Switch {}
    }

    DelayButton {
        id: delayButton
        x: 249
        y: 787
        text: qsTr("Delay Button")
    }

    RadioButton {
        id: radioButton
        x: 100
        y: 863
        text: qsTr("Radio Button")
    }

    RadioDelegate {
        id: radioDelegate
        x: 260
        y: 695
        text: qsTr("Radio Delegate")
    }

    SwitchDelegate {
        id: switchDelegate
        x: 35
        y: 805
    }

    RangeSlider {
        id: rangeSlider
        x: 112
        y: 513
    }

    SpinBox {
        id: spinBox
        x: 229
        y: 632
    }

    ProgressBar {
        id: progressBar
        x: 140
        y: 338
        value: 0.5
    }
}
