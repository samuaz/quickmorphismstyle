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

    // Set QuickMorphism as the style for Qt Quick Controls
    QQuickStyle::setStyle("QuickMorphism");

    // Initialize QML engine
    QQmlApplicationEngine engine;

    // Initialize QuickMorphism types (register QML components)
    QuickMorphism::init(engine);
    
    // Add the QuickMorphism QML import path
    engine.addImportPath(":/");
    
    // Add the build directory where QuickMorphism files are copied (same as working example)
    QString buildDir = QGuiApplication::applicationDirPath() + "/../../..";
    engine.addImportPath(buildDir);
    qDebug() << "Added build directory path:" << buildDir;
    
    // Add the styles directory for QQuickStyle::setStyle to find QuickMorphism
    QString stylesPath = buildDir + "/_deps/quickmorphism-src/styles";
    engine.addImportPath(stylesPath);
    qDebug() << "Added styles path:" << stylesPath;

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