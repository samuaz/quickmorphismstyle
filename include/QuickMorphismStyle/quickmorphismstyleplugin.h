#ifndef QUICKMORPHISMSTYLEPLUGIN_H
#define QUICKMORPHISMSTYLEPLUGIN_H

#include <QtQuickControls2/private/qquickstyleplugin_p.h>

QT_BEGIN_NAMESPACE

class QuickMorphismStylePlugin : public QQuickStylePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    QuickMorphismStylePlugin(QObject *parent = nullptr);

    QString name() const override;
    void initializeEngine(QQmlEngine *engine, const char *uri) override;
};

QT_END_NAMESPACE

#endif // QUICKMORPHISMSTYLEPLUGIN_H