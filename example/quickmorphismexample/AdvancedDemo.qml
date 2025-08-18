import QtQuick
import QtQuick.Controls
import QuickMorphism  // Requires linking with QuickMorphism library

ApplicationWindow {
    id: window
    visible: true
    minimumWidth: 360
    width: 360
    height: 640
    title: qsTr("QuickMorphism Advanced Demo")

    // Advanced QuickMorphism integration with custom themes
    property bool isDarkMode: false
    
    // Use current theme background color
    color: quickMorphismUI.theme ? quickMorphismUI.theme.backgroundColor : "#E0E5EC"

    // Custom Light Theme
    QuickMorphismTheme {
        id: lightCustomTheme
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

    // Custom Dark Theme
    QuickMorphismTheme {
        id: darkCustomTheme
        style: QuickMorphismStyle.DARK
        backgroundColor: "#2b2b2b"
        foregroundColor: "#2b2b2b"
        primaryTextColor: "#ffffff"
        secondaryTextColor: "#ffffff"
        hintTextColor: "#888888"
        topShadowColor: "#404040"
        bottonShadowColor: "#1a1a1a"
        primaryColor: "#2b2b2b"
        secondaryColor: "#2b2b2b"
        accentColor: "#7CB342"
        errorColor: "#FF0000"
        highlightedColor: "#404040"
        hoverColor: "#7CB342"
        statusBarColor: "#2b2b2b"
        navBarColor: "#2b2b2b"
    }

    // QuickMorphism UI initializer - this makes themes available globally
    QuickMorphismUI {
        id: quickMorphismUI
        theme: isDarkMode ? darkCustomTheme : lightCustomTheme
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Advanced QuickMorphism Demo"
            font.pixelSize: 24
            font.bold: true
            color: quickMorphismUI.theme.primaryTextColor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Switch {
            id: themeSwitch
            text: "Dark Mode"
            anchors.horizontalCenter: parent.horizontalCenter
            
            onCheckedChanged: {
                // Dynamic theme switching
                isDarkMode = themeSwitch.checked
                // This automatically updates all QuickMorphism components
                quickMorphismUI.theme = isDarkMode ? darkCustomTheme : lightCustomTheme
            }
        }

        Button {
            text: "Neumorphic Button"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextField {
            placeholderText: "Neumorphic TextField"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        CheckBox {
            text: "Neumorphic CheckBox"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}