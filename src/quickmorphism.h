#ifndef QUICKMORPHISM_H
#define QUICKMORPHISM_H

#include <QtPlugin>
#include <QQuickWindow>
#include <QQmlApplicationEngine>
#include <string>
#include <QtQml>
#include <QtGui>
#include <QVariantMap>
#include <QPointer>
#include "../statusbar/statusbar.h"
#include "ui/quickmorphismui.h"
#include "ui/theme/light_theme.h"
#include "ui/theme/dark_theme.h"
#include <QSharedPointer>


class QuickMorphism {

public:

    static constexpr const auto package_name = "QuickMorphism";
    static constexpr const auto package_version_major = 1;
    static constexpr const auto package_version_minor = 0;
    static void init(QQmlApplicationEngine & engine);

};


#endif // QUICKMORPHISM_H
