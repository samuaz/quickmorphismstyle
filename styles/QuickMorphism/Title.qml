import QtQuick
import QtQuick.Controls
import QuickMorphism

Item {
    id: control
    property string pageTitle: qsTr("Page Title")
    property string subTitle
    property double textWidth
    height: title.height + subTitle.height + 5
    
    // Use QuickMorphismConfig.theme for colors
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    property int titleFontSize: 10 * (currentTheme ? currentTheme.titleSizeMultiplier : 2.0)
    property int subTitleFontSize: 10 * (currentTheme ? currentTheme.subTitleSizeMultiplier : 1.5)

    Label {
        id: title
        text: control.pageTitle
        wrapMode: Text.WordWrap
        font.pointSize: titleFontSize
        color: currentTheme ? currentTheme.primaryTextColor : "#666666"
        width: control.textWidth

        Rectangle {
            id: separator
            height: 1
            width: title.width / 4
            color: currentTheme ? currentTheme.hintTextColor : "#A2A2A2"
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
            color: currentTheme ? currentTheme.primaryTextColor : "#666666"
            width: title.width
        }
    }
}