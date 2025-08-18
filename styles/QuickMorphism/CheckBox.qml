import QtQuick
import QtQuick.Controls.impl
import QtQuick.Templates as T
import QuickMorphism

T.CheckBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topPadding: 6
    bottomPadding: 6
    leftPadding: 12
    rightPadding: 12
    spacing: 12

    // Use QuickMorphismConfig.theme for colors
    readonly property QtObject currentTheme: QuickMorphismConfig ? QuickMorphismConfig.theme : LightTheme
    readonly property color backgroundColor: currentTheme ? currentTheme.backgroundColor : "#E0E5EC"
    readonly property color foregroundColor: currentTheme ? currentTheme.foregroundColor : "#E0E5EC"
    readonly property color shadowColor: currentTheme ? currentTheme.bottonShadowColor : "#A3B1C6"
    readonly property color highlightColor: currentTheme ? currentTheme.topShadowColor : "#FFFFFF"
    readonly property color textColor: currentTheme ? currentTheme.primaryTextColor : "#666666"
    readonly property color accentColor: currentTheme ? currentTheme.accentColor : "#7CB342"

    indicator: Rectangle {
        implicitWidth: 20
        implicitHeight: 20
        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        radius: 6
        color: control.foregroundColor

        // Checkbox neumorphism effect
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"
            
            // Inset shadow
            Rectangle {
                x: 2; y: 2
                width: parent.width - 4
                height: parent.height - 4
                radius: parent.radius - 2
                color: control.shadowColor
                opacity: 0.3
                z: -1
            }
            
            // Inner highlight
            Rectangle {
                x: -1; y: -1
                width: parent.width - 2
                height: parent.height - 2
                radius: parent.radius - 1
                color: control.highlightColor
                opacity: 0.2
                z: -2
            }
        }

        // Checkmark
        ColorImage {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: 14
            height: 14
            color: control.accentColor
            source: "data:image/svg+xml,%3csvg viewBox='0 0 16 16' fill='white' xmlns='http://www.w3.org/2000/svg'%3e%3cpath d='m13.854 3.646-7.5 7.5a.5.5 0 0 1-.708 0l-3.5-3.5a.5.5 0 1 1 .708-.708L6 10.293l7.146-7.147a.5.5 0 0 1 .708.708z'/%3e%3c/svg%3e"
            visible: control.checkState === Qt.Checked
        }

        // Partial checkmark for tristate
        Rectangle {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: 10
            height: 2
            color: control.accentColor
            visible: control.checkState === Qt.PartiallyChecked
        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.textColor
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
    }
}