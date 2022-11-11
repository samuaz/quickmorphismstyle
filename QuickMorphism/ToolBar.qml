import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Timeline
import QtQuick.Templates as T

T.ToolBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 16

    background: Rectangle {
        implicitHeight: 48
        color: QuickMorphismConfig.theme.foregroundColor
    }
}
