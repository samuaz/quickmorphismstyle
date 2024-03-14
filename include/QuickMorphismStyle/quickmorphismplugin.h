#ifndef QUICKMORPHISMPLUGIN_H
#define QUICKMORPHISMPLUGIN_H

#include <QtQml/QQmlExtensionPlugin>

class QuickMorphismPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)
public:
    void initializeEngine(QQmlEngine *engine, const char *uri);
    void registerTypes(const char *uri);
};


#endif // QUICKMORPHISMPLUGIN_H
