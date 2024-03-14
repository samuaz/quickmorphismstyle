pragma Singleton

import QtQuick

QtObject {
    property QtObject theme: QuickMorphism.theme ?? DarkTheme
    property double dpScale: QuickMorphism.dpScale ?? 1.0
    property int dpi: QuickMorphism.dpi ?? 2
}
