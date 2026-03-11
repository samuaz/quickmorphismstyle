#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDebug>
#include <QuickMorphismStyle/quickmorphism.h>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setApplicationName("QuickMorphism Example - QQuickStyle");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("The Open Company");
    app.setOrganizationDomain("theopencompany.dev");

    QQmlApplicationEngine engine;

    // Initialize QuickMorphism types and resources
    QuickMorphism::init(engine);

    // Add import paths for QML module discovery
    engine.addImportPath(":/");

    // Load the QML file
    const QUrl url(u"qrc:/quickmorphismexample_quickstyle/Demo_quickstyle.qml"_s);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() {
        QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
