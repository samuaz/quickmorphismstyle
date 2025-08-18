import QtQuick
import QtQuick.Templates as T
import QuickMorphism

T.ApplicationWindow {
    id: window

    // Use QuickMorphismConfig.theme for colors
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    readonly property color backgroundColor: currentTheme ? currentTheme.backgroundColor : "#E0E5EC"

    color: backgroundColor

    overlay.modal: Rectangle {
        color: Qt.rgba(0, 0, 0, 0.5)
    }

    overlay.modeless: Rectangle {
        color: "transparent"
    }
}