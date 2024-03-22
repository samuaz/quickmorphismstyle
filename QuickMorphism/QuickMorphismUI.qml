import QtQuick
import QuickMorphism

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
        QuickMorphism.dpScale = root.dpScale
        QuickMorphismConfig.dpScale = QuickMorphism.dpScale
    }

    onDpiChanged: {
        QuickMorphism.dpi = root.dpi
        QuickMorphismConfig.theme = QuickMorphism.dpi
    }

    function changeTheme() {
        QuickMorphism.theme = root.theme;
        QuickMorphismConfig.theme = QuickMorphism.theme
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

