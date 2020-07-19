import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: control
    property string pageTitle: qsTr("Page Title")
    property string subTitle
    property double textWidth

    Label {
        id: title
        text: control.pageTitle
        wrapMode: Text.WordWrap
        font.pointSize: QuickMorphismConfig.theme.titleSize
        color: QuickMorphismConfig.theme.primaryTextColor
        width: control.textWidth

        Rectangle {
            id: separator
            height: 1
            width: title.width / 4
            color: QuickMorphismConfig.theme.hintTextColor
            anchors {
                left: title.left
                right: title.right
                top: title.bottom
                topMargin: 10
            }
        }

        Label {
            id: subTitle
            text: control.subTitle
            font.pointSize: QuickMorphismConfig.theme.subTitleSize
            anchors.top: separator.bottom
            anchors.topMargin: 5
            color: QuickMorphismConfig.theme.primaryTextColor
            width: title.width
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

