import QtQuick
import QuickMorphism 1.0

Item {
    id: root
    property QtObject theme: LightTheme
    property double dpScale: 1.0
    property int dpi: 0

    StatusBar {
        id: statusBar
        theme: theme.style
        navBarColor: root.theme.navBarColor
        statusBarColor: root.theme.statusBarColor
    }

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
        statusBar.theme = root.theme.style
        statusBar.statusBarColor = root.theme.statusBarColor
        statusBar.navBarColor = root.theme.navBarColor
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

