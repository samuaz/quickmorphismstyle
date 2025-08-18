#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Set QuickMorphism as the Qt Quick Controls style
    QQuickStyle::setStyle("QuickMorphism");
    
    QQmlApplicationEngine engine;
    // Add our build directory to QML import path so it can find the plugin
    engine.addImportPath("/Users/samuaz/Projects/toc/quickmorphismstyle/build/qml");
    
    const QUrl url(u"qrc:/test_quickstyle_app/main.qml"_s);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}