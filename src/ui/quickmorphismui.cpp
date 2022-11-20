#include <QuickMorphismStyle/ui/quickmorphismui.h>
#include <QuickMorphismStyle/ui/snackbar.h>

static QuickMorphismUI *s_instance = nullptr;

QuickMorphismUI::QuickMorphismUI(QObject *parent): QObject(parent), _theme(new LightTheme()){}

void QuickMorphismUI::registerSingleton(QQmlEngine * qmlEngine)
{
    if (!s_instance) {
        s_instance = new QuickMorphismUI(qmlEngine);
    }

    QQmlContext *rootContext = qmlEngine->rootContext();
    rootContext->setContextProperty("QuickMorphism", s_instance);
    rootContext->setContextProperty("QuickMorphismDarkTheme", new DarkTheme);
    rootContext->setContextProperty("QuickMorphismLightTheme", new LightTheme);
    rootContext->setContextProperty("QuickMorphismSnackBar", new Snackbar);
}

Theme* QuickMorphismUI::theme() const
{
    return _theme;
}

float QuickMorphismUI::dpScale() const
{
    return _dpScale;
}

QuickMorphismUI::Dpi QuickMorphismUI::dpi()
{
    return _dpi;
}

void QuickMorphismUI::setTheme(Theme* theme)
{
    qDebug() << "change theme";
    _theme = theme;
    emit themeChanged(_theme);
}

void QuickMorphismUI::setDpScale(float scale)
{
    _dpScale = scale;
    emit dpScaleChanged(_dpScale);
}

void QuickMorphismUI::setDpi(QuickMorphismUI::Dpi dpi)
{
    _dpi = dpi;
    emit dpiChanged(_dpi);
}

