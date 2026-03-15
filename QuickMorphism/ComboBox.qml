import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl

T.ComboBox {
    id: control

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity
    property int radius: 5

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    leftPadding: 16 * QuickMorphismConfig.dpScale
    rightPadding: 40 * QuickMorphismConfig.dpScale
    topPadding: 10 * QuickMorphismConfig.dpScale
    bottomPadding: 10 * QuickMorphismConfig.dpScale

    font.pixelSize: 16 * QuickMorphismConfig.dpScale

    indicator: T.Label {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding + 8 * QuickMorphismConfig.dpScale
        y: control.topPadding + (control.availableHeight - height) / 2
        text: control.popup.visible ? "\u25B2" : "\u25BC"
        font.pixelSize: 10 * QuickMorphismConfig.dpScale
        color: QuickMorphismConfig.theme.hintTextColor
    }

    contentItem: T.Label {
        text: control.displayText
        font: control.font
        color: control.enabled ? QuickMorphismConfig.theme.primaryTextColor : QuickMorphismConfig.theme.hintTextColor
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Item {
        implicitHeight: 38 * QuickMorphismConfig.dpScale
        implicitWidth: 200 * QuickMorphismConfig.dpScale

        Rectangle {
            id: bgRect
            anchors.fill: parent
            color: QuickMorphismConfig.theme.foregroundColor
            radius: control.radius
        }

        // When popup is open, fill bottom corners to merge with popup
        Rectangle {
            visible: control.popup.visible
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: control.radius
            color: QuickMorphismConfig.theme.foregroundColor
        }

        Elevation {
            id: elevation
            width: control.popup.visible ? parent.width : parent.width
            height: control.popup.visible ? parent.height + control.popup.height : parent.height
            radius: control.radius
            pressed: true
            opacity: control.shadowOpacity
        }
    }

    delegate: T.ItemDelegate {
        id: delegateItem
        width: ListView.view ? ListView.view.width : implicitWidth
        height: 40 * QuickMorphismConfig.dpScale
        leftPadding: 16 * QuickMorphismConfig.dpScale

        contentItem: T.Label {
            text: control.textRole ? (Array.isArray(control.model) ? modelData : model[control.textRole]) : modelData
            font: control.font
            color: delegateItem.highlighted ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.primaryTextColor
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            color: delegateItem.highlighted ? QuickMorphismConfig.theme.highlightedColor : QuickMorphismConfig.theme.foregroundColor
        }

        highlighted: control.highlightedIndex === index
    }

    popup: T.Popup {
        y: control.height
        width: control.width
        height: Math.min(contentItem.implicitHeight + topPadding + bottomPadding, 300 * QuickMorphismConfig.dpScale)
        topPadding: 0
        bottomPadding: 4 * QuickMorphismConfig.dpScale

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            boundsBehavior: Flickable.StopAtBounds
        }

        background: Item {
            Rectangle {
                anchors.fill: parent
                color: QuickMorphismConfig.theme.foregroundColor
                radius: control.radius
            }

            // Fill top corners to merge with ComboBox above
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                height: control.radius
                color: QuickMorphismConfig.theme.foregroundColor
            }

            // Subtle separator line
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.leftMargin: 12 * QuickMorphismConfig.dpScale
                anchors.rightMargin: 12 * QuickMorphismConfig.dpScale
                height: 1
                color: QuickMorphismConfig.theme.highlightedColor
            }
        }
    }
}
