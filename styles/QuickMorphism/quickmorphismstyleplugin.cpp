#include "quickmorphismstyleplugin.h"

QT_BEGIN_NAMESPACE

QuickMorphismStylePlugin::QuickMorphismStylePlugin(QObject *parent)
    : QQmlExtensionPlugin(parent)
{
}

void QuickMorphismStylePlugin::registerTypes(const char *uri)
{
    Q_UNUSED(uri);
    // The style plugin doesn't need to register any types
    // The QML files in this directory will be automatically found
}

QT_END_NAMESPACE