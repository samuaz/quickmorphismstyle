import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

T.TabButton {
    id: control

    property alias elevation: elevation
    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity
    property int radius: 10 * QuickMorphismConfig.dpScale

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 8 * QuickMorphismConfig.dpScale
    spacing: 6

    icon.width: 20
    icon.height: 20
    icon.color: !enabled ? QuickMorphismConfig.theme.hintTextColor
                         : checked ? QuickMorphismConfig.theme.accentColor
                                   : QuickMorphismConfig.theme.hintTextColor

    background: Rectangle {
        color: QuickMorphismConfig.theme.foregroundColor
        radius: control.radius
        implicitHeight: 40 * QuickMorphismConfig.dpScale

        Elevation {
            id: elevation
            width: control.width
            height: control.height
            radius: control.radius
            pressed: !control.checked
            opacity: control.checked ? control.shadowOpacity : 0
        }
    }

    contentItem: IconLabel {
        icon: control.icon
        text: control.text
        font: control.font
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        color: !control.enabled ? QuickMorphismConfig.theme.hintTextColor
                                : control.checked ? QuickMorphismConfig.theme.accentColor
                                                  : QuickMorphismConfig.theme.hintTextColor
    }

    states: [
        State {
            name: "tabActive"
            when: control.checked
            PropertyChanges {
                target: elevation
                pressed: false
                opacity: control.shadowOpacity
            }
        },
        State {
            name: "tabInactive"
            when: !control.checked
            PropertyChanges {
                target: elevation
                opacity: 0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation {
            properties: "opacity"
            duration: 250
            easing.type: Easing.InOutQuad
        }
    }
}
