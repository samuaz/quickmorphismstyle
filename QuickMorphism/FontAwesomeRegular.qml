import QtQuick
import QtQuick.Controls

Label {
    id: text
    property alias symbol: text.text
    font.family: Fonts.solid
    font.weight: Font.bold
}
