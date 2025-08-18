import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Timeline
import QuickMorphism

Item {
    id: root
    property int radius: Math.min(width, height) / 2
    property bool pressed: false
    
    // Use QuickMorphismConfig.theme for colors and properties
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    property string topShadowColor: currentTheme ? currentTheme.topShadowColor : "#FFFFFF"
    property string bottomShadowColor: currentTheme ? currentTheme.bottonShadowColor : "#A3B1C6"
    property int insetShadowGlow: currentTheme ? currentTheme.insetShadowGlow : 10
    property int shadowGlow: currentTheme ? currentTheme.shadowGlow : 5
    property double insetShadowSpread: currentTheme ? currentTheme.insetShadowSpread : 0.5
    property double shadowSpread: currentTheme ? currentTheme.shadowSpread : 0.5
    property int shadowOffSet: currentTheme ? currentTheme.shadowOffSet : 5
    
    opacity: currentTheme ? currentTheme.shadowOpacity : 1.0
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