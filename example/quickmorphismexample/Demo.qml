import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 360
    width: 360
    height: 640

    title: qsTr("QuickMorphism Style Demo")

    MainForm {
        id: form
        anchors.fill: parent

        themeSwitch {
            onCheckedChanged: {
                // Toggle between light and dark mode
                if (themeSwitch.checked) {
                    window.palette.window = "#2b2b2b"  // Dark background
                    window.palette.windowText = "#ffffff"  // Light text
                } else {
                    window.palette.window = "#E0E5EC"  // Light background  
                    window.palette.windowText = "#333333"  // Dark text
                }
            }
        }

        snackbarButton {
            onClicked: function (){
                // Simple message instead of custom SnackBar
                console.log("Button clicked - SnackBar functionality would go here")
            }
        }
    }
}



