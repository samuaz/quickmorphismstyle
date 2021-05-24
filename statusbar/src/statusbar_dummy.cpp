#include "statusbar_p.h"

bool StatusBarPrivate::isAvailable_sys()
{
    return false;
}

void StatusBarPrivate::setStatusBarColor_sys(const QColor &color)
{
    Q_UNUSED(color);
}

void StatusBarPrivate::setNavBarColor_sys(const QColor &color)
{
    Q_UNUSED(color);
}


void StatusBarPrivate::setTheme_sys(StatusBar::Theme theme)
{
    Q_UNUSED(theme);
}
