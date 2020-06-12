import QtQuick 2.15
import QtQuick.Controls 2.15
import Cutemorphism 1.0
import QtQuick.Timeline 1.0
import QtQuick.Templates 2.15 as T

T.CheckBox {
    id: control
    property int radius: 5

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    spacing: 10
    text: qsTr("checkbox")

    Elevation {
        id: shadow
        width: control.indicator.implicitWidth
        height: control.indicator.implicitHeight
        radius: control.radius
        pressed: true
        z: -1
    }

    background: Rectangle {
        color: "transparent"
        radius: control.radius
        implicitHeight: Cutemorphism.baseSize * 2.6
    }

    indicator: Rectangle {
        id: indicator
        implicitWidth: Cutemorphism.baseSize * 2.6
        implicitHeight: Cutemorphism.baseSize * 2.6
        radius: control.radius
        color: Cutemorphism.controlsBackgroundColor

        Rectangle {
            id: indicatorBackground
            width: parent.implicitWidth
            height: parent.implicitHeight
            radius: control.radius
            color: control.checked ? Cutemorphism.primaryColor : Cutemorphism.controlsBackgroundColor
            visible: control.checked
        }
    }

    contentItem: Text {
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.checked ? Cutemorphism.textPrimaryColor : Cutemorphism.textPrimaryColorDisable
        text: "checkbox"
        leftPadding: control.indicator.width + control.spacing
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: toOnState
                running: false
                loops: 1
                duration: 250
                to: 1000
                from: 0
            },

            TimelineAnimation {
                id: toOffState
                running: false
                loops: 1
                duration: 250
                to: 0
                from: 1000
            }
        ]
        enabled: false
        startFrame: 0
        endFrame: 1000

        KeyframeGroup {
            target: indicatorBackground
            property: "color"
            Keyframe {
                frame: 0
                value: Cutemorphism.controlsBackgroundColor
            }

            Keyframe {
                value: Cutemorphism.primaryColor
                frame: 1001
            }
        }

        KeyframeGroup {
            target: indicatorBackground
            property: "visible"
            Keyframe {
                frame: 0
                value: true
            }

            Keyframe {
                value: false
                frame: 1001
            }
        }
    }

    states: [
        State {
            name: "on"
            when: control.checked
            PropertyChanges {
                target: timeline
                enabled: true
            }

            PropertyChanges {
                target: toOnState
                running: true
            }
        },
        State {
            name: "off"
            when: !control.checked

            PropertyChanges {
                target: timeline
                enabled: true
            }

            PropertyChanges {
                target: toOffState
                running: true
            }
        }
    ]
}

