import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Timeline

Item {
    id: root
    property int radius: Math.min(width, height) / 2
    property bool pressed: false
    property string topShadowColor: QuickMorphismConfig.theme.topShadowColor
    property string bottomShadowColor: QuickMorphismConfig.theme.bottonShadowColor
    property int insetShadowGlow: QuickMorphismConfig.theme.insetShadowGlow
    property int shadowGlow: QuickMorphismConfig.theme.shadowGlow
    property double insetShadowSpread: QuickMorphismConfig.theme.insetShadowSpread
    property double shadowSpread: QuickMorphismConfig.theme.shadowSpread
    property int shadowOffSet: QuickMorphismConfig.theme.shadowOffSet
    opacity: QuickMorphismConfig.theme.shadowOpacity
    property int insetCornerRadius: root.radius + root.insetShadowGlow
    property int cornerRadius: root.radius + root.shadowGlow
    z: -1

    Item {
        id: press
        visible: root.pressed
        anchors.fill: parent
        RectangularGlow {
            id: hoverTop
            height: root.height
            width: root.width
            anchors.fill: parent
            glowRadius: root.insetShadowGlow
            spread: root.insetShadowSpread
            color: root.topShadowColor
            anchors.leftMargin: root.shadowOffSet
            anchors.topMargin: root.shadowOffSet
            cornerRadius: root.insetCornerRadius
        }

        RectangularGlow {
            id: hoverBotton
            height: root.height
            width: root.width
            anchors.fill: parent
            glowRadius: root.insetShadowGlow
            spread: root.insetShadowSpread
            color: root.bottomShadowColor
            anchors.rightMargin: root.shadowOffSet
            anchors.bottomMargin: root.shadowOffSet
            cornerRadius: root.insetCornerRadius
        }

        states: [
            State {
                when: pressed
                PropertyChanges {
                    target: press
                    opacity: 1.0
                }
            },
            State {
                when: !pressed
                PropertyChanges {
                    target: press
                    opacity: 0.0
                }
            }
        ]
        transitions: Transition {
            NumberAnimation {
                property: "opacity"
                easing.bezierCurve: [0.47, 0, 0.745, 0.715, 1, 1]
                duration: 200
            }
        }
    }

    Item {
        id: normal
        visible: !root.pressed

        RectangularGlow {
            id: normalTop
            height: root.height
            width: root.width
            anchors.top: parent.top
            anchors.left: parent.left
            glowRadius: root.shadowGlow
            spread: root.shadowSpread
            color: root.topShadowColor
            anchors.topMargin: -(root.shadowOffSet)
            anchors.leftMargin: -(root.shadowOffSet)
            cornerRadius: root.cornerRadius
        }

        RectangularGlow {
            id: normalBotton
            height: root.height
            width: root.width
            anchors.top: parent.top
            anchors.left: parent.left
            glowRadius: root.shadowGlow
            spread: root.shadowSpread
            color: root.bottomShadowColor
            anchors.topMargin: root.shadowOffSet
            anchors.leftMargin: root.shadowOffSet
            cornerRadius: root.cornerRadius
        }
    }

    states: [
        State {
            when: pressed
            PropertyChanges {
                target: normal
                opacity: 0.0
            }
        },
        State {
            when: !pressed
            PropertyChanges {
                target: normal
                opacity: 1.0
            }
        }
    ]
    transitions: Transition {
        NumberAnimation {
            property: "opacity"
            easing.bezierCurve: [0.39, 0.575, 0.565, 1, 1, 1]
            duration: 400
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}
}
##^##*/

