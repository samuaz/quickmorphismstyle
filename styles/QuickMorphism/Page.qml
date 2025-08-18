import QtQuick
import QtQuick.Templates as T
import QuickMorphism

T.Page {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitHeaderWidth,
                            implicitFooterWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    // Use QuickMorphismConfig.theme for colors
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    readonly property color backgroundColor: currentTheme ? currentTheme.backgroundColor : "#E0E5EC"

    background: Rectangle {
        color: control.backgroundColor
    }
}