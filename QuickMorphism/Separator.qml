import QtQuick

Item {
    id: control

    property bool vertical: false
    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    implicitHeight: vertical ? 200 : 3 * QuickMorphismConfig.dpScale
    implicitWidth: vertical ? 3 * QuickMorphismConfig.dpScale : 200

    // Dark line (top for horizontal, left for vertical)
    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: control.vertical ? undefined : parent.right
        anchors.bottom: control.vertical ? parent.bottom : undefined
        width: control.vertical ? 1 : undefined
        height: control.vertical ? undefined : 1
        color: QuickMorphismConfig.theme.bottonShadowColor
        opacity: control.shadowOpacity * 0.6
    }

    // Light line (bottom for horizontal, right for vertical)
    Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: control.vertical ? undefined : parent.left
        anchors.top: control.vertical ? parent.top : undefined
        width: control.vertical ? 1 : undefined
        height: control.vertical ? undefined : 1
        color: QuickMorphismConfig.theme.topShadowColor
        opacity: control.shadowOpacity * 0.4
    }
}
