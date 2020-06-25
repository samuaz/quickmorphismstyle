import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Timeline 1.0
import QtQuick.Templates 2.15 as T

T.ToolButton {
    id: control
    property alias elevation: elevation

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity
    property int radius: Math.min(width, height) / 2
    property int shadowOffSet: 3
    font.capitalization: Font.MixedCase

    topInset: 0
    bottomInset: 0
    padding: 10
    horizontalPadding: padding - 4
    spacing: 6
    icon.width: 32
    icon.height: 32
    icon.color: !enabled ? QuickMorphismConfig.theme.hintTextColor : checked
                           || highlighted ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.primaryTextColor

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font
        color: !control.enabled ? QuickMorphismConfig.theme.hintTextColor : control.checked
                                  || control.highlighted ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.primaryTextColor
    }

    Elevation {
        id: elevation
        width: control.width
        height: control.height
        radius: control.radius
        pressed: false
        opacity: control.shadowOpacity
        visible: !control.flat
        shadowOffSet: control.shadowOffSet
    }

    background: Rectangle {
        color: QuickMorphismConfig.theme.foregroundColor
        radius: control.radius
        implicitWidth: 32 * QuickMorphismConfig.dpScale
        implicitHeight: 32 * QuickMorphismConfig.dpScale
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
