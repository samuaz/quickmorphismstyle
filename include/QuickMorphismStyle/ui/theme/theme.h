#ifndef THEME_H
#define THEME_H
#include <QObject>
#include <QString>
#include <QColor>

enum Style { Light, Dark };

class Theme : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(Style style READ style NOTIFY styleChanged)

    Q_PROPERTY(QColor backgroundColor MEMBER _backgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor foregroundColor MEMBER _foregroundColor NOTIFY foregroundColorChanged)
    Q_PROPERTY(QColor primaryTextColor MEMBER _primaryTextColor NOTIFY primaryTextColorChanged)
    Q_PROPERTY(QColor secondaryTextColor MEMBER _secondaryTextColor NOTIFY secondaryTextColorChanged)
    Q_PROPERTY(QColor hintTextColor MEMBER _hintTextColor NOTIFY hintTextColorChanged)
    Q_PROPERTY(QColor topShadowColor MEMBER _topShadowColor NOTIFY topShadowColorChanged)
    Q_PROPERTY(QColor bottonShadowColor MEMBER _bottonShadowColor NOTIFY bottonShadowColorChanged)
    Q_PROPERTY(QColor primaryColor MEMBER _primaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor secondaryColor MEMBER _secondaryColor NOTIFY secondaryColorChanged)
    Q_PROPERTY(QColor accentColor MEMBER _accentColor NOTIFY accentColorChanged)
    Q_PROPERTY(QColor errorColor MEMBER _errorColor NOTIFY errorColorChanged)
    Q_PROPERTY(QColor highlightedColor MEMBER _highlightedColor NOTIFY highlightedColorChanged)
    Q_PROPERTY(QColor hoverColor MEMBER _hoverColor NOTIFY hoverColorChanged)
    Q_PROPERTY(QColor statusBarColor MEMBER _statusBarColor NOTIFY statusBarColorChanged)
    Q_PROPERTY(QColor navBarColor MEMBER _navBarColor NOTIFY navBarColorChanged)

    Q_PROPERTY(float titleSizeMultiplier READ titleSizeMultiplier NOTIFY titleSizeMultiplierChanged)
    Q_PROPERTY(float subTitleSizeMultiplier READ subTitleSizeMultiplier NOTIFY subTitleSizeMultiplierChanged)

    Q_PROPERTY(float shadowOpacity READ shadowOpacity NOTIFY shadowOpacityChanged)
    Q_PROPERTY(int shadowGlow READ shadowGlow NOTIFY shadowGlowChanged)
    Q_PROPERTY(int insetShadowGlow READ insetShadowGlow NOTIFY insetShadowGlowChanged)
    Q_PROPERTY(float shadowSpread READ shadowSpread NOTIFY shadowSpreadChanged)
    Q_PROPERTY(float insetShadowSpread READ insetShadowSpread NOTIFY insetShadowSpreadChanged)
    Q_PROPERTY(int shadowOffSet READ shadowOffSet NOTIFY shadowOffSetChanged)

protected:
    QString _name;
    Style _style;
    QColor _backgroundColor;
    QColor _foregroundColor;
    QColor _primaryTextColor;
    QColor _secondaryTextColor;
    QColor _hintTextColor;
    QColor _topShadowColor;
    QColor _bottonShadowColor;
    QColor _primaryColor;
    QColor _secondaryColor;
    QColor _accentColor;
    QColor _errorColor;
    QColor _highlightedColor;
    QColor _hoverColor;
    QColor _statusBarColor;
    QColor _navBarColor;
    const float _shadowOpacity = 1.0;
    const int _shadowGlow = 5;
    const int _insetShadowGlow = 10;
    const float _shadowSpread = 0.5;
    const float _insetShadowSpread = 0.5;
    const int _shadowOffSet = 5;
    const float _titleSizeMultiplier = 2.0;
    const float _subTitleSizeMultiplier = 1.5;

public:
    Theme(const QString &name, Style style, const QColor &backgroundColor, const QColor &foregroundColor, const QColor &primaryTextColor, const QColor &secondaryTextColor, const QColor &hintTextColor, const QColor &topShadowColor, const QColor &bottonShadowColor, const QColor &primaryColor, const QColor &secondaryColor, const QColor &accentColor, const QColor &errorColor, const QColor &highlightedColor, const QColor &hoverColor, const QColor &statusBarColor, const QColor &navBarColor) : _name(name),
        _style(style),
        _backgroundColor(backgroundColor),
        _foregroundColor(foregroundColor),
        _primaryTextColor(primaryTextColor),
        _secondaryTextColor(secondaryTextColor),
        _hintTextColor(hintTextColor),
        _topShadowColor(topShadowColor),
        _bottonShadowColor(bottonShadowColor),
        _primaryColor(primaryColor),
        _secondaryColor(secondaryColor),
        _accentColor(accentColor),
        _errorColor(errorColor),
        _highlightedColor(highlightedColor),
        _hoverColor(hoverColor),
        _statusBarColor(statusBarColor),
        _navBarColor(navBarColor)
    {}

    Q_ENUM(Style)

    //Theme(QObject* parent = nullptr) : QObject(parent) {}


    QString name() const {
      return _name;
    };

    Style style() const {
        return _style;
    }

    virtual float titleSizeMultiplier() const {
        return _titleSizeMultiplier;
    }
    virtual float subTitleSizeMultiplier() const {
        return _subTitleSizeMultiplier;
    }

    float shadowOpacity() const
    {
        return _shadowOpacity;
    }

    int shadowGlow() const
    {
        return _shadowGlow;
    }
    int insetShadowGlow() const
    {
        return _insetShadowGlow;
    }

    float shadowSpread() const
    {
        return _shadowSpread;
    }

    float insetShadowSpread() const
    {
        return _insetShadowSpread;
    }

    int shadowOffSet() const {
        return _shadowOffSet;
    }

signals:
    void nameChanged();
    void styleChanged();
    void backgroundColorChanged();
    void foregroundColorChanged();
    void primaryTextColorChanged();
    void secondaryTextColorChanged();
    void hintTextColorChanged();
    void topShadowColorChanged();
    void bottonShadowColorChanged();
    void primaryColorChanged();
    void secondaryColorChanged();
    void accentColorChanged();
    void errorColorChanged();
    void highlightedColorChanged();
    void hoverColorChanged();
    void statusBarColorChanged();
    void navBarColorChanged();
    void baseSizeChanged();
    void smallSizeChanged();
    void largeSizeChanged();
    void shadowOpacityChanged();
    void shadowGlowChanged();
    void insetShadowGlowChanged();
    void shadowSpreadChanged();
    void insetShadowSpreadChanged();
    void shadowOffSetChanged();
    void titleSizeMultiplierChanged();
    void subTitleSizeMultiplierChanged();

};

Q_DECLARE_INTERFACE (Theme,"quickmorphism.Theme/1.0")

#endif // THEME_H


