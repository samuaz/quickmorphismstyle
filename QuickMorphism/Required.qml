import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: control
    property string errorMsg
    property bool show: true
    property bool showErrorMsg: false
    property string color: QuickMorphismConfig.theme.errorColor
    anchors.fill: parent

    FontAwesomeRegular {
        id: indicatorchecker
        fontSizeMode: "Fit"
        symbol: Icons.faExclamation
        font.weight: Font.Bold
        color: control.color
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        visible: control.show
    }

    Label {
        color: control.color
        text: errorMsg
        verticalAlignment: Text.AlignBottom
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: parent.height
        visible: control.showErrorMsg && control.errorMsg ? true : false
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:480;anchors_width:625}
}
##^##*/

