#ifndef THEME_H
#define THEME_H
#include <QObject>
#include <QString>
#include <QColor>

class Theme : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(Style style READ style NOTIFY styleChanged)

    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE backgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor foregroundColor READ foregroundColor WRITE foregroundColor NOTIFY foregroundColorChanged)
    Q_PROPERTY(QColor primaryTextColor READ primaryTextColor WRITE primaryTextColor NOTIFY primaryTextColorChanged)
    Q_PROPERTY(QColor secondaryTextColor READ secondaryTextColor WRITE secondaryTextColor NOTIFY secondaryTextColorChanged)
    Q_PROPERTY(QColor hintTextColor READ hintTextColor WRITE hintTextColor NOTIFY hintTextColorChanged)
    Q_PROPERTY(QColor topShadowColor READ topShadowColor WRITE topShadowColor NOTIFY topShadowColorChanged)
    Q_PROPERTY(QColor bottonShadowColor READ bottonShadowColor WRITE bottonShadowColor NOTIFY bottonShadowColorChanged)
    Q_PROPERTY(QColor primaryColor READ primaryColor WRITE primaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor secondaryColor READ secondaryColor WRITE secondaryColor NOTIFY secondaryColorChanged)
    Q_PROPERTY(QColor accentColor READ accentColor WRITE accentColor NOTIFY accentColorChanged)
    Q_PROPERTY(QColor errorColor READ errorColor WRITE errorColor NOTIFY errorColorChanged)
    Q_PROPERTY(QColor highlightedColor READ highlightedColor WRITE highlightedColor NOTIFY highlightedColorChanged)
    Q_PROPERTY(QColor hoverColor READ hoverColor WRITE hoverColor NOTIFY hoverColorChanged)
    Q_PROPERTY(QColor statusBarColor READ statusBarColor WRITE statusBarColor NOTIFY statusBarColorChanged)
    Q_PROPERTY(QColor navBarColor READ navBarColor WRITE navBarColor NOTIFY navBarColorChanged)
    Q_PROPERTY(float titleSizeMultiplier READ titleSizeMultiplier NOTIFY titleSizeMultiplierChanged)
    Q_PROPERTY(float subTitleSizeMultiplier READ subTitleSizeMultiplier NOTIFY subTitleSizeMultiplierChanged)

    Q_PROPERTY(float shadowOpacity READ shadowOpacity NOTIFY shadowOpacityChanged)
    Q_PROPERTY(int shadowGlow READ shadowGlow NOTIFY shadowGlowChanged)
    Q_PROPERTY(int insetShadowGlow READ insetShadowGlow NOTIFY insetShadowGlowChanged)
    Q_PROPERTY(float shadowSpread READ shadowSpread NOTIFY shadowSpreadChanged)
    Q_PROPERTY(float insetShadowSpread READ insetShadowSpread NOTIFY insetShadowSpreadChanged)
    Q_PROPERTY(int shadowOffSet READ shadowOffSet NOTIFY shadowOffSetChanged)

protected:
    const float _shadowOpacity = 1.0;
    const int _shadowGlow = 5;
    const int _insetShadowGlow = 10;
    const float _shadowSpread = 0.5;
    const float _insetShadowSpread = 0.5;
    const int _shadowOffSet = 5;
    const float _titleSizeMultiplier = 2.0;
    const float _subTitleSizeMultiplier = 1.1;

public:
    enum Style { Light, Dark };
    Q_ENUM(Style)

    Theme(QObject* parent = nullptr) : QObject(parent) {}

    virtual QString name() const = 0;
    virtual Style style() const = 0;

    virtual QColor backgroundColor() const = 0;
    virtual void backgroundColor(QColor) = 0;

    virtual QColor foregroundColor() const = 0;
    virtual void foregroundColor(QColor) = 0;


    virtual QColor primaryTextColor() const = 0;
    virtual void primaryTextColor(QColor) = 0;

    virtual QColor secondaryTextColor() const = 0;
    virtual void secondaryTextColor(QColor) = 0;

    virtual QColor hintTextColor() const = 0;
    virtual void hintTextColor(QColor) = 0;

    virtual QColor topShadowColor() const = 0;
    virtual void topShadowColor(QColor) = 0;

    virtual QColor bottonShadowColor() const = 0;
    virtual void bottonShadowColor(QColor) = 0;

    virtual QColor primaryColor() const = 0;
    virtual void primaryColor(QColor) = 0;

    virtual QColor secondaryColor() const = 0;
    virtual void secondaryColor(QColor) = 0;

    virtual QColor accentColor() const = 0;
    virtual void accentColor(QColor) = 0;

    virtual QColor errorColor() const = 0;
    virtual void errorColor(QColor) = 0;

    virtual QColor highlightedColor() const = 0;
    virtual void highlightedColor(QColor) = 0;

    virtual QColor hoverColor() const = 0;
    virtual void hoverColor(QColor) = 0;

    virtual QColor statusBarColor() const = 0;
    virtual void statusBarColor(QColor) = 0;

    virtual QColor navBarColor() const = 0;
    virtual void navBarColor(QColor) = 0;


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
