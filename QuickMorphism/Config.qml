pragma Singleton

import QtQuick
import QtQuick.Controls 2.15

QtObject {
    id: control
    property QtObject theme: LightTheme
    property double dpScale: 1.0
    property int dpi: 2

    // Default configuration - can be overridden by applications
    // Component.onCompleted: {
    //     control.theme = QuickMorphism.theme
    //     control.dpScale = QuickMorphism.dpScale
    //     control.dpi = QuickMorphism.dpi
    // }
}
