import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: control
    property string errorMsg
    property bool show: true
    property bool showErrorMsg: false
    property string color: QuickMorphismConfig.theme.errorColor
    property int errorMsgSize: 10
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
        id: givenLabel
        color: control.color
        text: errorMsg
        font.pointSize: control.errorMsgSize
        verticalAlignment: Text.AlignBottom
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: parent.height + 10
        visible: control.showErrorMsg && control.errorMsg ? true : false
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1;anchors_height:480;anchors_width:625}
}
##^##*/

