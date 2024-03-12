import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    id: snackbar
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0
    width: parent.width
    height: 50
    color: QuickMorphismConfig.theme.accentColor
    anchors.top: parent.top
    anchors.topMargin: 0
    visible: QuickMorphismSnackBar.show
    Timer {
        id: hideSnackBar
        interval: 5000
        running: false
        repeat: false
        onTriggered: {
            snackbarMessage.close()
            QuickMorphismSnackBar.show = false
        }
    }
    Popup {
        id: snackbarMessage
        bottomPadding: 2
        topPadding: 2
        dim: true
        padding: 0
        background: Rectangle {
            color: QuickMorphismConfig.theme.statusBarColor
        }
        contentHeight: parent.height
        contentWidth: parent.width
        modal: true
        focus: false
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        visible: QuickMorphismSnackBar.show
        contentItem: Text {
            id: snackbarMessageText
            text: QuickMorphismSnackBar.message
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.left: parent.right
            anchors.leftMargin: 0
            anchors.right: parent.left
            anchors.rightMargin: 0
            color: QuickMorphismConfig.theme.primaryTextColor
        }

        onClosed: {
            QuickMorphismSnackBar.show = false
        }

        onAboutToShow: {
            hideSnackBar.running = true
        }
    }

    layer.enabled: true
    layer.effect: DropShadow {
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        spread: 0.3
        samples: 5
        fast: true
        cached: true
        transparentBorder: true
        color: "#19000000"
    }
}
