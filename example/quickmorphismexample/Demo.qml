import QtQuick 2.15
import QtQuick.Controls 2.15
import QuickMorphism

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

    /*
you can also create customs themes
*/
    QuickMorphismTheme {
     id: customTheme
     /*You need to always specify if you theme is light or dark*/
     style: QuickMorphismStyle.LIGHT
     backgroundColor: "#E0E5EC"
     foregroundColor: "#E0E5EC"
     primaryTextColor: "#666666"
     secondaryTextColor: "#666666"
     hintTextColor: "#A2A2A2"
     topShadowColor: "#FFFFFF"
     bottonShadowColor: "#A3B1C6"
     primaryColor: "#E0E5EC"
     secondaryColor: "#E0E5EC"
     accentColor: "#7CB342"
     errorColor: "#FF0000"
     highlightedColor: "#f4f4f4"
     hoverColor: "#7CB342"
     statusBarColor: "#E0E5EC"
     navBarColor: "#E0E5EC"
    }


    QuickMorphismUI {
        id: quickMorphismUI
        theme: DefaultQuickMorphismLightTheme
    }

    MainForm {
        id: form
        anchors.fill: parent

        themeSwitch {
            onCheckedChanged: themeSwitch.checked ? quickMorphismUI.theme
                                                    = DefaultQuickMorphismDarkTheme : quickMorphismUI.theme = DefaultQuickMorphismLightTheme
        checked: quickMorphismUI.theme.style == QuickMorphismStyle.DARK

        }

        snackbarButton {
            onClicked: function (){
                QuickMorphismSnackBar.message = "I'm snackbar"
                QuickMorphismSnackBar.show = true
            }
        }
    }

}



