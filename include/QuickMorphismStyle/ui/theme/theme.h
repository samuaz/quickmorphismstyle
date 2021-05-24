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
    Q_PROPERTY(QColor backgroundColor READ backgroundColor NOTIFY backgroundColorChanged)
    Q_PROPERTY(QColor foregroundColor READ foregroundColor NOTIFY foregroundColorChanged)
    Q_PROPERTY(QColor primaryTextColor READ primaryTextColor NOTIFY primaryTextColorChanged)
    Q_PROPERTY(QColor secondaryTextColor READ secondaryTextColor NOTIFY secondaryTextColorChanged)
    Q_PROPERTY(QColor hintTextColor READ hintTextColor NOTIFY hintTextColorChanged)
    Q_PROPERTY(QColor topShadowColor READ topShadowColor NOTIFY topShadowColorChanged)
    Q_PROPERTY(QColor bottonShadowColor READ bottonShadowColor NOTIFY bottonShadowColorChanged)
    Q_PROPERTY(QColor primaryColor READ primaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor secondaryColor READ secondaryColor NOTIFY secondaryColorChanged)
    Q_PROPERTY(QColor accentColor READ accentColor NOTIFY accentColorChanged)
    Q_PROPERTY(QColor highlightedColor READ highlightedColor NOTIFY highlightedColorChanged)
    Q_PROPERTY(QColor hoverColor READ hoverColor NOTIFY hoverColorChanged)
    Q_PROPERTY(QColor statusBarColor READ statusBarColor NOTIFY statusBarColorChanged)
    Q_PROPERTY(QColor navBarColor READ navBarColor NOTIFY navBarColorChanged)
    Q_PROPERTY(float shadowOpacity READ shadowOpacity NOTIFY shadowOpacityChanged)
    Q_PROPERTY(int shadowGlow READ shadowGlow NOTIFY shadowGlowChanged)
    Q_PROPERTY(int insetShadowGlow READ insetShadowGlow NOTIFY insetShadowGlowChanged)
    Q_PROPERTY(float shadowSpread READ shadowSpread NOTIFY shadowSpreadChanged)
    Q_PROPERTY(float insetShadowSpread READ insetShadowSpread NOTIFY insetShadowSpreadChanged)
    Q_PROPERTY(int shadowOffSet READ shadowOffSet NOTIFY shadowOffSetChanged)

public:
    enum Style { Light, Dark };
    Q_ENUM(Style)

    Theme(QObject* parent = nullptr) : QObject(parent) {}

    virtual QString name() const = 0;
    virtual Style style() const = 0;
    virtual QColor backgroundColor() const = 0;
    virtual QColor foregroundColor() const = 0;
    virtual QColor primaryTextColor() const = 0;
    virtual QColor secondaryTextColor() const = 0;
    virtual QColor hintTextColor() const = 0;
    virtual QColor topShadowColor() const = 0;
    virtual QColor bottonShadowColor() const = 0;
    virtual QColor primaryColor() const = 0;
    virtual QColor secondaryColor() const = 0;
    virtual QColor accentColor() const = 0;
    virtual QColor highlightedColor() const = 0;
    virtual QColor hoverColor() const = 0;
    virtual QColor statusBarColor() const = 0;
    virtual QColor navBarColor() const = 0;
    virtual float shadowOpacity() const = 0;
    virtual int shadowGlow() const = 0;
    virtual int insetShadowGlow() const = 0;
    virtual float shadowSpread() const = 0;
    virtual float insetShadowSpread() const = 0;
    virtual int shadowOffSet() const = 0;

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

};

#endif // THEME_H
