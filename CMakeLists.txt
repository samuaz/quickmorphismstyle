cmake_minimum_required(VERSION 3.21)

project(QuickMorphism 
    VERSION 1.0.0 
    LANGUAGES CXX
    DESCRIPTION "Neumorphism UI Style Kit for Qt6"
)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Qt6 setup
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

# Find Qt6 components
find_package(Qt6 6.2 REQUIRED COMPONENTS 
    Core 
    Quick 
    Gui 
    Qml 
    QuickControls2
)

# Platform specific components
if(ANDROID)
    find_package(Qt6 REQUIRED COMPONENTS Core5Compat)
endif()

if(IOS)
    find_package(Qt6 REQUIRED COMPONENTS Core5Compat)
endif()

# Position independent code
if(Qt6_POSITION_INDEPENDENT_CODE)
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()

# Source files
set(PROJECT_SOURCES
    src/quickmorphism.cpp
    src/ui/quickmorphismui.cpp
    src/ui/snackbar.cpp
    include/QuickMorphismStyle/quickmorphism.h
    include/QuickMorphismStyle/ui/quickmorphismui.h
    include/QuickMorphismStyle/ui/snackbar.h
)

# Theme headers (if they exist)
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/include/QuickMorphismStyle/ui/theme")
    list(APPEND PROJECT_SOURCES
        include/QuickMorphismStyle/ui/theme/dark_theme.h
        include/QuickMorphismStyle/ui/theme/light_theme.h
        include/QuickMorphismStyle/ui/theme/theme.h
    )
endif()

# StatusBar sources
set(STATUSBAR_COMMON_SOURCES
    include/QuickMorphismStyle/statusbar/statusbar.h
    include/QuickMorphismStyle/statusbar/statusbar_p.h
    src/statusbar/statusbar.cpp
)

# Platform-specific StatusBar sources
if(ANDROID)
    set(STATUSBAR_PLATFORM_SOURCES src/statusbar/statusbar_android.cpp)
elseif(IOS)
    set(STATUSBAR_PLATFORM_SOURCES src/statusbar/statusbar_ios.mm)
    set(STATUSBAR_PLATFORM_LIBS "-framework UIKit")
else()
    set(STATUSBAR_PLATFORM_SOURCES src/statusbar/statusbar_dummy.cpp)
endif()

# Create the main library
add_library(${PROJECT_NAME} STATIC
    ${PROJECT_SOURCES}
    ${STATUSBAR_COMMON_SOURCES}
    ${STATUSBAR_PLATFORM_SOURCES}
)

# Add resources manually using qt_add_resources
qt_add_resources(${PROJECT_NAME} "quickmorphism_qml"
    PREFIX "/"
    FILES
        QuickMorphism/ApplicationWindow.qml
        QuickMorphism/Button.qml
        QuickMorphism/CalendarPicker.qml
        QuickMorphism/Card.qml
        QuickMorphism/CheckBox.qml
        QuickMorphism/Chip.qml
        QuickMorphism/ComboBox.qml
        QuickMorphism/Config.qml
        QuickMorphism/DatePicker.qml
        QuickMorphism/Dialog.qml
        QuickMorphism/Elevation.qml
        QuickMorphism/FontAwesomeRegular.qml
        QuickMorphism/Fonts.qml
        QuickMorphism/Icons.qml
        QuickMorphism/Image.qml
        QuickMorphism/Label.qml
        QuickMorphism/ListItem.qml
        QuickMorphism/Page.qml
        QuickMorphism/ProgressBar.qml
        QuickMorphism/QuickMorphismUI.qml
        QuickMorphism/Required.qml
        QuickMorphism/Ripple.qml
        QuickMorphism/RoundImage.qml
        QuickMorphism/ScrollableContainer.qml
        QuickMorphism/Separator.qml
        QuickMorphism/SnackBar.qml
        QuickMorphism/Switch.qml
        QuickMorphism/SwitchDelegate.qml
        QuickMorphism/TabBar.qml
        QuickMorphism/TabButton.qml
        QuickMorphism/TextField.qml
        QuickMorphism/Title.qml
        QuickMorphism/ToolBar.qml
        QuickMorphism/ToolButton.qml
        QuickMorphism/def/DirectoryFontLoader.qml
        QuickMorphism/themes/QuickMorphismDarkTheme.qml
        QuickMorphism/themes/QuickMorphismLightTheme.qml
        QuickMorphism/qmldir
        QuickMorphism/def/qmldir
        QuickMorphism/themes/qmldir
        QuickMorphism/assets/font/fa-brands-400.ttf
        QuickMorphism/assets/font/fa-regular-400.ttf
        QuickMorphism/assets/font/fa-solid-900.ttf
        QuickMorphism/assets/font/NunitoSans-Regular.ttf
        QuickMorphism/assets/font/NunitoSans-Bold.ttf
        QuickMorphism/assets/font/NunitoSans-Light.ttf
        QuickMorphism/assets/font/OpenSans-Regular.ttf
        QuickMorphism/assets/font/OpenSans-Bold.ttf
)

