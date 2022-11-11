pragma Singleton

import QtQuick

QtObject {
    property QtObject theme: LightTheme
    property double dpScale: 1.0
    property int dpi: 0
}
