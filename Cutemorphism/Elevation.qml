import QtQuick 2.15
import Cutemorphism 1.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Timeline 1.0

Item {
    id: root
    property int radius: 100
    property bool pressed: false
    property string topShadowColor: Cutemorphism.topShadowColor
    property string bottomShadowColor: Cutemorphism.bottonShadowColor
    property int pressedGlowRadius: 10
    property int normalGlowRadius: 5
    property double pressedSpread: 0.5
    property double normalSpread: 0.5
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
            glowRadius: root.pressedGlowRadius
            spread: root.pressedSpread
            color: root.topShadowColor
            anchors.leftMargin: 5
            anchors.topMargin: 5
            cornerRadius: root.radius + glowRadius
        }

        RectangularGlow {
            id: hoverBotton
            height: root.height
            width: root.width
            anchors.fill: parent
            glowRadius: root.pressedGlowRadius
            spread: root.pressedSpread
            color: root.bottomShadowColor
            anchors.rightMargin: 5
            anchors.bottomMargin: 5
            cornerRadius: root.radius + glowRadius
        }

        states: [
            State { when: pressed;
                PropertyChanges {   target: press; opacity: 1.0    }
            },
            State { when: !pressed;
                PropertyChanges {   target: press; opacity: 0.0    }
            }
        ]
        transitions: Transition {
            NumberAnimation { property: "opacity"; easing.bezierCurve: [0.47,0,0.745,0.715,1,1]; duration: 200}
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
            glowRadius: root.normalGlowRadius
            spread: root.normalSpread
            color: root.topShadowColor
            anchors.topMargin: -5
            anchors.leftMargin: -5
            cornerRadius: root.radius + glowRadius
        }

        RectangularGlow {
            id: normalBotton
            height: root.height
            width: root.width
            anchors.top: parent.top
            anchors.left: parent.left
            glowRadius: root.normalGlowRadius
            spread: root.normalSpread
            color: root.bottomShadowColor
            anchors.topMargin: 5
            anchors.leftMargin: 5
            cornerRadius: root.radius + glowRadius
        }
    }

    states: [
        State { when: pressed;
            PropertyChanges {   target: normal; opacity: 0.0    }
        },
        State { when: !pressed;
            PropertyChanges {   target: normal; opacity: 1.0    }
        }
    ]
    transitions: Transition {
        NumberAnimation { property: "opacity"; easing.bezierCurve: [0.39,0.575,0.565,1,1,1]; duration: 400}
    }
}




/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}
}
##^##*/
