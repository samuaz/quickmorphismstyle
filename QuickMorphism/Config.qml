pragma Singleton

import QtQuick

QtObject {
    id: control

    // Current theme - defaults to QML LightTheme singleton for Designer compatibility.
    // At runtime, QuickMorphismUI.qml syncs this with the C++ QuickMorphism.theme.
    property QtObject theme: LightTheme
    property double dpScale: 1.0
    property int dpi: 2

    // Sync with C++ singleton when available (runtime only, not in Designer)
    Component.onCompleted: {
        if (typeof QuickMorphism !== "undefined" && QuickMorphism !== null) {
            if (QuickMorphism.theme)
                control.theme = QuickMorphism.theme
            control.dpScale = QuickMorphism.dpScale
            control.dpi = QuickMorphism.dpi
        }
    }
}
