import QtQuick 2.15
import QtQuick.Controls 2.15
import QuickMorphism 1.0

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 360
    height: 640

    title: qsTr("Cutemorphism Style")

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
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

