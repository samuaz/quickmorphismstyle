#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QLocale>
#include <QTranslator>
#include <QScreen>
#include <QDebug>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    // Set application properties
    app.setApplicationName("QuickMorphism Example - QQuickStyle");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("The Open Company");
    app.setOrganizationDomain("theopencompany.dev");

    // Use QuickMorphism as Qt Quick Controls style (automatic initialization)
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

    // Add import paths
    engine.addImportPath(":/");
    engine.addImportPath("/Users/samuaz/Projects/toc/quickmorphismstyle/build/qml");

    // Load the QQuickStyle test QML file
    const QUrl url(u"qrc:/quickmorphismexample_quickstyle/Demo_quickstyle.qml"_s);
    
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