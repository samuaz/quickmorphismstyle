#include "statusbar.h"
#include "statusbar_p.h"

QColor StatusBarPrivate::statusBarColor;
QColor StatusBarPrivate::navBarColor;
StatusBar::Theme StatusBarPrivate::theme = StatusBar::Light;

StatusBar::StatusBar(QObject *parent) : QObject(parent){}

bool StatusBar::isAvailable()
{
    return StatusBarPrivate::isAvailable_sys();
}

QColor StatusBar::statusBarColor()
{
    return StatusBarPrivate::statusBarColor;
}

QColor StatusBar::navBarColor()
{
    return StatusBarPrivate::navBarColor;
}

void StatusBar::setStatusBarColor(const QColor &color)
{
    QColor statusColor;
    if (color.rgba() != QColor(Qt::transparent).rgba()) {
        statusColor = color.darker(90);
    }else{
        QColor statusColor = color;
    }

    StatusBarPrivate::statusBarColor = statusColor;
    StatusBarPrivate::setStatusBarColor_sys(statusColor);
}

void StatusBar::setNavBarColor(const QColor &color)
{
    StatusBarPrivate::navBarColor = color;
    StatusBarPrivate::setNavBarColor_sys(color);
}


StatusBar::Theme StatusBar::theme()
{
    return StatusBarPrivate::theme;
}

void StatusBar::setTheme(Theme theme)
{
    StatusBarPrivate::theme = theme;
    StatusBarPrivate::setTheme_sys(theme);
}
