import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Templates as T

Card {
    id: control

    contentPadding: 0

    property string userName
    property string userInitial
    property string cardTitle
    property int imageHeight: 200 * QuickMorphismConfig.dpScale
    property string placeholderIcon: "\uf3c5"
    property bool favoritable: false
    property bool favorited: false
    property string badgeText
    property string badgeColor: QuickMorphismConfig.theme.accentColor

    signal favoriteClicked()

    default property alias bodyContent: bodyArea.data

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 0

        // Image area with overlay
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: control.imageHeight
            color: QuickMorphismConfig.theme.highlightedColor
            radius: control.radius
            clip: true

            // Cover bottom rounded corners
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: parent.radius
                color: parent.color
            }

            // Placeholder icon
            T.Label {
                anchors.centerIn: parent
                text: control.placeholderIcon
                font.family: Fonts.fontAwesomeSolid.name
                font.pixelSize: 40
                color: QuickMorphismConfig.theme.hintTextColor
                opacity: 0.3
            }

            // Gradient dim overlay
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: parent.height * 0.6
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: Qt.rgba(0, 0, 0, 0.55) }
                }
            }

            // User + title overlay
            ColumnLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 12
                spacing: 4

                RowLayout {
                    spacing: 8
                    visible: control.userName !== ""

                    Rectangle {
                        width: 28
                        height: 28
                        radius: 14
                        color: QuickMorphismConfig.theme.accentColor

                        T.Label {
                            anchors.centerIn: parent
                            text: control.userInitial
                            font.pixelSize: 12
                            font.bold: true
                            color: QuickMorphismConfig.theme.backgroundColor
                        }
                    }

                    T.Label {
                        text: control.userName
                        font.pixelSize: 13
                        font.bold: true
                        color: "white"
                    }
                }

                T.Label {
                    text: control.cardTitle
                    font.pixelSize: 18
                    font.bold: true
                    color: "white"
                    Layout.fillWidth: true
                    wrapMode: Text.WordWrap
                    visible: control.cardTitle !== ""
                }
            }

            // Badge (price, FREE, etc.)
            Rectangle {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 8
                anchors.rightMargin: 8
                width: badgeLabel.width + 16
                height: 28
                radius: 14
                color: control.badgeColor
                visible: control.badgeText !== ""

                T.Label {
                    id: badgeLabel
                    anchors.centerIn: parent
                    text: control.badgeText
                    font.pixelSize: 12
                    font.bold: true
                    color: QuickMorphismConfig.theme.backgroundColor
                }
            }

            // Favorite button
            Rectangle {
                anchors.top: parent.top
                anchors.right: control.badgeText !== "" ? undefined : parent.right
                anchors.left: control.badgeText !== "" ? parent.left : undefined
                anchors.topMargin: 8
                anchors.rightMargin: 8
                anchors.leftMargin: 8
                width: 36
                height: 36
                radius: 18
                color: Qt.rgba(0, 0, 0, 0.3)
                visible: control.favoritable

                T.Label {
                    anchors.centerIn: parent
                    text: control.favorited ? "\uf004" : "\uf08a"
                    font.family: control.favorited
                        ? Fonts.fontAwesomeSolid.name
                        : Fonts.fontAwesomeRegular.name
                    font.pixelSize: 16
                    color: control.favorited
                        ? QuickMorphismConfig.theme.accentColor
                        : "white"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: control.favoriteClicked()
                }
            }
        }

        // Body content area
        ColumnLayout {
            id: bodyArea
            Layout.fillWidth: true
            Layout.leftMargin: 12
            Layout.rightMargin: 12
            Layout.topMargin: 12
            Layout.bottomMargin: 16
            spacing: 8
        }
    }
}
