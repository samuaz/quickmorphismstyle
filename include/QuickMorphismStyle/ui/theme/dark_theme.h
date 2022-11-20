#ifndef DARK_THEME_H
#define DARK_THEME_H

#include <QString>
#include <QColor>
#include "theme.h"

#define DEFAULT_DARK_THEME_NAME "QuickMorphismDark"
#define DEFAULT_DARK_THEME_STYLE Style::Dark
#define DEFAULT_DARK_THEME_BACKGROUNDCOLOR QColor("#243441")
#define DEFAULT_DARK_THEME_FOREGROUNDCOLOR QColor("#243441")
#define DEFAULT_DARK_THEME_PRIMARYTEXTCOLOR QColor("#ebebeb")
#define DEFAULT_DARK_THEME_SECONDARYTEXTCOLOR QColor("#ebebeb")
#define DEFAULT_DARK_THEME_HINTTEXTCOLOR QColor("#959EA8")
#define DEFAULT_DARK_THEME_TOPSHADOWCOLOR QColor("#293a46")
#define DEFAULT_DARK_THEME_BOTTONSHADOWCOLOR QColor("#092836")
#define DEFAULT_DARK_THEME_PRIMARYCOLOR QColor("#243441")
#define DEFAULT_DARK_THEME_SECONDARYCOLOR QColor("#243441")
#define DEFAULT_DARK_THEME_ACCENTCOLOR QColor("#0affef")
#define DEFAULT_DARK_THEME_ERRORCOLOR QColor("#FF0000")
#define DEFAULT_DARK_THEME_HIGHLIGHTEDCOLOR QColor("#c2c2c2")
#define DEFAULT_DARK_THEME_HOVERCOLOR QColor("#c2c2c2")
#define DEFAULT_DARK_THEME_STATUSBARCOLOR QColor("#243441")
#define DEFAULT_DARK_THEME_NAVBARCOLOR QColor("#243441")

class DarkTheme: public Theme {
    Q_OBJECT
    Q_INTERFACES(Theme)
    // Theme interface
public:

    //DarkTheme(QObject* parent = nullptr) : Theme(parent) {}

    DarkTheme(): Theme(
                      DEFAULT_DARK_THEME_NAME,
                      DEFAULT_DARK_THEME_STYLE,
                      DEFAULT_DARK_THEME_BACKGROUNDCOLOR,
                      DEFAULT_DARK_THEME_FOREGROUNDCOLOR,
                      DEFAULT_DARK_THEME_PRIMARYTEXTCOLOR,
                      DEFAULT_DARK_THEME_SECONDARYTEXTCOLOR,
                      DEFAULT_DARK_THEME_HINTTEXTCOLOR,
                      DEFAULT_DARK_THEME_TOPSHADOWCOLOR,
                      DEFAULT_DARK_THEME_BOTTONSHADOWCOLOR,
                      DEFAULT_DARK_THEME_PRIMARYCOLOR,
                      DEFAULT_DARK_THEME_SECONDARYCOLOR,
                      DEFAULT_DARK_THEME_ACCENTCOLOR,
                      DEFAULT_DARK_THEME_ERRORCOLOR,
                      DEFAULT_DARK_THEME_HIGHLIGHTEDCOLOR,
                      DEFAULT_DARK_THEME_HOVERCOLOR,
                      DEFAULT_DARK_THEME_STATUSBARCOLOR,
                      DEFAULT_DARK_THEME_NAVBARCOLOR
                      ) {}

};


#endif // DARK_THEME_H
