#include <QuickMorphismStyle/quickmorphismplugin.h>


void QuickMorphismPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("QuickMorphism.Controls"));

    // Set base URL to the plugin URL
    //engine->setBaseUrl(baseUrl());

}

void QuickMorphismPlugin::registerTypes(const char *uri)
{
    Q_UNUSED(uri)
}
