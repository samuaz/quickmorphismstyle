import QtQuick
import QtQuick.Templates as T

T.ApplicationWindow {
    id: window
    
    // Neumorphism colors - auto-detect dark/light theme
    readonly property color backgroundColor: window.palette.window
    
    color: backgroundColor
    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint
}