# =============================================================================
# Copy QuickMorphism QML module to build directory for Designer/Creator access
# =============================================================================
# Qt Creator's QML Designer needs QML files ON DISK (not in qrc://) to render
# components in design mode. We copy the entire QuickMorphism module to the
# build directory so both the base module and the style module are discoverable.

# Copy base QuickMorphism QML module to build/qml/QuickMorphism/
file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/QuickMorphism/"
    DESTINATION "${CMAKE_BINARY_DIR}/qml/QuickMorphism"
    FILES_MATCHING
        PATTERN "*.qml"
        PATTERN "qmldir"
        PATTERN "*.ttf"
        PATTERN "*.qmltypes"
)

# Copy designer metainfo for Qt Creator component palette
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/designer")
    file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/designer/"
        DESTINATION "${CMAKE_BINARY_DIR}/qml/QuickMorphism/designer"
        FILES_MATCHING PATTERN "*.metainfo"
    )
endif()

# Also keep a copy under the build dir root for legacy discovery
file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/QuickMorphism/"
    DESTINATION "${CMAKE_BINARY_DIR}/QuickMorphism"
    FILES_MATCHING
        PATTERN "*.qml"
        PATTERN "qmldir"
        PATTERN "*.ttf"
        PATTERN "*.qmltypes"
)

# =============================================================================
# QuickMorphism Style for Qt Quick Controls (QQuickStyle system)
# =============================================================================
# For Qt Quick Controls custom styles, the QML files must be in:
#   <import-path>/QtQuick/Controls/QuickMorphism/
# This allows QQuickStyle::setStyle("QuickMorphism") to discover the style.

# Copy style proxy components to the Qt Quick Controls style directory
set(QM_STYLE_OUTPUT_DIR "${CMAKE_BINARY_DIR}/qml/QtQuick/Controls/QuickMorphism")
file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/styles/QuickMorphism/"
    DESTINATION "${QM_STYLE_OUTPUT_DIR}"
    FILES_MATCHING
        PATTERN "*.qml"
        PATTERN "qmldir"
)

# Also create a qt_add_qml_module for QuickMorphismStyle URI
# (this generates proper type info for Qt Creator)
qt_add_qml_module(QuickMorphismStyleModule
    URI QuickMorphismStyle
    VERSION 1.0
    OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml/QuickMorphismStyle"
    QML_FILES
        styles/QuickMorphism/ApplicationWindow.qml
        styles/QuickMorphism/Button.qml
        styles/QuickMorphism/CalendarPicker.qml
        styles/QuickMorphism/CheckBox.qml
        styles/QuickMorphism/Elevation.qml
        styles/QuickMorphism/Label.qml
        styles/QuickMorphism/Page.qml
        styles/QuickMorphism/Switch.qml
        styles/QuickMorphism/TextField.qml
        styles/QuickMorphism/Title.qml
    DEPENDENCIES
        Qt6::Quick
        Qt6::QuickControls2
)

# Prevent QuickMorphismStyleModule from being treated as a deployable Android target.
# Without this, Qt Creator may try to deploy the style library instead of the actual app.
set_target_properties(QuickMorphismStyleModule PROPERTIES
    QT_ANDROID_DEPLOYMENT_DEPENDENCIES ""
    _qt_is_android_executable FALSE
)
if(TARGET QuickMorphismStyleModuleplugin)
    set_target_properties(QuickMorphismStyleModuleplugin PROPERTIES
        QT_ANDROID_DEPLOYMENT_DEPENDENCIES ""
        _qt_is_android_executable FALSE
    )
endif()

# =============================================================================
# Auto-refresh QML files on rebuild (for iterative design workflow)
# =============================================================================
add_custom_target(quickmorphism_copy_qml ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_CURRENT_SOURCE_DIR}/QuickMorphism"
        "${CMAKE_BINARY_DIR}/qml/QuickMorphism"
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_CURRENT_SOURCE_DIR}/styles/QuickMorphism"
        "${QM_STYLE_OUTPUT_DIR}"
    COMMENT "Copying QuickMorphism QML files to build directory for Designer access"
)

# Link libraries
target_link_libraries(${PROJECT_NAME} PUBLIC
    Qt6::Core
    Qt6::Quick
    Qt6::Gui
    Qt6::Qml
    Qt6::QuickControls2
    ${STATUSBAR_PLATFORM_LIBS}
)

# Platform-specific linking
if(ANDROID)
    target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Core5Compat)
endif()

if(IOS)
    target_link_libraries(${PROJECT_NAME} PRIVATE Qt6::Core5Compat)
