import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls
import QtQuick.Controls.impl
import QtQuick.Timeline
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

T.Switch {
    id: control
    property alias elevation: elevation
    property int radius: Math.max(width, height) / 2
    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity
    property int indicatorWidth: 50
    property int indicatorheight: 20

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        implicitBackgroundHeight + topInset + bottomInset,
                        implicitContentHeight + topPadding + bottomPadding,
                        implicitIndicatorHeight + topPadding + bottomPadding)

    icon.width: 24
    icon.height: 24
    padding: 8
    spacing: 10

    icon.color: !enabled ? QuickMorphismConfig.theme.hintTextColor : QuickMorphismConfig.theme.primaryTextColor

    Elevation {
        id: elevation
        width: switchHandle.implicitWidth
        height: switchHandle.implicitHeight
        radius: control.radius
        pressed: true
        z: -1
        x: switchHandle.x
        y: switchHandle.y
        opacity: control.shadowOpacity
    }

    indicator: PaddedRectangle {
        id: switchHandle
        implicitWidth: indicatorWidth * QuickMorphismConfig.dpScale
        implicitHeight: indicatorheight * QuickMorphismConfig.dpScale
        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding
                  + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        color: QuickMorphismConfig.theme.foregroundColor
        anchors.verticalCenter: parent.verticalCenter
        radius: control.radius

        Elevation {
            id: interruptorElevation
            width: interruptor.width
            height: interruptor.height
            radius: interruptor.radius
            pressed: false
            z: -1
            x: interruptor.x
            y: interruptor.y
            opacity: control.shadowOpacity
            shadowOffSet: 0
        }

        Rectangle {
            id: interruptor
            width: switchHandle.implicitHeight + 5
            height: switchHandle.implicitHeight + 5
            radius: width / 2
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            color: QuickMorphismConfig.theme.highlightedColor
            border.color: QuickMorphismConfig.theme.bottonShadowColor
            border.width: 0

            Ripple {
                x: parent.x
                y: parent.y
                width: parent.width - 10
                height: parent.height - 10
                pressed: control.pressed
                active: control.down || control.visualFocus || control.hovered
                color: control.checked ? QuickMorphismConfig.theme.bottonShadowColor : QuickMorphismConfig.theme.bottonShadowColor
                opacity: 0.2
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    contentItem: IconLabel {
        leftPadding: control.indicator
                     && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator
                      && control.mirrored ? control.indicator.width + control.spacing : 0
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display
        alignment: control.display === IconLabel.IconOnly
                   || control.display === IconLabel.TextUnderIcon ? Qt.AlignCenter : Qt.AlignLeft
        icon: control.icon
        text: control.text
        font: control.font
        color: !control.enabled ? QuickMorphismConfig.theme.hintTextColor : QuickMorphismConfig.theme.primaryTextColor
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
                value: QuickMorphismConfig.theme.foregroundColor
            }

            Keyframe {
                value: QuickMorphismConfig.theme.accentColor
                frame: 1001
            }
        }

        KeyframeGroup {
            target: interruptor
            property: "x"
            Keyframe {
                frame: 0
                value: -2
            }

            Keyframe {
                value: switchHandle.implicitWidth - interruptor.width + 2
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
                color: QuickMorphismConfig.theme.foregroundColor
            }
        },
        State {
            name: "on_down"
            when: control.checked && control.down

            PropertyChanges {
                target: interruptor
                x: parent.width - width
                color: QuickMorphismConfig.theme.foregroundColor
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

