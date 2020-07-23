#ifndef QUICKMORPHISMUI_H
#define QUICKMORPHISMUI_H

#include <QSharedPointer>
#include <QObject>
#include <QQmlEngine>
#include <QtQml>
#include "theme/theme.h"
#include "theme/dark_theme.h"
#include "theme/light_theme.h"

class QuickMorphismUI : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Theme* theme READ theme WRITE setTheme NOTIFY themeChanged)
    Q_PROPERTY(Dpi dpi READ dpi WRITE setDpi NOTIFY dpiChanged)
    Q_PROPERTY(qreal dpScale READ dpScale WRITE setDpScale NOTIFY dpScaleChanged)

public:
    enum Dpi { LDPI, MDPI, HDPI, XHDPI, XXHDPI };
    Q_ENUM(Dpi)

private:
    float _dpScale = 1.0f;
    Dpi _dpi = Dpi::HDPI;
    QSharedPointer<Theme> _theme;

public:
    explicit QuickMorphismUI(QObject* parent = nullptr);
    static void registerSingleton(QQmlEngine * qmlEngine);

    Theme* theme() const;
    float dpScale() const;
    Dpi dpi();

public slots:

    void setTheme(Theme* theme);
    void setDpScale(float size);
    void setDpi(Dpi dpi);


signals:
    void themeChanged(Theme* signalTheme);
    void dpiChanged(Dpi signalDpi);
    void dpScaleChanged(float signalDpScale);
};

#endif // QUICKMORPHISMUI_H
