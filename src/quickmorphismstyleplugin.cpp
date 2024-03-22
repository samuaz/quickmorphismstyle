#include <QtQuickControls2/QQuickStylePlugin>
#include <QtQml/qqml.h>

class QuickMorphismStylePlugin : public QQuickStylePlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQuickStylePluginInterface_iid)

public:
    void registerTypes(const char *uri) override {
        // Registrar componentes QML específicos del estilo, si los hay
        // qmlRegisterType<QmlType>(uri, 1, 0, "QmlTypeName");
    }

    void initializeEngine(QQmlEngine *engine, const char *uri) override {
        QQuickStylePlugin::initializeEngine(engine, uri);
        // Configuraciones adicionales del motor, si son necesarias
    }
};
