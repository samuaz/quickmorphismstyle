TEMPLATE = app
TARGET = cutemorphismstyle

QT += quick quickcontrols2 widgets

SOURCES += main.cpp

RESOURCES += \
    cutemorphism.qrc \
    cutemorphismstyle.qml \
    qtquickcontrols2.conf \
    MainForm.ui.qml \
    Cutemorphism/Button.qml \
    Cutemorphism/CheckBox.qml \
    Cutemorphism/Switch.qml \
    Cutemorphism/SwitchDelegate.qml \
    Cutemorphism/TextField.qml \
    Cutemorphism/Image.qml \
    Cutemorphism/Elevation.qml \
    Cutemorphism/RoundImage.qml \
    imports/Cutemorphism/Cutemorphism.qml \
    imports/Cutemorphism/DirectoryFontLoader.qml \
    imports/Cutemorphism/qmldir

RESOURCES += \
    cutemorphism.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/imports

INSTALLS += target


RESOURCES += \
    Cutemorphism/Elevation.qml \
    cutemorphism.qrc \
    cutemorphismstyle.qml \
    qtquickcontrols2.conf \
    MainForm.ui.qml \
    Cutemorphism/Button.qml \
    Cutemorphism/CheckBox.qml \
    Cutemorphism/Switch.qml \
    Cutemorphism/SwitchDelegate.qml \
    Cutemorphism/TextField.qml \
    Cutemorphism/Image.qml \
    Cutemorphism/RoundImage.qml \
    imports/Cutemorphism/Cutemorphism.qml \
    imports/Cutemorphism/DirectoryFontLoader.qml \
    imports/Cutemorphism/qmldir

RESOURCES += \
    cutemorphism.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD/imports

INSTALLS += target
