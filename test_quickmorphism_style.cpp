#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDir>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Set the style to QuickMorphism
    QQuickStyle::setStyle("QuickMorphism");
    
    // Add import path for our style
    QQmlApplicationEngine engine;
    engine.addImportPath(QDir::currentPath() + "/qml");
    
    const QUrl url(u"qrc:/test_app.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}