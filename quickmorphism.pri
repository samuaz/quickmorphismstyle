QT += quick

CONFIG += c++11

#CONFIG += qmltypes
#QML_IMPORT_NAME = QuickMorphism
#QML_IMPORT_MAJOR_VERSION = 1
#QML_IMPORT_MINOR_VERSION = 0

QML_IMPORT_PATH += $$PWD

QML_DESIGNER_IMPORT_PATH = $$PWD

INCLUDEPATH += $$PWD/src
INCLUDEPATH += $$PWD/src/config
INCLUDEPATH += $$PWD/src/ui
INCLUDEPATH += $$PWD/src/ui/theme

RESOURCES += \
    $$PWD/Quickmorphism/quickmorphism.qrc

HEADERS += \
    $$PWD/src/ui/quickmorphismui.h \
    $$PWD/src/quickmorphism.h \
    $$PWD/src/ui/theme/dark_theme.h \
    $$PWD/src/ui/theme/light_theme.h \
    $$PWD/src/ui/theme/theme.h


SOURCES += \
    $$PWD/src/ui/quickmorphismui.cpp \
    $$PWD/src/quickmorphism.cpp

include($$PWD/statusbar/statusbar.pri)

android: {
    QT += androidextras
}

ios {

    QT += gui-private

    QMAKE_CXXFLAGS += -fobjc-arc

    QMAKE_POST_LINK += /usr/libexec/PlistBuddy -c \"Add :UIViewControllerBasedStatusBarAppearance bool true\" $${OUT_PWD}/Info.plist
}
