import QtQuick 2.15
import QtQuick.Controls 2.15
import Cutemorphism 1.0
import QtQuick.Templates 2.15 as T

Image {
    id: root
    property double radius: 100
    width: 120
    height: 120
    asynchronous: true

    Elevation {
        id: shadow
        width: root.width
        height: root.height
        radius: root.radius
        pressed: true
    }
}
