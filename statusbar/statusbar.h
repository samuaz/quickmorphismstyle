#ifndef STATUSBAR_H
#define STATUSBAR_H

#include <QObject>
#include <QColor>
#include <QtQml>

class StatusBar : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool available READ isAvailable CONSTANT)
    Q_PROPERTY(QColor statusBarColor READ statusBarColor WRITE setStatusBarColor)
    Q_PROPERTY(QColor navBarColor READ navBarColor WRITE setNavBarColor)
    Q_PROPERTY(Theme theme READ theme WRITE setTheme)

public:
    explicit StatusBar(QObject *parent = nullptr);
    static bool isAvailable();
    static QColor statusBarColor();
    static QColor navBarColor();
    static void setStatusBarColor(const QColor &color);
    static void setNavBarColor(const QColor &color);

    enum Theme { Light, Dark };
    Q_ENUM(Theme)

    static Theme theme();
    static void setTheme(Theme theme);

};

#endif // STATUSBAR_H
