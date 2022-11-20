#ifndef LIGHT_THEME_H
#define LIGHT_THEME_H
#include <QString>
#include <QColor>
#include "theme.h"

#define DEFAULT_LIGHT_THEME_NAME "QuickMorphismLight"
#define DEFAULT_LIGHT_THEME_STYLE Style::Light
#define DEFAULT_LIGHT_THEME_BACKGROUNDCOLOR QColor("#E0E5EC")
#define DEFAULT_LIGHT_THEME_FOREGROUNDCOLOR QColor("#E0E5EC")
#define DEFAULT_LIGHT_THEME_PRIMARYTEXTCOLOR QColor("#666666")
#define DEFAULT_LIGHT_THEME_SECONDARYTEXTCOLOR QColor("#666666")
#define DEFAULT_LIGHT_THEME_HINTTEXTCOLOR QColor("#A2A2A2")
#define DEFAULT_LIGHT_THEME_TOPSHADOWCOLOR QColor("#FFFFFF")
#define DEFAULT_LIGHT_THEME_BOTTONSHADOWCOLOR QColor("#A3B1C6")
#define DEFAULT_LIGHT_THEME_PRIMARYCOLOR QColor("#E0E5EC")
#define DEFAULT_LIGHT_THEME_SECONDARYCOLOR QColor("#E0E5EC")
#define DEFAULT_LIGHT_THEME_ACCENTCOLOR QColor("#7CB342")
#define DEFAULT_LIGHT_THEME_ERRORCOLOR QColor("#FF0000")
#define DEFAULT_LIGHT_THEME_HIGHLIGHTEDCOLOR QColor("#f4f4f4")
#define DEFAULT_LIGHT_THEME_HOVERCOLOR QColor("#7CB342")
#define DEFAULT_LIGHT_THEME_STATUSBARCOLOR QColor("#E0E5EC")
#define DEFAULT_LIGHT_THEME_NAVBARCOLOR QColor("#E0E5EC")

class LightTheme: public  Theme {
    Q_OBJECT
    Q_INTERFACES(Theme)

    // Theme interface
public:

    //LightTheme(QObject* parent = nullptr) : Theme(parent) {}

    LightTheme(): Theme(
                      DEFAULT_LIGHT_THEME_NAME,
                      DEFAULT_LIGHT_THEME_STYLE,
                      DEFAULT_LIGHT_THEME_BACKGROUNDCOLOR,
                      DEFAULT_LIGHT_THEME_FOREGROUNDCOLOR,
                      DEFAULT_LIGHT_THEME_PRIMARYTEXTCOLOR,
                      DEFAULT_LIGHT_THEME_SECONDARYTEXTCOLOR,
                      DEFAULT_LIGHT_THEME_HINTTEXTCOLOR,
                      DEFAULT_LIGHT_THEME_TOPSHADOWCOLOR,
                      DEFAULT_LIGHT_THEME_BOTTONSHADOWCOLOR,
                      DEFAULT_LIGHT_THEME_PRIMARYCOLOR,
                      DEFAULT_LIGHT_THEME_SECONDARYCOLOR,
                      DEFAULT_LIGHT_THEME_ACCENTCOLOR,
                      DEFAULT_LIGHT_THEME_ERRORCOLOR,
                      DEFAULT_LIGHT_THEME_HIGHLIGHTEDCOLOR,
                      DEFAULT_LIGHT_THEME_HOVERCOLOR,
                      DEFAULT_LIGHT_THEME_STATUSBARCOLOR,
                      DEFAULT_LIGHT_THEME_NAVBARCOLOR
                      ) {}

};

#endif // LIGHT_THEME_H
