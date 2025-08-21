import QtQuick
import QtQuick.Controls
import QuickMorphism 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: "QuickMorphism Enum Usage Example"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "QuickMorphism Enum Examples"
            font.pointSize: 18
            color: QuickMorphismConfig.theme.primaryTextColor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Example 1: Using enums for style comparison
        QuickMorphism.Button {
            text: "Current Theme: " + QuickMorphismStyle.getStyleName(QuickMorphismConfig.theme.style)
            anchors.horizontalCenter: parent.horizontalCenter
            
            onClicked: {
                console.log("Current style value:", QuickMorphismConfig.theme.style)
                console.log("Is light theme:", QuickMorphismStyle.isLightStyle(QuickMorphismConfig.theme.style))
                console.log("Is dark theme:", QuickMorphismStyle.isDarkStyle(QuickMorphismConfig.theme.style))
            }
        }

        // Example 2: Theme switching using enums
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            QuickMorphism.Button {
                text: "Light Theme"
                enabled: QuickMorphismConfig.theme.style !== QuickMorphismStyle.light
                
                onClicked: {
                    console.log("Switching to light theme (enum value:", QuickMorphismStyle.light, ")")
                    QuickMorphismConfig.theme = LightTheme
                }
            }

            QuickMorphism.Button {
                text: "Dark Theme"
                enabled: QuickMorphismConfig.theme.style !== QuickMorphismStyle.dark
                
                onClicked: {
                    console.log("Switching to dark theme (enum value:", QuickMorphismStyle.dark, ")")
                    QuickMorphismConfig.theme = DarkTheme
                }
            }
        }

        // Example 3: Conditional styling based on enums
        Rectangle {
            width: 200
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 15
            
            // Dynamic color based on current theme using enum comparison
            color: {
                switch(QuickMorphismConfig.theme.style) {
                    case QuickMorphismStyle.light:
                        return "#E0E5EC"
                    case QuickMorphismStyle.dark:
                        return "#243441"
                    case QuickMorphismStyle.styleFilled:
                        return "#007ACC"
                    default:
                        return "#E0E5EC"
                }
            }
            
            Text {
                anchors.centerIn: parent
                text: "Dynamic Color\nBased on Enum"
                color: QuickMorphismConfig.theme.primaryTextColor
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Example 4: Using helper functions
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: {
                var style = QuickMorphismConfig.theme.style
                var styleName = QuickMorphismStyle.getStyleName(style)
                var isLight = QuickMorphismStyle.isLightStyle(style)
                var isDark = QuickMorphismStyle.isDarkStyle(style)
                
                return "Style: " + styleName + 
                       " | Light: " + isLight + 
                       " | Dark: " + isDark
            }
            color: QuickMorphismConfig.theme.secondaryTextColor
        }

        // Example 5: All available enum values
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            Text {
                text: "Available Enum Values:"
                font.bold: true
                color: QuickMorphismConfig.theme.primaryTextColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "QuickMorphismStyle.light = " + QuickMorphismStyle.light
                color: QuickMorphismConfig.theme.secondaryTextColor
                font.family: "Courier"
            }

            Text {
                text: "QuickMorphismStyle.dark = " + QuickMorphismStyle.dark
                color: QuickMorphismConfig.theme.secondaryTextColor
                font.family: "Courier"
            }

            Text {
                text: "QuickMorphismStyle.styleFilled = " + QuickMorphismStyle.styleFilled
                color: QuickMorphismConfig.theme.secondaryTextColor
                font.family: "Courier"
            }

            Text {
                text: "QuickMorphismStyle.auto = " + QuickMorphismStyle.auto
                color: QuickMorphismConfig.theme.secondaryTextColor
                font.family: "Courier"
            }
        }
    }
}