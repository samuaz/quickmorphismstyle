import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Templates as T

T.ProgressBar {
    id: control

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    background: Rectangle {
        implicitWidth: 200 * QuickMorphismConfig.dpScale
        implicitHeight: 8 * QuickMorphismConfig.dpScale
        color: QuickMorphismConfig.theme.foregroundColor
        radius: height / 2

        Elevation {
            id: elevation
            width: parent.width
            height: parent.height
            radius: parent.radius
            pressed: true
            opacity: control.shadowOpacity
        }
    }

    contentItem: Item {
        implicitWidth: 200 * QuickMorphismConfig.dpScale
        implicitHeight: 8 * QuickMorphismConfig.dpScale

        Rectangle {
            id: fillBar
            width: control.indeterminate ? parent.width * 0.3
                                         : control.visualPosition * parent.width
            height: parent.height
            radius: height / 2
            color: QuickMorphismConfig.theme.accentColor

            x: control.indeterminate ? 0 : 0

            RectangularGlow {
                anchors.fill: parent
                glowRadius: 4
                spread: 0.2
                color: QuickMorphismConfig.theme.accentColor
                cornerRadius: parent.radius + glowRadius
                opacity: 0.3
            }

            // Determinate animation
            Behavior on width {
                enabled: !control.indeterminate
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }

            // Indeterminate animation
            SequentialAnimation on x {
                running: control.indeterminate
                loops: Animation.Infinite
                NumberAnimation {
                    from: 0
                    to: control.width - fillBar.width
                    duration: 1200
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    from: control.width - fillBar.width
                    to: 0
                    duration: 1200
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
