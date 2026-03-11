import QtQuick
import QtQuick.Controls
import QuickMorphism

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 600
    title: "QuickMorphism Enum Usage Example"

    // Ejemplo 1: Usando el enum directamente
    QuickMorphismTheme {
        id: customDarkTheme
        style: QuickMorphismStyle.DARK  // ✅ Uso del enum
        backgroundColor: "#2b2b2b"
        foregroundColor: "#2b2b2b"
        primaryTextColor: "#ffffff"
        secondaryTextColor: "#cccccc"
        hintTextColor: "#888888"
        topShadowColor: "#404040"
        bottonShadowColor: "#1a1a1a"
        primaryColor: "#3498db"
        accentColor: "#e74c3c"
    }

    QuickMorphismTheme {
        id: customLightTheme
        style: QuickMorphismStyle.LIGHT  // ✅ Uso del enum
        backgroundColor: "#f0f0f0"
        foregroundColor: "#f0f0f0"
        primaryTextColor: "#333333"
        secondaryTextColor: "#666666"
        hintTextColor: "#999999"
        topShadowColor: "#ffffff"
        bottonShadowColor: "#d0d0d0"
        primaryColor: "#2980b9"
        accentColor: "#27ae60"
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "QuickMorphism Enum Examples"
            font.pixelSize: 24
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Ejemplo 2: Comparación de estilos
        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: "Current Theme Style: "
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: {
                    if (LightTheme.style === QuickMorphismStyle.LIGHT) {
                        return "LIGHT"
                    } else if (LightTheme.style === QuickMorphismStyle.DARK) {
                        return "DARK"
                    } else {
                        return "UNKNOWN"
                    }
                }
                font.bold: true
                color: LightTheme.style === QuickMorphismStyle.LIGHT ? "#2980b9" : "#e74c3c"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Ejemplo 3: Botones con diferentes estilos
        Column {
            spacing: 15
            anchors.horizontalCenter: parent.horizontalCenter

            Button {
                text: "Light Theme Button"
                // Aquí puedes aplicar estilos basados en el enum
                enabled: LightTheme.style === QuickMorphismStyle.LIGHT
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Button {
                text: "Dark Theme Button"
                enabled: DarkTheme.style === QuickMorphismStyle.DARK
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        // Ejemplo 4: StatusBar con enum
        StatusBar {
            id: statusBar
            // Usando el enum para el tema
            theme: QuickMorphismStyle.LIGHT === 0 ? StatusBar.Light : StatusBar.Dark
            statusBarColor: LightTheme.backgroundColor
        }

        // Información de debug
        Rectangle {
            width: 300
            height: 150
            color: "#f8f8f8"
            border.color: "#ddd"
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5

                Text {
                    text: "Debug Info:"
                    font.bold: true
                }

                Text {
                    text: "QuickMorphismStyle.LIGHT = " + QuickMorphismStyle.LIGHT
                    font.family: "monospace"
                }

                Text {
                    text: "QuickMorphismStyle.DARK = " + QuickMorphismStyle.DARK
                    font.family: "monospace"
                }

                Text {
                    text: "LightTheme.style = " + LightTheme.style
                    font.family: "monospace"
                }

                Text {
                    text: "DarkTheme.style = " + DarkTheme.style
                    font.family: "monospace"
                }
            }
        }
    }
}