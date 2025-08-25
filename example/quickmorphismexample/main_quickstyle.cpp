#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QLocale>
#include <QTranslator>
#include <QScreen>
#include <QDebug>
#include <QuickMorphismStyle/quickmorphism.h>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    // Set application properties
    app.setApplicationName("QuickMorphism Example - QQuickStyle");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("The Open Company");
    app.setOrganizationDomain("theopencompany.dev");

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

    // NOTE: Not using QQuickStyle::setStyle() because we're using direct QuickMorphism components
    // QQuickStyle::setStyle("QuickMorphism");

    // Initialize QML engine
    QQmlApplicationEngine engine;

    // Initialize QuickMorphism types (register QML components)
    QuickMorphism::init(engine);
    
    // Add the resource path for embedded QML files
    engine.addImportPath(":/");
    
    // Add the build directory for FetchContent-downloaded QuickMorphism
    QString buildDir = QGuiApplication::applicationDirPath() + "/../../..";
    QString quickMorphismPath = buildDir + "/_deps/quickmorphism-src";
    
    engine.addImportPath(quickMorphismPath);
    qDebug() << "Added QuickMorphism path:" << quickMorphismPath;
    
    // Verify the QuickMorphism module files exist
    QDir qmDir(quickMorphismPath + "/QuickMorphism");
    if (qmDir.exists()) {
        qDebug() << "QuickMorphism module directory exists";
        qDebug() << "qmldir exists:" << QFile::exists(quickMorphismPath + "/QuickMorphism/qmldir");
    } else {
        qDebug() << "ERROR: QuickMorphism module directory NOT found!";
    }

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