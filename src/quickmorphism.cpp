#include <QuickMorphismStyle/quickmorphism.h>
#include <QDebug>
/*
QuickMorphism::QuickMorphism(QQmlApplicationEngine & engine, QuickMorphismUI *quickMorphismUI): _engine(engine), _quickMorphismUI(quickMorphismUI){
    init();
}
*/

void QuickMorphism::init(QQmlApplicationEngine &engine)
{
    //Q_INIT_RESOURCE(quickmorphism);

    engine.addImportPath("qrc:///");

    QFontDatabase::addApplicationFont(
        QStringLiteral(":QuickMorphism/assets/font/fa-brands-400.ttf"));

    QFontDatabase::addApplicationFont(
        QStringLiteral(":QuickMorphism/assets/font/fa-regular-400.ttf"));

    QFontDatabase::addApplicationFont(
        QStringLiteral(":QuickMorphism/assets/font/fa-solid-900.ttf"));

    QFontDatabase::addApplicationFont(
        QStringLiteral(":QuickMorphism/assets/font/NunitoSans-Black.ttf"));

    QFontDatabase::addApplicationFont(
        QStringLiteral(":QuickMorphism/assets/font/NunitoSans-Bold.ttf"));

    QFontDatabase::addApplicationFont(
        QStringLiteral(":QuickMorphism/assets/font/NunitoSans-Italic.ttf"));

    QFontDatabase::addApplicationFont(
        QStringLiteral(":QuickMorphism/assets/font/NunitoSans-Light.ttf"));

    QFontDatabase::addApplicationFont(
        QStringLiteral(":QuickMorphism/assets/font/NunitoSans-Regular.ttf"));

    QFont font("Nunito Sans");
    //font.setPointSize(font.pointSize());
    //qApp->setFont(font);
    QuickMorphismUI::registerSingleton(&engine);
}

static void registerTypes() {
    qRegisterMetaType<Theme *>();
    qmlRegisterType<StatusBar>(QuickMorphism::package_name, QuickMorphism::package_version_major, QuickMorphism::package_version_minor, "StatusBar");
    //qmlRegisterType<LightTheme>(QuickMorphism::package_name, QuickMorphism::package_version_major, QuickMorphism::package_version_minor, "QuickMorphismLightTheme");
    qmlRegisterType<DarkTheme>(QuickMorphism::package_name, QuickMorphism::package_version_major, QuickMorphism::package_version_minor, "QuickMorphismDarkTheme");
    qmlRegisterType<Theme>(QuickMorphism::package_name, QuickMorphism::package_version_major, QuickMorphism::package_version_minor, "QuickMorphismTheme");
    qmlRegisterUncreatableMetaObject(StyleNamespace::staticMetaObject, QuickMorphism::package_name, QuickMorphism::package_version_major, QuickMorphism::package_version_minor, "QuickMorphismStyle", "Not creatable as it is an enum type");
}


Q_COREAPP_STARTUP_FUNCTION(registerTypes)
