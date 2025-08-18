import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 360
    width: 360
    height: 640

    title: qsTr("QuickMorphism Style Demo")

    // QuickMorphism Light theme background by default
    // The controls will automatically use QuickMorphism style with proper neumorphic colors
    color: "#E0E5EC"

    MainForm {
        id: form
        anchors.fill: parent

        themeSwitch {
            onCheckedChanged: {
                // Theme switching: changes the global theme that affects all controls
                if (themeSwitch.checked) {
                    // Dark mode
                    window.color = "#2b2b2b"
                    // Note: The style components will automatically adapt to dark theme
                    // when the global theme system is properly connected
                } else {
                    // Light mode
                    window.color = "#E0E5EC"
                }
                console.log("Theme switch toggled:", themeSwitch.checked ? "Dark" : "Light")
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



