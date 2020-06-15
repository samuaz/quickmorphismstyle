#ifndef STATUSBAR_P_H
#define STATUSBAR_P_H

#include "statusbar.h"

class StatusBarPrivate
{
public:
    static bool isAvailable_sys();
    static void setStatusBarColor_sys(const QColor &color);
    static void setNavBarColor_sys(const QColor &color);
    static void setTheme_sys(StatusBar::Theme theme);

    static QColor statusBarColor;
    static QColor navBarColor;
    static StatusBar::Theme theme;
};

#endif // STATUSBAR_P_H
