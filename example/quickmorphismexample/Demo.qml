import QtQuick 2.15
import QtQuick.Controls 2.15
import QuickMorphism 1.0

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 360
    width: 360
    height: 640

    title: qsTr("Cutemorphism Style")


    SnackBar {
        id: snackBar

    }

    QuickMorphismLightTheme {
    id: lightTheme
    }

    QuickMorphismDarkTheme {
    id: darkTheme
    }

    QuickMorphismUI {
        id: quickMorphismUI
        theme: lightTheme
    }

    MainForm {
        id: form
        anchors.fill: parent

        themeSwitch {
            onCheckedChanged: themeSwitch.checked ? quickMorphismUI.theme
                                                    = darkTheme : quickMorphismUI.theme = lightTheme
        }

        snackbarButton {
            onClicked: function (){
                QuickMorphismSnackBar.message = "I'm snackbar"
                QuickMorphismSnackBar.show = true
            }
        }
    }

    Connections {
        target: QuickMorphism

        function onThemeChanged(signalTheme) {
            console.log("llamando a cambiar theme");
            //root.theme = signalTheme
        }

        function onDpiChanged(signalDpi) {
            //root.dpi = signalDpi
        }

        function onDpScaleChanged(signalDpScale) {
            //root.dpScale = signalDpScale
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

