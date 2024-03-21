pragma Singleton

import QtQuick
import QtQuick.Controls 2.15

QtObject {
    property QtObject theme: LightTheme
    property double dpScale: 1.0
    property int dpi: 2

    Component.onCompleted: {
        root.theme = QuickMorphism.theme
        root.dpScale = QuickMorphism.dpScale
        root.dpi = QuickMorphism.dpi
    }
}
