import QtQuick 2.15
import QtQuick.Controls 2.15

Label {
    id: text
    property alias symbol: text.text
    font.family: Fonts.solid
    font.weight: Font.bold
}
