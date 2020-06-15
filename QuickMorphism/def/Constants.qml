pragma Singleton

import QtQuick 2.15

QtObject {
    readonly property int width: 480
    readonly property int height: 960

    readonly property FontLoader mySystemFont: FontLoader {
        name: "Reem"
    }

    property alias fontDirectory: directoryFontLoader.fontDirectory
    property alias relativeFontDirectory: directoryFontLoader.relativeFontDirectory

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             "family": mySystemFont.name,
                                             "pixelSize": Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  "family": mySystemFont.name,
                                                  "pixelSize": Qt.application.font.pixelSize * 1.6
                                              })

    property var darkTheme: ({
                                 "topShadow": "#293a46",
                                 "bottonShadow": "#092836",
                                 "background": "#243441",
                                 "foreground": "#ebebeb",
                                 "accent": "#0affef",
                                 "primary": "#c2c2c2",
                                 "highlighter": "#c2c2c2",
                                 "hover": "#c2c2c2"
                             })

    property int baseSize: 10
    readonly property int smallSize: 10
    readonly property int largeSize: 16

    /* background */
    readonly property color backgroundColor: "#243441"

    /* shadows */
    readonly property color topShadowColor: "#293a46"
    readonly property color bottonShadowColor: "#092836"

    /* primary colors */
    readonly property color primaryColor: "#0affef"
    readonly property color primaryLight: "#c2c2c2"
    readonly property color primaryDark: "#c2c2c2"

    /* secundary colors */
    readonly property color secondaryColor: "#ffffff"
    readonly property color secondaryLight: "#c2c2c2"
    readonly property color secondaryDark: "#c2c2c2"

    /* text colors */
    readonly property color textPrimaryColor: "#ebebeb"
    readonly property color textPrimaryColorDisable: "#959EA8"
    readonly property color textSecondaryColor: "#c2c2c2"
    readonly property color textSecondaryColorDisable: "#c2c2c2"

    /* controls colors */
    readonly property color controlsBackgroundColor: "#243441"
    readonly property color controlsBackgroundSecondaryColor: "#959EA8"
    readonly property color controlsHighlighterColor: "#959EA8"
    readonly property color controlsDisabledColor: "#959EA8"
    readonly property color controlsHoverColor: "#ffffff"

    property DirectoryFontLoader directoryFontLoader: DirectoryFontLoader {
        id: directoryFontLoader
    }
}
