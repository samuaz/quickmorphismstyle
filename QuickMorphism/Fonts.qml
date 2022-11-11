pragma Singleton

import QtQuick

Item {

    id: fonts

    readonly property FontLoader fontAwesomeRegular: FontLoader {
        source: "./assets/font/fa-regular-400.ttf"
    }
    readonly property FontLoader fontAwesomeSolid: FontLoader {
        source: "./assets/font/fa-solid-900.ttf"
    }
    readonly property FontLoader fontAwesomeBrands: FontLoader {
        source: "./assets/font/fa-brands-400.ttf"
    }

    readonly property string icons: fonts.fontAwesomeRegular.name
    readonly property string solid: fonts.fontAwesomeSolid.name
    readonly property string brands: fonts.fontAwesomeBrands.name
}
