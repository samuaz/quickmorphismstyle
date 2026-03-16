import QtQuick
import QtQuick.Templates as T

Item {
    id: control

    property string title
    property string subtitle
    property url imageSource
    property int radius: 12 * QuickMorphismConfig.dpScale
    property bool elevation: true
    property bool clickable: false
    property double contentPadding: 16 * QuickMorphismConfig.dpScale
    property alias elevation_: elevation_

    default property alias content: bodyArea.data

    signal clicked()

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    implicitWidth: 280 * QuickMorphismConfig.dpScale
    implicitHeight: contentColumn.implicitHeight

    Rectangle {
        id: bg
        anchors.fill: parent
        color: QuickMorphismConfig.theme.foregroundColor
        radius: control.radius

        Elevation {
            id: elevation_
            width: control.width
            height: control.height
            radius: control.radius
            pressed: false
            opacity: control.shadowOpacity
            visible: control.elevation
        }
    }

    Column {
        id: contentColumn
        anchors.left: parent.left
        anchors.right: parent.right

        // Image header
        Item {
            id: headerItem
            width: parent.width
            height: control.imageSource.toString() !== "" ? 160 * QuickMorphismConfig.dpScale : 0
            visible: control.imageSource.toString() !== ""
            clip: true

            Image {
                anchors.fill: parent
                source: control.imageSource
                fillMode: Image.PreserveAspectCrop

                // Round top corners only
                layer.enabled: true
                layer.effect: Item {
                    property alias radius: mask.radius
                    Rectangle {
                        id: mask
                        anchors.fill: parent
                        radius: control.radius
                        // Hide bottom radius by extending below
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: control.radius
                            color: parent.color
                        }
                    }
                }
            }
        }

        // Body content
        Column {
            id: bodyArea
            width: parent.width
            padding: control.contentPadding

            T.Label {
                visible: control.title !== ""
                text: control.title
                font.bold: true
                font.pixelSize: 16 * QuickMorphismConfig.dpScale
                color: QuickMorphismConfig.theme.primaryTextColor
                width: parent.width - parent.padding * 2
                wrapMode: Text.WordWrap
            }

            T.Label {
                visible: control.subtitle !== ""
                text: control.subtitle
                font.pixelSize: 13 * QuickMorphismConfig.dpScale
                color: QuickMorphismConfig.theme.hintTextColor
                width: parent.width - parent.padding * 2
                wrapMode: Text.WordWrap
                topPadding: 4 * QuickMorphismConfig.dpScale
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: control.clickable
        onClicked: control.clicked()
        onPressed: {
            if (control.clickable)
                elevation_.pressed = true
        }
        onReleased: {
            if (control.clickable)
                elevation_.pressed = false
        }
        onCanceled: {
            if (control.clickable)
                elevation_.pressed = false
        }
    }

}
