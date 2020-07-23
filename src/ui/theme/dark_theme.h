#ifndef DARK_THEME_H
#define DARK_THEME_H

#include <QString>
#include <QColor>
#include "theme.h"

class DarkTheme : public virtual Theme {
    Q_OBJECT
private:
    const QString _name = "QuickMorphismDark";
    const Style _style = Style::Dark;
    const QColor _backgroundColor = QColor("#243441");
    const QColor _foregroundColor = QColor("#243441");
    const QColor _primaryTextColor = QColor("#ebebeb");
    const QColor _secondaryTextColor = QColor("#ebebeb");
    const QColor _hintTextColor = QColor("#959EA8");
    const QColor _topShadowColor = QColor("#293a46");
    const QColor _bottonShadowColor = QColor("#092836");
    const QColor _primaryColor = QColor("#243441");
    const QColor _secondaryColor = QColor("#243441");
    const QColor _accentColor = QColor("#0affef");
    const QColor _highlightedColor = QColor("#c2c2c2");
    const QColor _hoverColor = QColor("#c2c2c2");
    const QColor _statusBarColor = QColor("#243441");
    const QColor _navBarColor = QColor("#243441");
    const float _shadowOpacity = 1.0;
    const int _shadowGlow = 5;
    const int _insetShadowGlow = 10;
    const float _shadowSpread = 0.5;
    const float _insetShadowSpread = 0.5;
    const int _shadowOffSet = 5;

    // Theme interface
public:

    DarkTheme(QObject* parent = nullptr) : Theme(parent) {}


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


#endif // DARK_THEME_H
