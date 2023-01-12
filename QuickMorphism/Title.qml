import QtQuick
import QtQuick.Controls

Item {
    id: control
    property string pageTitle: qsTr("Page Title")
    property string subTitle
    property double textWidth
    height: title.height + subTitle.height + 5
    property int titleFontSize: 10 * QuickMorphismConfig.theme.titleSizeMultiplier
    property int subTitleFontSize: 10 * QuickMorphismConfig.theme.subTitleSizeMultiplier

    Label {
        id: title
        text: control.pageTitle
        wrapMode: Text.WordWrap
        font.pointSize: titleFontSize
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
            font.pointSize: subTitleFontSize
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

