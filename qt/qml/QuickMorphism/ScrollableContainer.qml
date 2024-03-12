import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: root
    anchors.fill: parent
    property Item mainContent
    property alias source: container
    property int contentPading: 15

    Component.onCompleted: {
        container.sourceComponent = content
    }

    Component.onDestruction: {
        container.sourceComponent = null
    }

    Component {
        id: content
        Item {
            anchors.fill: parent
            children: mainContent
        }
    }

    Rectangle {
        id: maincontainer
        color: QuickMorphismConfig.theme.backgroundColor
        anchors.fill: parent
        border.width: 0

        Flickable {
            id: flickable
            width: parent.width
            height: parent.height
            maximumFlickVelocity: 20000
            flickDeceleration: 2000
            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            visible: false
            clip: true
            ScrollBar.vertical: ScrollBar {
                id: scrollbar
                visible: flickable.contentHeight > flickable.height
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: parent.rightMargin
                background: Rectangle {
                    color: "#00ffffff"
                }
                contentItem: Rectangle {
                    id: scrollbarIndicator
                    implicitWidth: 2
                    radius: width / 2
                    color: scrollbar.pressed ? QuickMorphismConfig.theme.bottonShadowColor : QuickMorphismConfig.theme.backgroundColor
                }
                //clip: true
            }

            Loader {
                id: container
                asynchronous: true
                anchors.fill: parent
                anchors.top: parent.top
                anchors.topMargin: root.contentPading
                anchors.left: parent.left
                anchors.leftMargin: root.contentPading
                anchors.right: parent.right
                anchors.rightMargin: root.contentPading
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                visible: false
                onLoaded: {
                    flickable.contentHeight = mainContent ? mainContent.height : 0
                    flickable.visible = true
                    visible = true
                    //loading.show = false
                }

                onStatusChanged: {
                    if (status == Loader.Loading) {
                        loading.show = true;
                    }
                    if(status == Loader.Ready) {
                        loading.show = false;
                    }
                }
            }

            onDragStarted: {
                scrollbarIndicator.color = QuickMorphismConfig.theme.bottonShadowColor
            }

            onDragEnded: {
                scrollbarIndicator.color = QuickMorphismConfig.theme.backgroundColor
            }


            /*
            onContentYChanged: {
                var contentPosition = (flickable.visibleArea.yPosition * flickable.height)

                if (contentPosition > 50) {
                    if (TocHeader.height !== TocHeader.minHeight) {
                        TocHeader.height = TocHeader.minHeight
                    }
                } else {
                    if (TocHeader.height != TocHeader.maxHeight) {
                        TocHeader.height = TocHeader.maxHeight
                    }
                }
            }

            */
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

