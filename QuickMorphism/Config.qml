pragma Singleton

import QtQuick

QtObject {
    property QtObject theme: QuickMorphism.theme
    property double dpScale: 1.0
    property int dpi: 0
}
