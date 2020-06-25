import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.1

Item {
    anchors.fill: parent
    property Item mainContent
    property alias source: container

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
        color: QuickMorphismUI.theme.backgroundColor
        anchors.fill: parent
        border.width: 0

        Flickable {
            id: flickable
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: 24
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
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
                anchors.rightMargin: 10
                background: Rectangle {
                    color: "#00ffffff"
                }
                contentItem: Rectangle {
                    implicitWidth: 5
                    radius: width / 2
                    color: control.pressed ? QuickMorphismUI.theme.accentColor : QuickMorphismUI.theme.primaryColor
                }
            }

            Loader {
                id: container
                asynchronous: true
                anchors.fill: parent
                anchors.top: parent.top
                anchors.topMargin: 24
                anchors.left: parent.left
                //anchors.leftMargin: MainContent.margin
                anchors.right: parent.right
                //anchors.rightMargin: MainContent.margin
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
