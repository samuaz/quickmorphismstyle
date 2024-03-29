import QtQuick
import QtQuick.Templates as T

T.Page {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitHeaderWidth, implicitFooterWidth)
    implicitHeight: Math.max(
                        implicitBackgroundHeight + topInset + bottomInset,
                        contentHeight + topPadding + bottomPadding
                        + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                        + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    background: Rectangle {
        color: QuickMorphismConfig.theme.backgroundColor
        anchors.fill: parent
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

