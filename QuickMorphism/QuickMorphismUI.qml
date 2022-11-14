import QtQuick
import QuickMorphism 1.0

Item {
    id: root
    property QtObject theme
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
            console.log("llamando a cambiar theme");
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
        console.log("seteando theme")
        console.log(root.theme.name)
        QuickMorphism.theme = root.theme;
        //QuickMorphismConfig.theme = root.theme;
        statusBar.theme = root.theme.style;
        statusBar.statusBarColor = root.theme.statusBarColor;
        statusBar.navBarColor = root.theme.navBarColor;
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

