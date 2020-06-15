import QtQuick 2.15

Item {
    id: root
    width: 120
    height: 120
    property alias elevation: elevation
    property alias control: control
    property int radius: Math.max(width, height) / 2
    property bool pressed: true
    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    Elevation {
        id: elevation
        width: root.width
        height: root.height
        radius: root.radius
        pressed: root.pressed
        shadowSpread: 0.9
        insetShadowSpread: 0.9
        opacity: root.opacity
    }

    Rectangle {
        width: root.width - 5
        height: root.height - 5
        radius: root.radius
        color: QuickMorphismConfig.theme.foregroundColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: control
            asynchronous: true
            width: parent.width - 10
            height: parent.height - 10
            verticalAlignment: Image.AlignVCenter
            horizontalAlignment: Image.AlignHCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
