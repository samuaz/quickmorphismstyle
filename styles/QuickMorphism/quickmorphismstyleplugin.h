#ifndef QUICKMORPHISMSTYLEPLUGIN_H
#define QUICKMORPHISMSTYLEPLUGIN_H

#include <QtQml/qqmlextensionplugin.h>

QT_BEGIN_NAMESPACE

class QuickMorphismStylePlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    QuickMorphismStylePlugin(QObject *parent = nullptr);
    void registerTypes(const char *uri) override;
};

QT_END_NAMESPACE

#endif // QUICKMORPHISMSTYLEPLUGIN_H