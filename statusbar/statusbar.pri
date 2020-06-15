CONFIG += c++1z qtquickcompiler
INCLUDEPATH += $$PWD

HEADERS += \
    $$PWD/statusbar.h

SOURCES += \
    $$PWD/statusbar.cpp

android {
    QT += androidextras

    SOURCES += \
        $$PWD/statusbar_android.cpp
} else:ios {
    LIBS += -framework UIKit

    OBJECTIVE_SOURCES += \
        $$PWD/statusbar_ios.mm
} else {
    SOURCES += \
        $$PWD/statusbar_dummy.cpp
}
