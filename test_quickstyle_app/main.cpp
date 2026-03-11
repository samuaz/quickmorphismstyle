#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDir>
#include <QStandardPaths>
#include <QDebug>

using namespace Qt::StringLiterals;

QString findQuickMorphismStylePath() {
    // Try different possible locations for QuickMorphism style
    QStringList possiblePaths = {
        // 1. Build directory (development)
        QDir::currentPath() + "/qml",
        QDir::currentPath() + "/../build/qml",
        
        // 2. Environment variable
        qEnvironmentVariable("QUICKMORPHISM_STYLE_PATH"),
        
        // 3. Application directory
        QGuiApplication::applicationDirPath() + "/qml",
        
        // 4. User data directory  
        QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/qml",
        
        // 5. System-wide installation (if installed via cmake install)
        "/usr/local/share/qml",
        "/opt/quickmorphism/qml"
    };
    
    for (const QString& path : possiblePaths) {
        if (!path.isEmpty() && QDir(path + "/QuickMorphism").exists()) {
            qDebug() << "Found QuickMorphism style at:" << path;
            return path;
        }
    }
    
    qWarning() << "QuickMorphism style not found in any standard location.";
    qWarning() << "Please set QUICKMORPHISM_STYLE_PATH environment variable or";
    qWarning() << "call engine.addImportPath() with the correct path manually.";
    return QString();
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    
    // Try to find and configure QuickMorphism style automatically
    QString stylePath = findQuickMorphismStylePath();
    if (!stylePath.isEmpty()) {
        engine.addImportPath(stylePath);
        QQuickStyle::setStyle("QuickMorphism");
        qDebug() << "QuickMorphism style configured successfully";
    } else {
        qWarning() << "Using default Qt style";
    }
    
    const QUrl url(u"qrc:/test_quickstyle_app/main.qml"_s);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}