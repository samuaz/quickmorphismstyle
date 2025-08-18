import QtQuick
import QtQuick.Controls 1.4
import QtQuick.Controls
import QtQuick.Layouts
import QuickMorphism

Item {
    id: control
    
    // Use QuickMorphismConfig.theme for colors
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    property string color: currentTheme ? currentTheme.accentColor : "#7CB342"
    property string textColor: currentTheme ? currentTheme.primaryTextColor : "#666666"
    property string placeholder: qsTr("Date")
    property alias calendar: mainForm

    function showCalendar() {
        if (mainForm.visible) {
            mainForm.visible = false
        } else {
            mainForm.visible = true
        }
    }

    height: 40
    width: 150

    Rectangle {
        id: background
        anchors.fill: parent
        color: currentTheme ? currentTheme.foregroundColor : "#E0E5EC"
        radius: 15

        // Neumorphism effect for calendar picker
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            
            // Outer shadow (dark)
            Rectangle {
                x: 3; y: 3
                width: parent.width
                height: parent.height
                radius: parent.radius
                color: currentTheme ? currentTheme.bottonShadowColor : "#A3B1C6"
                opacity: 0.3
                z: -2
            }
            
            // Inner highlight (light)
            Rectangle {
                x: -3; y: -3
                width: parent.width
                height: parent.height
                radius: parent.radius
                color: currentTheme ? currentTheme.topShadowColor : "#FFFFFF"
                opacity: 0.4
                z: -1
            }
        }

        Text {
            id: dateText
            text: control.placeholder
            color: control.textColor
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: control.showCalendar()
        }
    }

    Calendar {
        id: mainForm
        visible: false
        anchors.top: background.bottom
        anchors.topMargin: 5
        width: 300
        height: 200
        z: 1000
    }
}