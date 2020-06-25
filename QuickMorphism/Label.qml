import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Label {
    id: control

    color: enabled ? QuickMorphismConfig.theme.primaryTextColor : QuickMorphismConfig.theme.hintTextColor
    linkColor: QuickMorphismConfig.theme.accentColor
}
