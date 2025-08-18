#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QLocale>
#include <QTranslator>
#include <QScreen>
#include <QDebug>
#include <QDir>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    // Set application properties
    app.setApplicationName("QuickMorphism Example");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("The Open Company");
    app.setOrganizationDomain("theopencompany.dev");

    // Set the QuickMorphism style
    QQuickStyle::setStyle("QuickMorphism");
    
    // Setup translation
    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "quickmorphismexample_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    // Initialize QML engine
    QQmlApplicationEngine engine;
    
    // Add the QuickMorphism style plugin import path
    QString pluginPath = QDir::currentPath() + "/qml";
    engine.addImportPath(pluginPath);
    qDebug() << "Added import path:" << pluginPath;

    // Load the main QML file
    const QUrl url(u"qrc:/quickmorphismexample/AdvancedDemo.qml"_s);
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { 
        QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(url);

    // Print screen information for debugging
    if (QScreen *screen = app.primaryScreen()) {
        qDebug() << "Screen size:" << screen->geometry();
        qDebug() << "Device pixel ratio:" << screen->devicePixelRatio();
        
        qreal refHeight = 1280.0;
        qreal refWidth = 768.0;
        QRect rect = screen->geometry();
        qreal height = qMax(rect.width(), rect.height());
        qreal width = qMin(rect.width(), rect.height());
        qreal ratio = qMin(height/refHeight, width/refWidth);
        qDebug() << "Screen ratio:" << ratio;
    }

    return app.exec();
}
