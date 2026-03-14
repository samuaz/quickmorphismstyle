import QtQuick
import QtQuick.Templates as T

T.Popup {
    id: control

    property string title
    property string message
    property bool closeOnOverlay: true

    default property alias bodyContent: bodyArea.data
    property alias footer: footerArea.data

    signal accepted()
    signal rejected()

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity
    property int radius: 16 * QuickMorphismConfig.dpScale

    modal: true
    anchors.centerIn: parent
    width: Math.min(300 * QuickMorphismConfig.dpScale, parent.width - 32 * QuickMorphismConfig.dpScale)
    padding: 24 * QuickMorphismConfig.dpScale

    T.Overlay.modal: Rectangle {
        color: Qt.rgba(0, 0, 0, 0.5)
    }

    background: Rectangle {
        color: QuickMorphismConfig.theme.foregroundColor
        radius: control.radius

        Elevation {
            id: elevation
            width: parent.width
            height: parent.height
            radius: control.radius
            pressed: false
            opacity: control.shadowOpacity
            shadowOffSet: 8
            shadowGlow: 16
        }
    }

    contentItem: Column {
        spacing: 12 * QuickMorphismConfig.dpScale

        T.Label {
            visible: control.title !== ""
            text: control.title
            font.bold: true
            font.pixelSize: 18 * QuickMorphismConfig.dpScale
            color: QuickMorphismConfig.theme.primaryTextColor
            width: parent.width
            wrapMode: Text.WordWrap
        }

        T.Label {
            visible: control.message !== ""
            text: control.message
            font.pixelSize: 14 * QuickMorphismConfig.dpScale
            color: QuickMorphismConfig.theme.hintTextColor
            width: parent.width
            wrapMode: Text.WordWrap
        }

        // Body slot
        Column {
            id: bodyArea
            width: parent.width
        }

        // Footer slot
        Row {
            id: footerArea
            width: parent.width
            spacing: 8 * QuickMorphismConfig.dpScale
            layoutDirection: Qt.RightToLeft
        }
    }

    enter: Transition {
        NumberAnimation {
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: 200
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            property: "scale"
            from: 0.95
            to: 1.0
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    exit: Transition {
        NumberAnimation {
            property: "opacity"
            from: 1.0
            to: 0.0
            duration: 150
            easing.type: Easing.InQuad
        }
        NumberAnimation {
            property: "scale"
            from: 1.0
            to: 0.95
            duration: 150
            easing.type: Easing.InQuad
        }
    }

    onClosed: {
        if (closeOnOverlay) {
            // Popup closed via overlay click
        }
    }
}
