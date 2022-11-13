#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QuickMorphismStyle/quickmorphism.h>
#include <QSharedPointer>

int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // QuickMorphism Init
    QuickMorphism::init(engine);

    const QUrl url(QStringLiteral("qrc:/Demo.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QScreen *screen = qApp->screens().at(0);
    qDebug() << "printing screen size";
    qDebug() << screen->geometry();
    qreal refHeight = 1280.;
    qreal refWidth = 768.;
    QRect rect = screen->geometry();
    qreal height = qMax(rect.width(), rect.height());
    qreal width = qMin(rect.width(), rect.height());
    qDebug() << "printing screen ratio";
    qDebug() << qMin(height/refHeight, width/refWidth);

    return app.exec();
}
