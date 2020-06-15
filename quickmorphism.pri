QT += qml quick svg

CONFIG += c++17 qtquickcompiler ##ltcg

#CONFIG += qmltypes
#QML_IMPORT_NAME = QuickMorphism
#QML_IMPORT_MAJOR_VERSION = 1
#QML_IMPORT_MINOR_VERSION = 0

QML_IMPORT_PATH += $$PWD

QML_DESIGNER_IMPORT_PATH = $$PWD

INCLUDEPATH += $$PWD/src
INCLUDEPATH += $$PWD/src/config
INCLUDEPATH += $$PWD/src/UI
INCLUDEPATH += $$PWD/src/UI/theme

RESOURCES += \
    $$PWD/QuickMorphism/quickmorphism.qrc

HEADERS += \
    $$PWD/src/UI/quickmorphismui.h \
    $$PWD/src/quickmorphism.h \
    $$PWD/src/config/colors.h \
    $$PWD/src/config/configuration.h \
    $$PWD/src/UI/theme/dark_theme.h \
    $$PWD/src/UI/theme/light_theme.h \
    $$PWD/src/UI/theme/theme.h


SOURCES += \
    $$PWD/src/UI/quickmorphismui.cpp \
    $$PWD/src/quickmorphism.cpp \
    $$PWD/src/config/colors.cpp \
    $$PWD/src/config/configuration.cpp

include($$PWD/statusbar/statusbar.pri)

android: {
    QT += androidextras
}
