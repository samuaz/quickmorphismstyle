import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T

Item {
    id: control

    property int currentIndex: 0
    property list<QtObject> tabs
    property double shadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    // The index of the special center button (-1 for none)
    property int centerButtonIndex: -1

    // Floating margins
    property int floatingMargin: 12 * QuickMorphismConfig.dpScale
    property int floatingRadius: 20 * QuickMorphismConfig.dpScale

    signal tabClicked(int index)

    implicitHeight: 72 * QuickMorphismConfig.dpScale + floatingMargin
    implicitWidth: 400

    // Floating pill background
    Rectangle {
        id: bg
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: control.floatingMargin
        anchors.rightMargin: control.floatingMargin
        anchors.bottomMargin: control.floatingMargin
        height: 64 * QuickMorphismConfig.dpScale
        radius: control.floatingRadius
        color: QuickMorphismConfig.theme.foregroundColor

        Elevation {
            width: parent.width
            height: parent.height
            radius: parent.radius
            pressed: false
            opacity: control.shadowOpacity
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 8 * QuickMorphismConfig.dpScale
            anchors.rightMargin: 8 * QuickMorphismConfig.dpScale
            spacing: 0

            Repeater {
                model: control.tabs

                Item {
                    id: tabItem

                    required property QtObject modelData
                    required property int index

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    property bool isActive: control.currentIndex === tabItem.index
                    property bool isCenter: control.centerButtonIndex === tabItem.index

                    // Center button (elevated, circular, accent)
                    Rectangle {
                        id: centerBtn
                        visible: tabItem.isCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: -16 * QuickMorphismConfig.dpScale
                        width: 52 * QuickMorphismConfig.dpScale
                        height: 52 * QuickMorphismConfig.dpScale
                        radius: 26 * QuickMorphismConfig.dpScale
                        color: QuickMorphismConfig.theme.accentColor

                        Elevation {
                            width: parent.width
                            height: parent.height
                            radius: parent.radius
                            pressed: false
                            opacity: control.shadowOpacity
                        }

                        T.Label {
                            anchors.centerIn: parent
                            text: tabItem.modelData.icon || ""
                            font.family: Fonts.fontAwesomeSolid.name
                            font.pixelSize: 22 * QuickMorphismConfig.dpScale
                            color: QuickMorphismConfig.theme.backgroundColor
                        }
                    }

                    // Normal tab (icon + label)
                    ColumnLayout {
                        visible: !tabItem.isCenter
                        anchors.centerIn: parent
                        spacing: 2 * QuickMorphismConfig.dpScale

                        T.Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: tabItem.modelData.icon || ""
                            font.family: Fonts.fontAwesomeSolid.name
                            font.pixelSize: 18 * QuickMorphismConfig.dpScale
                            color: tabItem.isActive ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.hintTextColor
                        }

                        T.Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: tabItem.modelData.label || ""
                            font.pixelSize: 10 * QuickMorphismConfig.dpScale
                            color: tabItem.isActive ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.hintTextColor
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            control.currentIndex = tabItem.index
                            control.tabClicked(tabItem.index)
                        }
                    }
                }
            }
        }
    }
}
