#include <QuickMorphismStyle/quickmorphismstyleplugin.h>
#include <QuickMorphismStyle/quickmorphism.h>
#include <QuickMorphismStyle/ui/quickmorphismui.h>
#include <QQmlApplicationEngine>
#include <QDebug>

QT_BEGIN_NAMESPACE

QuickMorphismStylePlugin::QuickMorphismStylePlugin(QObject *parent)
    : QQmlExtensionPlugin(parent)
{
}

void QuickMorphismStylePlugin::registerTypes(const char *uri)
{
    Q_UNUSED(uri)
    // No need to register types here as we're just providing a QML module
    qDebug() << "QuickMorphism plugin registerTypes called for URI:" << uri;
}

void QuickMorphismStylePlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(uri)
    
    qDebug() << "Initializing QuickMorphism plugin for URI:" << uri;
    
    // Cast QQmlEngine to QQmlApplicationEngine for QuickMorphism::init()
    // This is safe because Qt Quick Controls styles are loaded by QQmlApplicationEngine
    QQmlApplicationEngine *appEngine = qobject_cast<QQmlApplicationEngine*>(engine);
    
    if (appEngine) {
        // Initialize QuickMorphism automatically when style is loaded
        // This preserves the original theming system while enabling QQuickStyle::setStyle()
        QuickMorphism::init(*appEngine);
        qDebug() << "QuickMorphism initialized via QQmlApplicationEngine";
    } else {
        // Fallback: Register singleton manually if we can't cast to QQmlApplicationEngine
        QuickMorphismUI::registerSingleton(engine);
        qDebug() << "QuickMorphism initialized via fallback method";
    }
}