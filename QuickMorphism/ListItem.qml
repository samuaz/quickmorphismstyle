import QtQuick
import QtQuick.Templates as T

Item {
    id: control

    property string text
    property string secondaryText
    property string icon
    property url iconSource
    property bool showDivider: false
    property bool clickable: true

    default property alias trailing: trailingArea.data

    signal clicked()

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity
    property int radius: 8 * QuickMorphismConfig.dpScale

    implicitWidth: 280 * QuickMorphismConfig.dpScale
    implicitHeight: Math.max(56 * QuickMorphismConfig.dpScale,
                             contentRow.implicitHeight + 24 * QuickMorphismConfig.dpScale)

    Rectangle {
        id: bg
        anchors.fill: parent
        color: QuickMorphismConfig.theme.foregroundColor
        radius: control.radius

        Elevation {
            id: elevation
            width: control.width
            height: control.height
            radius: control.radius
            pressed: false
            opacity: control.shadowOpacity
        }
    }

    Row {
        id: contentRow
        anchors.fill: parent
        anchors.leftMargin: 16 * QuickMorphismConfig.dpScale
        anchors.rightMargin: 16 * QuickMorphismConfig.dpScale
        anchors.topMargin: 12 * QuickMorphismConfig.dpScale
        anchors.bottomMargin: 12 * QuickMorphismConfig.dpScale
        spacing: 12 * QuickMorphismConfig.dpScale

        // Leading: icon area
        Item {
            id: leadingArea
            width: 40 * QuickMorphismConfig.dpScale
            height: width
            anchors.verticalCenter: parent.verticalCenter
            visible: control.icon !== "" || control.iconSource.toString() !== ""

            Rectangle {
                anchors.fill: parent
                radius: width / 2
                color: QuickMorphismConfig.theme.highlightedColor
                visible: control.icon !== "" && control.iconSource.toString() === ""

                FontAwesomeRegular {
                    anchors.centerIn: parent
                    symbol: control.icon
                    color: QuickMorphismConfig.theme.primaryTextColor
                    font.pixelSize: 16 * QuickMorphismConfig.dpScale
                }
            }

            Image {
                anchors.fill: parent
                source: control.iconSource
                fillMode: Image.PreserveAspectCrop
                visible: control.iconSource.toString() !== ""
                layer.enabled: true
                layer.effect: Item {
                    Rectangle {
                        anchors.fill: parent
                        radius: width / 2
                    }
                }
            }
        }

        // Content: text area
        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - leadingArea.width - trailingArea.width
                   - (leadingArea.visible ? parent.spacing : 0)
                   - (trailingArea.children.length > 0 ? parent.spacing : 0)

            T.Label {
                text: control.text
                font.pixelSize: 14 * QuickMorphismConfig.dpScale
                color: QuickMorphismConfig.theme.primaryTextColor
                width: parent.width
                elide: Text.ElideRight
            }

            T.Label {
                visible: control.secondaryText !== ""
                text: control.secondaryText
                font.pixelSize: 12 * QuickMorphismConfig.dpScale
                color: QuickMorphismConfig.theme.hintTextColor
                width: parent.width
                elide: Text.ElideRight
                topPadding: 2 * QuickMorphismConfig.dpScale
            }
        }

        // Trailing slot
        Item {
            id: trailingArea
            width: childrenRect.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // Divider
    Rectangle {
        visible: control.showDivider
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 16 * QuickMorphismConfig.dpScale
        anchors.rightMargin: 16 * QuickMorphismConfig.dpScale
        height: 1
        color: QuickMorphismConfig.theme.highlightedColor
        opacity: 0.3
    }

    MouseArea {
        anchors.fill: parent
        enabled: control.clickable
        onClicked: control.clicked()
        onPressed: elevation.pressed = true
        onReleased: elevation.pressed = false
        onCanceled: elevation.pressed = false
    }
}
