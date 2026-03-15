import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import QtQuick.Templates as T

TextField {
    id: control

    property var date: new Date()
    property double popupShadowOpacity: QuickMorphismConfig.theme.shadowOpacity

    property var days
    property var months
    property var years

    property string titleText: qsTr("Select Date")
    property string dayLabel: qsTr("Day")
    property string monthLabel: qsTr("Month")
    property string yearLabel: qsTr("Year")
    property string cancelText: qsTr("Cancel")
    property string confirmText: qsTr("Confirm")

    readOnly: true
    placeholderText: qsTr("Date")

    Component.onCompleted: {
        var now = new Date()
        date = new Date()
        days = createTumbler(1, 31)
        months = createTumbler(1, 12)
        years = createTumbler(1900, now.getFullYear())
    }

    function createTumbler(start, end) {
        var y = []
        while (end >= start) {
            y.push(end--)
        }
        return y
    }

    // Calendar icon
    T.Label {
        anchors.right: parent.right
        anchors.rightMargin: 12 * QuickMorphismConfig.dpScale
        anchors.verticalCenter: parent.verticalCenter
        text: "\uf133"
        font.family: Fonts.fontAwesomeRegular.name
        font.pixelSize: 16 * QuickMorphismConfig.dpScale
        color: QuickMorphismConfig.theme.hintTextColor
    }

    MouseArea {
        anchors.fill: parent
        onClicked: cal.open()
    }

    // Tumbler popup
    T.Popup {
        id: cal
        parent: Controls.Overlay.overlay
        x: parent ? Math.round((parent.width - width) / 2) : 0
        y: parent ? Math.round((parent.height - height) / 2) : 0
        width: 300 * QuickMorphismConfig.dpScale
        height: 360 * QuickMorphismConfig.dpScale
        modal: true
        dim: true

        T.Overlay.modal: Rectangle {
            color: Qt.rgba(0, 0, 0, 0.5)
        }

        background: Rectangle {
            color: QuickMorphismConfig.theme.backgroundColor
            radius: 16 * QuickMorphismConfig.dpScale
            border.color: QuickMorphismConfig.theme.highlightedColor
            border.width: 1
        }

        contentItem: ColumnLayout {
            spacing: 0

            // Header
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 48 * QuickMorphismConfig.dpScale

                T.Label {
                    anchors.centerIn: parent
                    text: control.titleText
                    font.pixelSize: 18 * QuickMorphismConfig.dpScale
                    font.bold: true
                    color: QuickMorphismConfig.theme.primaryTextColor
                }
            }

            Separator {
                Layout.fillWidth: true
                Layout.leftMargin: 16 * QuickMorphismConfig.dpScale
                Layout.rightMargin: 16 * QuickMorphismConfig.dpScale
            }

            // Column headers
            RowLayout {
                Layout.fillWidth: true
                Layout.topMargin: 8 * QuickMorphismConfig.dpScale
                Layout.leftMargin: 16 * QuickMorphismConfig.dpScale
                Layout.rightMargin: 16 * QuickMorphismConfig.dpScale
                spacing: 8 * QuickMorphismConfig.dpScale

                T.Label {
                    Layout.fillWidth: true
                    text: control.dayLabel
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 12 * QuickMorphismConfig.dpScale
                    color: QuickMorphismConfig.theme.hintTextColor
                }
                T.Label {
                    Layout.fillWidth: true
                    text: control.monthLabel
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 12 * QuickMorphismConfig.dpScale
                    color: QuickMorphismConfig.theme.hintTextColor
                }
                T.Label {
                    Layout.fillWidth: true
                    text: control.yearLabel
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 12 * QuickMorphismConfig.dpScale
                    color: QuickMorphismConfig.theme.hintTextColor
                }
            }

            // Tumblers in inset container
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.margins: 16 * QuickMorphismConfig.dpScale

                Rectangle {
                    anchors.fill: parent
                    color: QuickMorphismConfig.theme.foregroundColor
                    radius: 8 * QuickMorphismConfig.dpScale

                    Elevation {
                        width: parent.width
                        height: parent.height
                        radius: parent.radius
                        pressed: true
                        opacity: control.popupShadowOpacity
                    }

                    // Selection highlight band
                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width - 8 * QuickMorphismConfig.dpScale
                        height: 36 * QuickMorphismConfig.dpScale
                        radius: 6 * QuickMorphismConfig.dpScale
                        color: QuickMorphismConfig.theme.highlightedColor
                        opacity: 0.5
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 4 * QuickMorphismConfig.dpScale
                        spacing: 0

                        Controls.Tumbler {
                            id: daysTumbler
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: control.days
                            visibleItemCount: 5
                            delegate: T.Label {
                                text: modelData
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 16 * QuickMorphismConfig.dpScale
                                opacity: 1.0 - Math.abs(Controls.Tumbler.displacement) / (Controls.Tumbler.tumbler.visibleItemCount / 2)
                                color: QuickMorphismConfig.theme.primaryTextColor
                            }
                        }

                        Separator {
                            vertical: true
                            Layout.fillHeight: true
                            Layout.topMargin: 16 * QuickMorphismConfig.dpScale
                            Layout.bottomMargin: 16 * QuickMorphismConfig.dpScale
                        }

                        Controls.Tumbler {
                            id: monthsTumbler
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: control.months
                            visibleItemCount: 5
                            delegate: T.Label {
                                text: modelData
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 16 * QuickMorphismConfig.dpScale
                                opacity: 1.0 - Math.abs(Controls.Tumbler.displacement) / (Controls.Tumbler.tumbler.visibleItemCount / 2)
                                color: QuickMorphismConfig.theme.primaryTextColor
                            }
                        }

                        Separator {
                            vertical: true
                            Layout.fillHeight: true
                            Layout.topMargin: 16 * QuickMorphismConfig.dpScale
                            Layout.bottomMargin: 16 * QuickMorphismConfig.dpScale
                        }

                        Controls.Tumbler {
                            id: yearsTumbler
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            model: control.years
                            visibleItemCount: 5
                            delegate: T.Label {
                                text: modelData
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 16 * QuickMorphismConfig.dpScale
                                opacity: 1.0 - Math.abs(Controls.Tumbler.displacement) / (Controls.Tumbler.tumbler.visibleItemCount / 2)
                                color: QuickMorphismConfig.theme.primaryTextColor
                            }
                        }
                    }
                }
            }

            Separator {
                Layout.fillWidth: true
                Layout.leftMargin: 16 * QuickMorphismConfig.dpScale
                Layout.rightMargin: 16 * QuickMorphismConfig.dpScale
                Layout.topMargin: 8 * QuickMorphismConfig.dpScale
            }

            // Action buttons
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 56 * QuickMorphismConfig.dpScale
                Layout.leftMargin: 16 * QuickMorphismConfig.dpScale
                Layout.rightMargin: 16 * QuickMorphismConfig.dpScale
                Layout.topMargin: 4 * QuickMorphismConfig.dpScale
                Layout.bottomMargin: 8 * QuickMorphismConfig.dpScale
                spacing: 12 * QuickMorphismConfig.dpScale

                Item { Layout.fillWidth: true }

                Button {
                    text: control.cancelText
                    flat: true
                    font.pixelSize: 14 * QuickMorphismConfig.dpScale
                    onClicked: cal.close()
                }

                Button {
                    text: control.confirmText
                    font.pixelSize: 14 * QuickMorphismConfig.dpScale
                    font.bold: true
                    onClicked: {
                        control.date.setDate(control.days[daysTumbler.currentIndex])
                        control.date.setMonth(control.months[monthsTumbler.currentIndex] - 1)
                        control.date.setFullYear(control.years[yearsTumbler.currentIndex])
                        control.text = Qt.formatDate(control.date, "yyyy-MM-dd")
                        cal.close()
                    }
                }
            }
        }

        enter: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 200 }
                NumberAnimation { property: "scale"; from: 0.95; to: 1.0; duration: 200; easing.type: Easing.OutQuad }
            }
        }

        exit: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 150 }
                NumberAnimation { property: "scale"; from: 1.0; to: 0.95; duration: 150; easing.type: Easing.InQuad }
            }
        }
    }
}
