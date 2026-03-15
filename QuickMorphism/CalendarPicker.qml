import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: control
    property color color: QuickMorphismConfig.theme.accentColor
    property color textColor: QuickMorphismConfig.theme.primaryTextColor
    property string placeholder: qsTr("Date")
    property alias calendar: mainForm

    function showCalendar() {
        mainForm.visible = !mainForm.visible
    }

    TextField {
        id: textDate
        placeholderText: control.placeholder
        width: parent.width
        MouseArea {
            anchors.fill: parent
            onClicked: showCalendar()
        }
    }

    Button {
        id: button
        width: textDate.height - 10 * QuickMorphismConfig.dpScale
        height: textDate.height - 10 * QuickMorphismConfig.dpScale
        anchors.right: textDate.right
        anchors.rightMargin: 0
        FontAwesomeRegular {
            id: indicatorchecker
            font.pixelSize: parent.width - 15 * QuickMorphismConfig.dpScale
            symbol: Icons.faCalendar
            font.weight: Font.Bold
            color: QuickMorphismConfig.theme.primaryTextColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        onClicked: showCalendar()
        flat: true
    }

    Rectangle {
        id: mainForm
        height: cellSize * 12
        width: cellSize * 8
        property double mm: Screen.pixelDensity
        property double cellSize: mm * 7
        property int fontSizePx: cellSize * 0.32
        property var date: new Date(calendarView.currentYear,
                                    calendarView.currentMonth, calendarView.currentDay)
        signal ok
        signal cancel
        visible: false
        color: QuickMorphismConfig.theme.backgroundColor

        Rectangle {
            id: titleOfDate
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            height: 2.5 * mainForm.cellSize
            width: parent.width
            color: QuickMorphismConfig.theme.highlightedColor
            z: 2
            Rectangle {
                id: selectedYear
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                height: mainForm.cellSize * 1
                color: parent.color
                Label {
                    id: yearTitle
                    anchors.fill: parent
                    leftPadding: mainForm.cellSize * 0.5
                    topPadding: mainForm.cellSize * 0.5
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: mainForm.fontSizePx * 1.7
                    opacity: yearsList.visible ? 1 : 0.7
                    color: QuickMorphismConfig.theme.primaryTextColor
                    text: calendarView.currentYear
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        yearsList.show()
                    }
                }
            }
            Label {
                id: selectedWeekDayMonth
                anchors {
                    left: parent.left
                    right: parent.right
                    top: selectedYear.bottom
                    bottom: parent.bottom
                }
                leftPadding: mainForm.cellSize * 0.5
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: height * 0.5
                text: calendarView.weekNames[calendarView.week].slice(
                          0, 3) + ", " + calendarView.currentDay + " "
                      + calendarView.months[calendarView.currentMonth].slice(0, 3)
                color: QuickMorphismConfig.theme.primaryTextColor
                opacity: yearsList.visible ? 0.7 : 1
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        yearsList.hide()
                    }
                }
            }
        }

        ListView {
            id: calendarView
            anchors {
                top: titleOfDate.bottom
                left: parent.left
                right: parent.right
                leftMargin: mainForm.cellSize * 0.5
                rightMargin: mainForm.cellSize * 0.5
            }
            height: mainForm.cellSize * 8
            visible: true
            z: 1

            snapMode: ListView.SnapToItem
            orientation: ListView.Horizontal
            spacing: mainForm.cellSize
            model: CalendarModel {
                id: calendarModel
                from: new Date(new Date().getFullYear(), 0, 1)
                to: new Date(new Date().getFullYear(), 11, 31)
                function setYear(newYear) {
                    if (calendarModel.from.getFullYear() > newYear) {
                        calendarModel.from = new Date(newYear, 0, 1)
                        calendarModel.to = new Date(newYear, 11, 31)
                    } else {
                        calendarModel.to = new Date(newYear, 11, 31)
                        calendarModel.from = new Date(newYear, 0, 1)
                    }
                    calendarView.currentYear = newYear
                    calendarView.goToLastPickedDate()
                    mainForm.setCurrentDate()
                }
            }

            property int currentDay: new Date().getDate()
            property int currentMonth: new Date().getMonth()
            property int currentYear: new Date().getFullYear()
            property int week: new Date().getDay()
            property var months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
            property var weekNames: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

            delegate: Rectangle {
                height: mainForm.cellSize * 8.5
                width: mainForm.cellSize * 7
                color: QuickMorphismConfig.theme.backgroundColor

                Rectangle {
                    id: monthYearTitle
                    anchors {
                        top: parent.top
                    }
                    height: mainForm.cellSize * 1.3
                    width: parent.width
                    color: QuickMorphismConfig.theme.backgroundColor

                    Label {
                        anchors.centerIn: parent
                        font.pixelSize: mainForm.fontSizePx * 1.2
                        text: calendarView.months[model.month] + " " + model.year
                        color: QuickMorphismConfig.theme.primaryTextColor
                    }
                }

                DayOfWeekRow {
                    id: weekTitles
                    Layout.column: 1
                    locale: monthGrid.locale
                    anchors {
                        top: monthYearTitle.bottom
                    }
                    height: mainForm.cellSize
                    width: parent.width
                    delegate: Label {
                        text: model.shortName
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: mainForm.fontSizePx
                        color: QuickMorphismConfig.theme.hintTextColor
                    }
                }

                MonthGrid {
                    id: monthGrid
                    month: model.month
                    year: model.year
                    spacing: 0
                    anchors {
                        top: weekTitles.bottom
                    }
                    width: mainForm.cellSize * 7
                    height: mainForm.cellSize * 6

                    locale: Qt.locale("en_US")
                    delegate: Rectangle {
                        height: mainForm.cellSize
                        width: mainForm.cellSize
                        radius: height * 0.5
                        property bool highlighted: enabled
                                                   && model.day === calendarView.currentDay
                                                   && model.month === calendarView.currentMonth

                        enabled: model.month === monthGrid.month
                        color: enabled && highlighted ? QuickMorphismConfig.theme.accentColor : QuickMorphismConfig.theme.backgroundColor

                        Label {
                            anchors.centerIn: parent
                            text: model.day
                            font.pixelSize: mainForm.fontSizePx
                            scale: highlighted ? 1.25 : 1
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 150
                                }
                            }
                            visible: parent.enabled
                            color: parent.highlighted ? QuickMorphismConfig.theme.backgroundColor : QuickMorphismConfig.theme.primaryTextColor
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                calendarView.currentDay = model.date.getDate()
                                calendarView.currentMonth = model.date.getMonth()
                                calendarView.week = model.date.getDay()
                                calendarView.currentYear = model.date.getFullYear()
                                mainForm.setCurrentDate()
                            }
                        }
                    }
                }
            }

            Component.onCompleted: goToLastPickedDate()
            function goToLastPickedDate() {
                positionViewAtIndex(calendarView.currentMonth, ListView.SnapToItem)
            }
        }

        ListView {
            id: yearsList
            anchors.fill: calendarView
            orientation: ListView.Vertical
            visible: false
            z: calendarView.z

            property int currentYear
            property int startYear: 1940
            property int endYear: new Date().getFullYear()
            model: ListModel {
                id: yearsModel
            }

            delegate: Rectangle {
                width: yearsList.width
                height: mainForm.cellSize * 1.5
                color: QuickMorphismConfig.theme.backgroundColor
                Label {
                    anchors.centerIn: parent
                    font.pixelSize: mainForm.fontSizePx * 1.5
                    text: name
                    scale: index === yearsList.currentYear - yearsList.startYear ? 1.5 : 1
                    color: QuickMorphismConfig.theme.accentColor
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        calendarModel.setYear(yearsList.startYear + index)
                        yearsList.hide()
                    }
                }
            }

            Component.onCompleted: {
                for (var year = startYear; year <= endYear; year++)
                    yearsModel.append({
                                          "name": year
                                      })
            }
            function show() {
                visible = true
                calendarView.visible = false
                currentYear = calendarView.currentYear
                yearsList.positionViewAtIndex(currentYear - startYear,
                                              ListView.SnapToItem)
            }
            function hide() {
                visible = false
                calendarView.visible = true
            }
        }

        Rectangle {
            height: mainForm.cellSize * 1.5
            anchors {
                top: calendarView.bottom
                right: parent.right
                rightMargin: mainForm.cellSize * 0.5
            }
            z: titleOfDate.z
            color: QuickMorphismConfig.theme.backgroundColor
            Row {
                layoutDirection: "RightToLeft"
                anchors {
                    right: parent.right
                }
                height: parent.height

                Rectangle {
                    id: okBtn
                    height: parent.height
                    width: okBtnText.contentWidth + mainForm.cellSize
                    color: QuickMorphismConfig.theme.backgroundColor
                    Label {
                        id: okBtnText
                        anchors.centerIn: parent
                        font.pixelSize: mainForm.fontSizePx * 1.8
                        color: QuickMorphismConfig.theme.accentColor
                        text: "OK"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mainForm.ok()
                        }
                    }
                }
                Rectangle {
                    id: cancelBtn
                    height: parent.height
                    width: cancelBtnText.contentWidth + mainForm.cellSize
                    color: QuickMorphismConfig.theme.backgroundColor
                    Label {
                        id: cancelBtnText
                        anchors.centerIn: parent
                        font.pixelSize: mainForm.fontSizePx * 1.8
                        color: QuickMorphismConfig.theme.accentColor
                        text: "CANCEL"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mainForm.cancel()
                        }
                    }
                }
            }
        }

        function setCurrentDate() {
            mainForm.date = new Date(calendarView.currentYear,
                                     calendarView.currentMonth, calendarView.currentDay)
        }
    }
}
