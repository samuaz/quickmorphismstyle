import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import Cutemorphism 1.0
import QtQuick.Timeline 1.0
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15


T.SwitchDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight,
                             implicitIndicatorHeight)

    readonly property int baseSize: 10
    property int radius: 100
    icon.width: 24
    icon.height: 24
    padding: 12
    spacing: 12
    leftPadding: 4

    Elevation {
        id: shadow
        width: switchHandle.implicitWidth
        height: switchHandle.implicitHeight
        radius: control.radius
        pressed: true
        z: -1
        x: switchHandle.x
        y: switchHandle.y
    }



    indicator: PaddedRectangle {
        id: switchHandle
        implicitWidth: Cutemorphism.baseSize * 5.6
        implicitHeight: Cutemorphism.baseSize * 2.8
        x: control.text ? (control.mirrored ? control.leftPadding : control.width - width - control.rightPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        color: Cutemorphism.backgroundColor
        anchors.verticalCenter: parent.verticalCenter
        radius: control.radius

        Elevation {
            id: interruptorshadow
            width: interruptor.width
            height: interruptor.height
            radius: interruptor.radius
            pressed: false
            pressedSpread: 0.8
            z: -1
            x:interruptor.x
            y:interruptor.y
            pressedGlowRadius: 1
        }

        Rectangle {
            id: interruptor
            width: switchHandle.height + 2
            height: switchHandle.height + 2
            radius: 100
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            color: Cutemorphism.controlsBackgroundSecondaryColor
            clip: true
        }
    }

    contentItem: IconLabel {
        leftPadding: control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: !control.mirrored ? control.indicator.width + control.spacing : 0
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: control.display === IconLabel.IconOnly || control.display === IconLabel.TextUnderIcon ? Qt.AlignCenter : Qt.AlignLeft
        icon: control.icon
        text: control.text
        font: control.font
        color: control.palette.text
        visible: control.text || control.icon
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
        enabled: true
        startFrame: 0
        endFrame: 1000

        KeyframeGroup {
            target: switchHandle
            property: "color"
            Keyframe {
                frame: 0
                value: Cutemorphism.backgroundColor
            }

            Keyframe {
                value: Cutemorphism.primaryColor
                frame: 1001
            }
        }

        KeyframeGroup {
            target: interruptor
            property: "x"
            Keyframe {
                frame: 0
                value: 0
            }

            Keyframe {
                value: switchHandle.implicitWidth - interruptor.width
                frame: 550
            }
        }
    }

    states: [
        State {
            name: "off"
            when: !control.checked && !control.down

            PropertyChanges {
                target: timeline
                enabled: true
            }

            PropertyChanges {
                target: toOffState
                running: true
            }
        },
        State {
            name: "on"
            when: control.checked && !control.down

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
            name: "off_down"
            when: !control.checked && control.down

            PropertyChanges {
                target: interruptor
                color: Cutemorphism.controlsHoverColor
            }
        },
        State {
            name: "on_down"
            when: control.checked && control.down

            PropertyChanges {
                target: interruptor
                x: parent.width - width
                color: Cutemorphism.controlsHoverColor
            }

            PropertyChanges {
                target: switchHandle
                color: Cutemorphism.primaryColor
            }
        }
    ]
}



