#ifndef LIGHT_THEME_H
#define LIGHT_THEME_H
#include <QString>
#include <QColor>
#include "theme.h"


class LightTheme : public virtual Theme {
    Q_OBJECT
private:
    const QString _name = "QuickMorphismLight";
    const Style _style = Style::Light;
    const QColor _backgroundColor = QColor("#E0E5EC");
    const QColor _foregroundColor = QColor("#E0E5EC");
    const QColor _primaryTextColor = QColor("#666666");
    const QColor _secondaryTextColor = QColor("#666666");
    const QColor _hintTextColor = QColor("#A2A2A2");
    const QColor _topShadowColor = QColor("#FFFFFF");
    const QColor _bottonShadowColor = QColor("#A3B1C6");
    const QColor _primaryColor = QColor("#E0E5EC");
    const QColor _secondaryColor = QColor("#E0E5EC");
    const QColor _accentColor = QColor("#7CB342");
    const QColor _highlightedColor = QColor("#FFD54F");
    const QColor _hoverColor = QColor("#FFD54F");
    const QColor _statusBarColor = QColor("#A3B1C6");
    const QColor _navBarColor = QColor("#A3B1C6");
    const float _shadowOpacity = 1.0;
    const int _shadowGlow = 5;
    const int _insetShadowGlow = 10;
    const float _shadowSpread = 0.5;
    const float _insetShadowSpread = 0.5;
    const int _shadowOffSet = 5;

    // Theme interface
public:

    LightTheme(QObject* parent = nullptr) : Theme(parent) {}

    QString name() const override
    {
        return _name;
    }

    Style style() const override
    {
        return _style;
    }

    QColor backgroundColor() const override
    {
        return _backgroundColor;
    }

    QColor foregroundColor() const override
    {
        return _foregroundColor;
    }

    QColor primaryTextColor() const override
    {
        return _primaryTextColor;
    }

    QColor secondaryTextColor() const override
    {
        return _secondaryTextColor;
    }

    QColor hintTextColor() const override
    {
        return _hintTextColor;
    }

    QColor topShadowColor() const override
    {
        return _topShadowColor;
    }

    QColor bottonShadowColor() const override
    {
        return _bottonShadowColor;
    }

    QColor primaryColor() const override
    {
        return _primaryColor;
    }

    QColor secondaryColor() const override
    {
        return _secondaryColor;
    }

    QColor accentColor() const override
    {
        return _accentColor;
    }

    QColor highlightedColor() const override
    {
        return _highlightedColor;
    }
    QColor hoverColor() const override
    {
        return _hoverColor;
    }

    QColor statusBarColor() const override
    {
        return _statusBarColor;
    }

    QColor navBarColor() const override
    {
        return _navBarColor;
    }

    float shadowOpacity() const override
    {
        return _shadowOpacity;
    }

    int shadowGlow() const override
    {
        return _shadowGlow;
    }
    int insetShadowGlow() const override
    {
        return _insetShadowGlow;
    }

    float shadowSpread() const override
    {
        return _shadowSpread;
    }

    float insetShadowSpread() const override
    {
        return _insetShadowSpread;
    }

    int shadowOffSet() const override {
        return _shadowOffSet;
    }
};

#endif // LIGHT_THEME_H
