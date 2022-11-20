#ifndef DARK_THEME_H
#define DARK_THEME_H

#include <QString>
#include <QColor>
#include "theme.h"

class DarkTheme: public Theme {
    Q_OBJECT
    Q_INTERFACES(Theme)
private:
    const QString _name = "QuickMorphismDark";
    const Style _style = Style::Dark;
    QColor _backgroundColor = QColor("#243441");
    QColor _foregroundColor = QColor("#243441");
    QColor _primaryTextColor = QColor("#ebebeb");
    QColor _secondaryTextColor = QColor("#ebebeb");
    QColor _hintTextColor = QColor("#959EA8");
    QColor _topShadowColor = QColor("#293a46");
    QColor _bottonShadowColor = QColor("#092836");
    QColor _primaryColor = QColor("#243441");
    QColor _secondaryColor = QColor("#243441");
    QColor _accentColor = QColor("#0affef");
    QColor _errorColor = QColor("#FF0000");
    QColor _highlightedColor = QColor("#c2c2c2");
    QColor _hoverColor = QColor("#c2c2c2");
    QColor _statusBarColor = QColor("#243441");
    QColor _navBarColor = QColor("#243441");

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

    QColor errorColor() const override {
        return _errorColor;
    };


    void backgroundColor(QColor color) override
    {
     _backgroundColor = color;
    }
    void foregroundColor(QColor color) override
    {
        _foregroundColor = color;

    }
    void primaryTextColor(QColor color) override
    {
        _primaryTextColor = color;

    }
    void secondaryTextColor(QColor color) override
    {
        _secondaryTextColor = color;

    }
    void hintTextColor(QColor color) override
    {
        _hintTextColor = color;

    }
    void topShadowColor(QColor color) override
    {
        _topShadowColor = color;

    }
    void bottonShadowColor(QColor color) override
    {
        _bottonShadowColor = color;

    }
    void primaryColor(QColor color) override
    {
        _primaryColor = color;

    }
    void secondaryColor(QColor color) override
    {
        _secondaryColor = color;

    }
    void accentColor(QColor color) override
    {
        _accentColor = color;

    }
    void errorColor(QColor color) override
    {
        _errorColor = color;

    }
    void highlightedColor(QColor color) override
    {
        _highlightedColor = color;

    }
    void hoverColor(QColor color) override
    {
        _hoverColor = color;

    }
    void statusBarColor(QColor color) override
    {
        _statusBarColor = color;

    }
    void navBarColor(QColor color) override
    {
        _navBarColor = color;

    }
};


#endif // DARK_THEME_H
