import QtQuick 2.15
import QuickMorphism 1.0

Item {
    id: root
    property QtObject theme: LightTheme
    property double dpScale: 1.0
    property int dpi: 0

    onThemeChanged: {
        changeTheme()
    }

    onDpScaleChanged: {
        QuickMorphismConfig.dpScale = root.dpScale
    }

    onDpiChanged: {
        QuickMorphismConfig.dpi = root.dpi
    }

    Connections {
        target: QuickMorphism

        function onThemeChanged(signalTheme) {
            root.theme = signalTheme
        }

        function onDpiChanged(signalDpi) {
            root.dpi = signalDpi
        }

        function onDpScaleChanged(signalDpScale) {
            root.dpScale = signalDpScale
        }
    }

    function changeTheme() {
        QuickMorphismConfig.theme = root.theme
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

