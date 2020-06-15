import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.15 as T
import QtQuick.Controls.impl 2.12

T.TextField {
    id: control
    property alias elevation: elevation

    //font: Constants.font
    property int radius: 5

    implicitWidth: implicitBackgroundWidth + leftInset + rightInset || Math.max(
                       contentWidth,
                       placeholder.implicitWidth) + leftPadding + rightPadding
    implicitHeight: Math.max(
                        implicitBackgroundHeight + topInset + bottomInset,
                        contentHeight + topPadding + bottomPadding,
                        placeholder.implicitHeight + topPadding + bottomPadding)

    verticalAlignment: TextInput.AlignVCenter
    padding: 10

    placeholderText: qsTr("Description")
    placeholderTextColor: QuickMorphismConfig.theme.hintTextColor
    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText
                 && (!control.activeFocus
                     || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    Elevation {
        id: elevation
        width: control.width
        height: control.height
        radius: control.radius
        pressed: true
        z: -2
        opacity: control.shadowOpacity
    }

    background: Rectangle {
        id: background
        color: QuickMorphismConfig.theme.foregroundColor
        radius: control.radius
        implicitHeight: 38 * QuickMorphismConfig.dpScale
        implicitWidth: 200 * QuickMorphismConfig.dpScale
    }

    cursorVisible: false
    color: !control.enabled ? QuickMorphismConfig.theme.hintTextColor : QuickMorphismConfig.theme.primaryTextColor
    selectByMouse: true
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
        acceptedButtons: Qt.NoButton
    }

    states: [
        State {
            name: "on"
            when: control.focus
            PropertyChanges {
                target: background
                border.color: QuickMorphismConfig.theme.highlightedColor
            }
        },
        State {
            name: "off"
            when: !control.focus
            PropertyChanges {
                target: background
                border.color: QuickMorphismConfig.theme.foregroundColor
            }
        }
    ]
}
