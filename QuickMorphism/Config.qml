pragma Singleton

import QtQuick

QtObject {
    property QtObject theme: QuickMorphism.theme
    property double dpScale: QuickMorphism.dpScale
    property int dpi: QuickMorphism.dpi
}
