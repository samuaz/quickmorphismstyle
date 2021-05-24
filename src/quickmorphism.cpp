#include "quickmorphism.h"
#include <QDebug>
/*
QuickMorphism::QuickMorphism(QQmlApplicationEngine & engine, QuickMorphismUI *quickMorphismUI): _engine(engine), _quickMorphismUI(quickMorphismUI){
    init();
}
*/

void QuickMorphism::init(QQmlApplicationEngine &engine)
{
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
    qApp->setFont(font);
    QuickMorphismUI::registerSingleton(&engine);
}

static void registerTypes() {
    qRegisterMetaType<Theme *>();
    qmlRegisterType<StatusBar>(QuickMorphism::package_name, QuickMorphism::package_version_major, QuickMorphism::package_version_minor, "StatusBar");
    //qmlRegisterType<QuickMorphismUI>(QuickMorphism::package_name, QuickMorphism::package_version_major, QuickMorphism::package_version_minor, "QuickMorphismUI");
}


Q_COREAPP_STARTUP_FUNCTION(registerTypes)
