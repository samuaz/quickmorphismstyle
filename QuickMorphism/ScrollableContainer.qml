import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.1

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
                id: control
                visible: flickable.contentHeight > flickable.height
                anchors.top: parent.top
                anchors.topMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: parent.rightMargin - 10
                background: Rectangle {
                    color: "#00ffffff"
                }
                contentItem: Rectangle {
                    implicitWidth: 5
                    radius: width / 2
                    color: control.pressed ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.primaryColor
                }
                clip: true
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
                anchors.bottomMargin: root.contentPading
                visible: false
                onLoaded: {
                    flickable.contentHeight = mainContent ? mainContent.height + 50 : 0
                    flickable.visible = true
                    visible = true
                    //loading.show = false
                }

                onStatusChanged: {
                    if (status == Loader.Loading) {

                        //loading.show = true
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

