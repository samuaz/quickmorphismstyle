#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QuickMorphismStyle/quickmorphism.h>
#include <QSharedPointer>
#include <QLocale>
#include <QTranslator>
#include <QtQml/qqmlextensionplugin.h>

//int main(int argc, char *argv[])
//{
//    QGuiApplication app(argc, argv);

//    QTranslator translator;
//    const QStringList uiLanguages = QLocale::system().uiLanguages();
//    for (const QString &locale : uiLanguages) {
//        const QString baseName = "quickmorphismexample_" + QLocale(locale).name();
//        if (translator.load(":/i18n/" + baseName)) {
//            app.installTranslator(&translator);
//            break;
//        }
//    }

//    QQmlApplicationEngine engine;
//    const QUrl url(u"qrc:/quickmorphismexample/main.qml"_qs);
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);

//    return app.exec();
//}

int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);
    
    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "quickmorphismexample_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    QQmlApplicationEngine engine;

    // QuickMorphism Init
    QuickMorphism::init(engine);

    const QUrl url(u"qrc:/quickmorphismexample/demo.qml"_qs);
    //const QUrl url(QStringLiteral("qrc:/Demo.qml"));
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
