pragma Singleton

import QtQuick

QtObject {
    property QtObject theme: LightTheme
    property double dpScale: QuickMorphism.dpScale
    property int dpi: QuickMorphism.dpi
}
