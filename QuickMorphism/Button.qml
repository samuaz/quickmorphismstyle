import QtQuick
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Timeline
import QtQuick.Templates as T

T.Button {
    id: control
    property alias elevation: elevation

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topInset: 0
    bottomInset: 0
    topPadding: 10
    bottomPadding: 10
    rightPadding: 20
    leftPadding: 20
    horizontalPadding: padding - 4
    spacing: 6
    icon.width: 24
    icon.height: 24

    icon.color: !enabled ? QuickMorphismConfig.theme.hintTextColor : control.flat ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.primaryTextColor

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    property int radius: Math.min(width, height) / 2
    font.capitalization: Font.MixedCase

    Elevation {
        id: elevation
        width: control.width
        height: control.height
        radius: control.radius
        pressed: false
        opacity: control.shadowOpacity
        visible: !control.flat
    }

    background: Rectangle {
        color: QuickMorphismConfig.theme.foregroundColor
        radius: control.radius
        implicitWidth: 100 * QuickMorphismConfig.dpScale
        implicitHeight: 38 * QuickMorphismConfig.dpScale
    }

    contentItem: IconLabel {
        icon: control.icon
        text: control.text
        font: control.font
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        color: !control.enabled ? QuickMorphismConfig.theme.hintTextColor : control.flat ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.primaryTextColor
    }

    states: [
        State {
            name: "buttonPressed"
            when: control.down
            PropertyChanges {
                target: elevation
                pressed: control.down
            }
        },
        State {
            name: "buttonChecked"
            when: control.checked
            PropertyChanges {
                target: elevation
                pressed: control.checked
            }
        }
    ]
}
