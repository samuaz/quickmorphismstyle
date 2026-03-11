import QtQuick

Item {
    id: root
    property QtObject theme
    property double dpScale: 1.0
    property int dpi: 0

    StatusBar {
        id: statusBar
        theme: root.theme ? root.theme.style : StatusBar.Light
        navBarColor: root.theme ? root.theme.navBarColor : "transparent"
        statusBarColor: root.theme ? root.theme.statusBarColor : "transparent"
    }

    onThemeChanged: {
        if (root.theme)
            changeTheme()
    }

    onDpScaleChanged: {
        if (typeof QuickMorphism !== "undefined" && QuickMorphism !== null)
            QuickMorphism.dpScale = root.dpScale
        QuickMorphismConfig.dpScale = root.dpScale
    }

    onDpiChanged: {
        if (typeof QuickMorphism !== "undefined" && QuickMorphism !== null)
            QuickMorphism.dpi = root.dpi
        QuickMorphismConfig.dpi = root.dpi
    }

    function changeTheme() {
        // Sync C++ singleton
        if (typeof QuickMorphism !== "undefined" && QuickMorphism !== null)
            QuickMorphism.theme = root.theme

        // Sync QML Config singleton (this propagates to all components)
        QuickMorphismConfig.theme = root.theme

        // Update platform StatusBar
        if (root.theme) {
            statusBar.theme = root.theme.style
            statusBar.statusBarColor = root.theme.statusBarColor
            statusBar.navBarColor = root.theme.navBarColor
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