endif()

# Include directories
target_include_directories(${PROJECT_NAME} PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

# Compile definitions
target_compile_definitions(${PROJECT_NAME} PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    QT_DEPRECATED_WARNINGS
)

# Target properties
set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.theopencompany.quickmorphism
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION}
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
)

# =============================================================================
# Qt Creator / Qt Design Studio support
# =============================================================================
# QML_IMPORT_PATH: Used by Qt Creator to resolve QML modules in the editor
# QML_DESIGNER_IMPORT_PATH: Used specifically by the QML Designer/Form Editor
#
# Both must include paths where qmldir files exist ON DISK.
# The source dir has QuickMorphism/qmldir, the build/qml dir has generated modules.

set(QML_IMPORT_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_BINARY_DIR}/qml"
    "${CMAKE_BINARY_DIR}"
    CACHE STRING "Qt Creator QML import paths" FORCE
)

set(QML_DESIGNER_IMPORT_PATH
    "${CMAKE_CURRENT_SOURCE_DIR}"
    "${CMAKE_BINARY_DIR}/qml"
    CACHE STRING "Qt Creator Designer QML import paths" FORCE
)

# =============================================================================
# Installation Configuration (must be defined BEFORE install() commands)
# =============================================================================
include(GNUInstallDirs)

option(QUICKMORPHISM_INSTALL_IN_QT_DIR "Install QuickMorphism style in Qt's standard location" OFF)
set(QUICKMORPHISM_STYLE_INSTALL_DIR "" CACHE PATH "Custom installation directory for QuickMorphism style (leave empty for build directory)")

# Configure style installation paths
if(QUICKMORPHISM_INSTALL_IN_QT_DIR)
    # Install in Qt's standard style directory
    get_target_property(QT_QMAKE_EXECUTABLE Qt6::qmake IMPORTED_LOCATION)
    execute_process(COMMAND ${QT_QMAKE_EXECUTABLE} -query QT_INSTALL_QML
                    OUTPUT_VARIABLE QT_QML_DIR
                    OUTPUT_STRIP_TRAILING_WHITESPACE)
    set(QUICKMORPHISM_FINAL_INSTALL_DIR "${QT_QML_DIR}/QtQuick/Controls/QuickMorphism")
    set(QUICKMORPHISM_MODULE_INSTALL_DIR "${QT_QML_DIR}/QuickMorphism")
elseif(QUICKMORPHISM_STYLE_INSTALL_DIR)
    # Use custom directory
    set(QUICKMORPHISM_FINAL_INSTALL_DIR "${QUICKMORPHISM_STYLE_INSTALL_DIR}/QtQuick/Controls/QuickMorphism")
    set(QUICKMORPHISM_MODULE_INSTALL_DIR "${QUICKMORPHISM_STYLE_INSTALL_DIR}/QuickMorphism")
else()
    # Default: use build directory (development mode)
    set(QUICKMORPHISM_FINAL_INSTALL_DIR "${CMAKE_BINARY_DIR}/qml/QtQuick/Controls/QuickMorphism")
    set(QUICKMORPHISM_MODULE_INSTALL_DIR "${CMAKE_BINARY_DIR}/qml/QuickMorphism")
endif()

message(STATUS "QuickMorphism style will be available at: ${QUICKMORPHISM_FINAL_INSTALL_DIR}")
message(STATUS "QuickMorphism module will be available at: ${QUICKMORPHISM_MODULE_INSTALL_DIR}")

# Install the library
install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Install headers
install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FILES_MATCHING PATTERN "*.h"
)

# Install QuickMorphism original module (QML files + qmltypes)
install(DIRECTORY QuickMorphism/
    DESTINATION "${QUICKMORPHISM_MODULE_INSTALL_DIR}"
    FILES_MATCHING
        PATTERN "*.qml"
        PATTERN "qmldir"
        PATTERN "*.ttf"
        PATTERN "*.qmltypes"
        PATTERN "*.qrc"
)

# Install QuickMorphism style files (proxies)
install(DIRECTORY styles/QuickMorphism/
    DESTINATION "${QUICKMORPHISM_FINAL_INSTALL_DIR}"
    FILES_MATCHING
        PATTERN "*.qml"
        PATTERN "qmldir"
)

# Install designer metainfo
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/designer")
    install(DIRECTORY designer/
        DESTINATION "${QUICKMORPHISM_MODULE_INSTALL_DIR}/designer"
        FILES_MATCHING PATTERN "*.metainfo"
    )
endif()

# Install CMake helpers
install(FILES cmake/QuickMorphismStyleHelpers.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/QuickMorphism
)

# Debug output
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "Project version: ${PROJECT_VERSION}")
    message(STATUS "Install prefix: ${CMAKE_INSTALL_PREFIX}")
endif()