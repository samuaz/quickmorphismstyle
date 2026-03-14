import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T

T.AbstractButton {
    id: control

    property bool checkable: true
    property bool closable: false
    property string icon_

    signal toggled(bool checked)
    signal closed()

    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity
    property int radius: height / 2

    implicitWidth: contentRow.implicitWidth + leftPadding + rightPadding
    implicitHeight: 36 * QuickMorphismConfig.dpScale

    leftPadding: 16 * QuickMorphismConfig.dpScale
    rightPadding: (closable ? 8 : 16) * QuickMorphismConfig.dpScale

    checkable: control.checkable

    onClicked: {
        if (control.checkable) {
            control.checked = !control.checked
            control.toggled(control.checked)
        }
    }

    background: Rectangle {
        color: QuickMorphismConfig.theme.foregroundColor
        radius: control.radius

        Elevation {
            id: elevation
            width: control.width
            height: control.height
            radius: control.radius
            pressed: control.checked
            opacity: control.shadowOpacity
        }
    }

    contentItem: Row {
        id: contentRow
        spacing: 6 * QuickMorphismConfig.dpScale
        anchors.verticalCenter: parent.verticalCenter

        FontAwesomeRegular {
            visible: control.icon_ !== ""
            symbol: control.icon_
            color: control.checked ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.hintTextColor
            font.pixelSize: 14 * QuickMorphismConfig.dpScale
            anchors.verticalCenter: parent.verticalCenter
        }

        T.Label {
            text: control.text
            font: control.font
            color: control.checked ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.hintTextColor
            anchors.verticalCenter: parent.verticalCenter
        }

        // Close button
        T.Label {
            visible: control.closable
            text: "\u2715"
            font.pixelSize: 12 * QuickMorphismConfig.dpScale
            color: QuickMorphismConfig.theme.hintTextColor
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                anchors.fill: parent
                anchors.margins: -4
                onClicked: control.closed()
            }
        }
    }

    states: [
        State {
            name: "chipChecked"
            when: control.checked
            PropertyChanges {
                target: elevation
                pressed: true
            }
        },
        State {
            name: "chipUnchecked"
            when: !control.checked
            PropertyChanges {
                target: elevation
                pressed: false
            }
        }
    ]
}
