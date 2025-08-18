#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDir>
#include <QDebug>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    // Set the QuickMorphism style
    QQuickStyle::setStyle("QuickMorphism");
    qDebug() << "Style set to:" << QQuickStyle::name();

    // Initialize QML engine
    QQmlApplicationEngine engine;
    
    // Add import path for the style plugin  
    QString pluginPath = QDir::currentPath() + "/qml";
    engine.addImportPath(pluginPath);
    qDebug() << "Added import path:" << pluginPath;

    // Load the main QML file
    const QUrl url(u"qrc:/Main.qml"_s);
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { 
        QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(url);

    return app.exec();
}