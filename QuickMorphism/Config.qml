pragma Singleton

import QtQuick 2.15

QtObject {
    property QtObject theme: LightTheme
    property double dpScale: 1.0
    property int dpi: 0
}
