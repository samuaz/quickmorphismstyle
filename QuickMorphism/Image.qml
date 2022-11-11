import QtQuick

Image {
    id: root
    width: 120
    height: 120
    property alias elevation: elevation
    property double radius: Math.min(width, height) / 2
    asynchronous: true
    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    Elevation {
        id: elevation
        width: root.width
        height: root.height
        radius: root.radius
        pressed: true
        opacity: root.shadowOpacity
    }
}
