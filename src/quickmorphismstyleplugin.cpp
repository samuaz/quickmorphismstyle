#include <QuickMorphismStyle/quickmorphismstyleplugin.h>
#include <QuickMorphismStyle/quickmorphism.h>
#include <QuickMorphismStyle/ui/quickmorphismui.h>
#include <QQmlApplicationEngine>
#include <QDebug>

QT_BEGIN_NAMESPACE

QuickMorphismStylePlugin::QuickMorphismStylePlugin(QObject *parent)
    : QQuickStylePlugin(parent)
{
}

QString QuickMorphismStylePlugin::name() const
{
    return QStringLiteral("QuickMorphism");
}

void QuickMorphismStylePlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(uri)
    
    // Cast QQmlEngine to QQmlApplicationEngine for QuickMorphism::init()
    // This is safe because Qt Quick Controls styles are loaded by QQmlApplicationEngine
    QQmlApplicationEngine *appEngine = qobject_cast<QQmlApplicationEngine*>(engine);
    
    if (appEngine) {
        // Initialize QuickMorphism automatically when style is loaded
        // This preserves the original theming system while enabling QQuickStyle::setStyle()
        QuickMorphism::init(*appEngine);
        qDebug() << "QuickMorphism style plugin initialized successfully";
    } else {
        // Fallback: Register singleton manually if we can't cast to QQmlApplicationEngine
        QuickMorphismUI::registerSingleton(engine);
        qDebug() << "QuickMorphism style plugin initialized with fallback method";
    }
}