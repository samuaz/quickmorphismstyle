import QtQuick
import QtQuick.Templates as T

T.TabBar {
    id: control

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 8 * QuickMorphismConfig.dpScale
    spacing: 8 * QuickMorphismConfig.dpScale

    contentItem: ListView {
        model: control.contentModel
        currentIndex: control.currentIndex

        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem

        highlightMoveDuration: 250
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 48
        preferredHighlightEnd: width - 48
    }

    background: Rectangle {
        color: QuickMorphismConfig.theme.foregroundColor
        radius: 10 * QuickMorphismConfig.dpScale

        Elevation {
            id: elevation
            width: control.width
            height: control.height
            radius: 10 * QuickMorphismConfig.dpScale
            pressed: true
            opacity: control.shadowOpacity
        }
    }
}
