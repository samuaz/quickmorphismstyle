import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Timeline 1.0
import QtQuick.Templates 2.15 as T

T.CheckBox {
    id: control
    property alias elevation: elevation
    property int radius: 5

    implicitWidth: Math.max(
                       background ? background.implicitWidth : 0,
                       contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(
                        background ? background.implicitHeight : 0, Math.max(
                            contentItem.implicitHeight,
                            indicator ? indicator.implicitHeight : 0) + topPadding + bottomPadding)

    spacing: 10
    padding: 8
    verticalPadding: padding + 7
    text: qsTr("checkbox")
    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity
    icon.color: !enabled ? QuickMorphismConfig.theme.hintTextColor : QuickMorphismConfig.theme.primaryTextColor

    Elevation {
        id: elevation
        width: control.indicator.implicitWidth
        height: control.indicator.implicitHeight
        radius: control.radius
        pressed: true
        x: indicator.x
        y: indicator.y
        z: -1
        opacity: control.shadowOpacity
    }

    indicator: Rectangle {
        id: indicator
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding
                          + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 20 * QuickMorphismConfig.dpScale
        implicitHeight: 20 * QuickMorphismConfig.dpScale
        radius: control.radius
        color: QuickMorphismConfig.theme.foregroundColor

        Rectangle {
            id: indicatorBackground
            width: parent.implicitWidth - 0
            height: parent.implicitHeight - 0
            radius: control.radius
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: control.checked ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.foregroundColor
            visible: control.checked

            FontAwesomeRegular {
                id: indicatorchecker
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                fontSizeMode: "Fit"
                anchors.fill: parent
                symbol: Icons.faCheck
                font.weight: Font.Bold
                color: QuickMorphismConfig.theme.foregroundColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                visible: control.checked
                width: parent.width
                height: parent.height
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
        enabled: false
        startFrame: 0
        endFrame: 1000

        KeyframeGroup {
            target: indicatorBackground
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
