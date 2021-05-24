# Generated from quickmorphismexample.pro.

#####################################################################
## quickmorphismexample Binary:
#####################################################################

qt_internal_add_executable(quickmorphismexample
    GUI
    SOURCES
        ../../src/quickmorphism.cpp ../../src/quickmorphism.h
        ../../src/ui/quickmorphismui.cpp ../../src/ui/quickmorphismui.h
        ../../src/ui/snackbar.cpp ../../src/ui/snackbar.h
        ../../src/ui/theme/dark_theme.h
        ../../src/ui/theme/light_theme.h
        ../../src/ui/theme/theme.h
        ../../statusbar/statusbar.cpp ../../statusbar/statusbar.h
        main.cpp
    DEFINES
        QT_DEPRECATED_WARNINGS
    INCLUDE_DIRECTORIES
        ../../src
        ../../src/config
        ../../src/ui
        ../../src/ui/theme
        ../../statusbar
    PUBLIC_LIBRARIES
        Qt::Gui
        Qt::Quick
)

# Resources:
set(qml_resource_files
    "Demo.qml"
    "MainForm.ui.qml"
)

qt_internal_add_resource(quickmorphismexample "qml"
    PREFIX
        "/"
    FILES
        ${qml_resource_files}
)
set(quickmorphism_resource_files
    "../../QuickMorphism/ApplicationWindow.qml"
    "../../QuickMorphism/Button.qml"
    "../../QuickMorphism/CalendarPicker.qml"
    "../../QuickMorphism/CheckBox.qml"
    "../../QuickMorphism/Config.qml"
    "../../QuickMorphism/DatePicker.qml"
    "../../QuickMorphism/Elevation.qml"
    "../../QuickMorphism/FontAwesomeRegular.qml"
    "../../QuickMorphism/Fonts.qml"
    "../../QuickMorphism/Icons.qml"
    "../../QuickMorphism/Image.qml"
    "../../QuickMorphism/Label.qml"
    "../../QuickMorphism/Page.qml"
    "../../QuickMorphism/QuickMorphismUI.qml"
    "../../QuickMorphism/Required.qml"
    "../../QuickMorphism/RoundImage.qml"
    "../../QuickMorphism/ScrollableContainer.qml"
    "../../QuickMorphism/SnackBar.qml"
    "../../QuickMorphism/Switch.qml"
    "../../QuickMorphism/SwitchDelegate.qml"
    "../../QuickMorphism/TextField.qml"
    "../../QuickMorphism/Title.qml"
    "../../QuickMorphism/ToolBar.qml"
    "../../QuickMorphism/ToolButton.qml"
    "../../QuickMorphism/assets/font/NunitoSans-Black.ttf"
    "../../QuickMorphism/assets/font/NunitoSans-Bold.ttf"
    "../../QuickMorphism/assets/font/NunitoSans-Italic.ttf"
    "../../QuickMorphism/assets/font/NunitoSans-Light.ttf"
    "../../QuickMorphism/assets/font/NunitoSans-Regular.ttf"
    "../../QuickMorphism/assets/font/fa-brands-400.ttf"
    "../../QuickMorphism/assets/font/fa-regular-400.ttf"
    "../../QuickMorphism/assets/font/fa-solid-900.ttf"
    "../../QuickMorphism/def/Constants.qml"
    "../../QuickMorphism/def/DirectoryFontLoader.qml"
    "../../QuickMorphism/def/qmldir"
    "../../QuickMorphism/qmldir"
    "../../QuickMorphism/themes/QuickMorphismDarkTheme.qml"
    "../../QuickMorphism/themes/QuickMorphismLightTheme.qml"
)

qt_internal_add_resource(quickmorphismexample "quickmorphism"
    PREFIX
        "/QuickMorphism"
    BASE
        "../../QuickMorphism"
    FILES
        ${quickmorphism_resource_files}
)
set(qmake_immediate_resource_files
    "qtquickcontrols2.conf"
)

qt_internal_add_resource(quickmorphismexample "qmake_immediate"
    PREFIX
        "/"
    FILES
        ${qmake_immediate_resource_files}
)


#### Keys ignored in scope 1:.:.:quickmorphismexample.pro:<TRUE>:
# QML_DESIGNER_IMPORT_PATH = "$$PWD"
# QML_IMPORT_PATH = "$$PWD"
# TRANSLATIONS = "quickmorphismexample_en_US.ts"

## Scopes:
#####################################################################

#### Keys ignored in scope 2:.:.:quickmorphismexample.pro:QNX:
# target.path = "/tmp/$${TARGET}/bin"

#### Keys ignored in scope 4:.:.:quickmorphismexample.pro:UNIX AND NOT ANDROID:
# target.path = "/opt/$${TARGET}/bin"

#### Keys ignored in scope 5:.:.:quickmorphismexample.pro:NOT target.path_ISEMPTY:
# INSTALLS = "target"

qt_internal_extend_target(quickmorphismexample CONDITION ANDROID
    SOURCES
        ../../statusbar/statusbar_android.cpp
    PUBLIC_LIBRARIES
        Qt::AndroidExtras
)

qt_internal_extend_target(quickmorphismexample CONDITION IOS
    SOURCES
        ../../statusbar/statusbar_ios.mm
    PUBLIC_LIBRARIES
        ${FWUIKit}
        Qt::GuiPrivate
    COMPILE_OPTIONS
        -fobjc-arc
)

#### Keys ignored in scope 8:.:../..:../../quickmorphism.pri:IOS:
# QMAKE_POST_LINK = "/usr/libexec/PlistBuddy" "-c" "\"Add" ":UIViewControllerBasedStatusBarAppearance" "bool" "true\"" "$${OUT_PWD}/Info.plist"

qt_internal_extend_target(quickmorphismexample CONDITION NOT ANDROID AND NOT IOS
    SOURCES
        ../../statusbar/statusbar_dummy.cpp
)
