import QtQuick
import QtQuick.Templates as T

T.Label {
    id: control

    color: enabled ? QuickMorphismConfig.theme.primaryTextColor : QuickMorphismConfig.theme.hintTextColor
    linkColor: QuickMorphismConfig.theme.accentColor
}
