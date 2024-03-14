import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T
import QtQuick.Controls.impl

T.TextField {
    id: control
    property alias elevation: elevation
    property string errorMessage
    property alias required: required
    property bool isRequired: false
    property bool isPassword: false

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

    onTextChanged: control.acceptableInput ? color
                                             = QuickMorphismConfig.theme.primaryTextColor : color
                                             = QuickMorphismConfig.theme.errorColor

    Required {
        id: required
        show: isRequired
        errorMsg: control.errorMessage
        showErrorMsg: !control.acceptableInput || !control.text.length
        color: !control.acceptableInput
               && !control.text.length ? QuickMorphismConfig.theme.primaryTextColor : !control.acceptableInput
                                         && control.text.length ? QuickMorphismConfig.theme.errorColor : control.acceptableInput && control.text ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.primaryTextColor
    }

    T.Button {
        id: showPassword
        visible: isPassword
        flat: true
        anchors.right: parent.right
        anchors.rightMargin: 20
        width: parent.height
        height: parent.height
        checked: false
        checkable: true
        background: Rectangle {

            color: "transparent"
        }
        FontAwesomeRegular {
            id: indicatorchecker
            fontSizeMode: "Fit"
            anchors.fill: parent
            symbol: Icons.faEye
            font.weight: Font.Bold
            color: showPassword.checked ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.primaryTextColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        onCheckedChanged: {

            showPassword.checked ? control.echoMode = TextInput.Normal : control.echoMode
                                   = TextInput.Password
        }
    }

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

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

