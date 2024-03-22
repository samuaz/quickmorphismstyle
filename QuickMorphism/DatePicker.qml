import QtQuick
import QtQuick.Controls 1.5
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: control
    property color color: QuickMorphismConfig.theme.accentColor
    property color textColor: QuickMorphismConfig.theme.primaryTextColor
    property alias valid: textDate.acceptableInput
    property string placeholderText: qsTr("Date")
    property alias dateString: textDate
    property alias calendar: cal
    property var days
    property var months
    property var years
    property var date
    height: textDate.height

    Component.onCompleted: {
        var now = new Date()
        date = new Date()
        days = creteTumbler(1, 31)
        months = creteTumbler(1, 12)
        years = creteTumbler(1900, now.getFullYear())
    }

    function creteTumbler(start, end) {
        var y = []
        while (end >= start) {
            y.push(end--)
        }
        return y
    }

    function showCalendar() {
        if (cal.visible) {
            cal.visible = false
            Config.dimContainer = false
        } else {
            cal.visible = true
            Config.dimContainer = true
        }
    }

    TextField {
        id: textDate
        placeholderText: control.placeholderText
        width: parent.width

        validator: RegExpValidator {
            regExp: /([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/
        }

        MouseArea {
            anchors.fill: parent
            onClicked: showCalendar()
        }

        Button {
            id: button
            width: textDate.height - 10
            height: textDate.height - 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: textDate.right
            anchors.rightMargin: 3
            FontAwesomeRegular {
                id: indicatorchecker
                fontSizeMode: "Fit"
                symbol: Icons.faCalendar
                font.weight: Font.Bold
                color: QuickMorphismConfig.theme.primaryTextColor
                text: "\uf133"
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: showCalendar()
            flat: true
        }
    }

    Popup {
        id: cal
        parent: Overlay.overlay
        y: parent.height - cal.height
        width: parent.width
        height: 200
        visible: false
        dim: true
        background: Rectangle {
            id: bg
            color: QuickMorphismConfig.theme.backgroundColor
            border.width: 0
            anchors.fill: parent
            radius: 40

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                width: parent.width
                height: parent.radius
                color: QuickMorphismConfig.theme.backgroundColor
            }

            MouseArea {
                anchors.fill: parent
                onClicked: showCalendar()
            }

            Item {
                id: element
                anchors.fill: parent

                Item {
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height / 2
                    Button {
                        id: close
                        anchors.left: parent.left
                        anchors.top: parent.top

                        FontAwesomeRegular {
                            font.pixelSize: 15
                            symbol: Icons.faTimes
                            font.weight: Font.Bold
                            color: control.textColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        onClicked: {
                            cal.visible = false
                        }
                        flat: true
                    }

                    Button {
                        anchors.left: parent.left
                        anchors.top: close.bottom
                        anchors.topMargin: 10
                        FontAwesomeRegular {
                            font.pixelSize: 15
                            symbol: Icons.faCheck
                            font.weight: Font.Bold
                            color: QuickMorphismConfig.theme.primaryTextColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        onClicked: {
                            date.setDate(days[daysTumbler.currentIndex])
                            date.setMonth(
                                        months[monthsTumbler.currentIndex] - 1)
                            date.setYear(years[yearsTumbler.currentIndex])

                            textDate.text = Qt.formatDate(date, "yyyy-MM-dd")
                            cal.visible = false
                        }
                        flat: true
                    }
                }
            }
        }

        Row {
            id: row
            spacing: 1
            anchors.horizontalCenter: parent.horizontalCenter

            Tumbler {
                id: daysTumbler
                Label {
                    text: "Day"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    anchors.fill: parent
                }
                model: days
                delegate: Label {
                    text: modelData
                    horizontalAlignment: Text.AlignHCenter
                    opacity: 1.0 - Math.abs(
                                 Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 3)
                    color: days[daysTumbler.currentIndex] === modelData ? QuickMorphismConfig.theme.hintTextColor : QuickMorphismConfig.theme.primaryTextColor
                }
            }

            Tumbler {
                Label {
                    text: "Month"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    anchors.fill: parent
                }
                id: monthsTumbler
                model: months
                delegate: Label {
                    text: modelData
                    horizontalAlignment: Text.AlignHCenter
                    opacity: 1.0 - Math.abs(
                                 Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 3)
                    color: months[monthsTumbler.currentIndex]
                           === modelData ? QuickMorphismConfig.theme.hintTextColor : QuickMorphismConfig.theme.primaryTextColor
                }
            }

            Tumbler {
                Label {
                    text: "Year"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignTop
                    anchors.fill: parent
                }
                id: yearsTumbler
                model: years
                delegate: Label {
                    text: modelData
                    horizontalAlignment: Text.AlignHCenter
                    opacity: 1.0 - Math.abs(
                                 Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 3)
                    color: years[yearsTumbler.currentIndex]
                           === modelData ? QuickMorphismConfig.theme.hintTextColor : QuickMorphismConfig.theme.primaryTextColor
                }
            }
        }

        onClosed: {
            Config.dimContainer = false
        }
        enter: Transition {

            NumberAnimation {
                property: "y"
                from: main.height - 200 * -1
                to: main.height - 200
                duration: 250
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "y"
                from: main.height - 200
                to: main.height - 200 * -1
                duration: 250
            }
        }
    }
}
