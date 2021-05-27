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

    QuickMorphismUI {
        id: quickMorphismUI
        theme: LightTheme
    }

    MainForm {
        id: form
        anchors.fill: parent

        themeSwitch {
            onCheckedChanged: themeSwitch.checked ? quickMorphismUI.theme
                                                    = DarkTheme : quickMorphismUI.theme = LightTheme
        }

        snackbarButton {
            onClicked: function (){
                QuickMorphismSnackBar.message = "I'm snackbar"
                QuickMorphismSnackBar.show = true
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

