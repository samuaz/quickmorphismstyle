#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDir>
#include <QDebug>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    // Set the QuickMorphism style (now installed in Qt)
    QQuickStyle::setStyle("QuickMorphism");
    qDebug() << "Style set to:" << QQuickStyle::name();

    // Initialize QML engine
    QQmlApplicationEngine engine;

    // Load the main QML file
    const QUrl url(u"qrc:/TestBasic.qml"_s);
    
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { 
        QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    
    engine.load(url);

    return app.exec();
}