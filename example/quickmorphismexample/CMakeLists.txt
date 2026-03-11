cmake_minimum_required(VERSION 3.21)

project(quickmorphismexample
    VERSION 1.0.0
    LANGUAGES CXX
    DESCRIPTION "QuickMorphism Style Example Application"
)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Qt6 setup
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

# Android SDK version requirements
if(ANDROID)
    set(ANDROID_SDK_COMPILE_API 35 CACHE STRING "Android compile SDK version")
    set(QT_ANDROID_API_VERSION "android-35" CACHE STRING "Android API version for Qt")
endif()

# Find Qt6 components
find_package(Qt6 6.2 REQUIRED COMPONENTS
    Core
    Quick
    Gui
    Qml
    QuickControls2
)

qt_standard_project_setup()

# ===================================
# QuickMorphism as local subdirectory
# ===================================
# The library source is two levels up (../../) since we're inside example/quickmorphismexample/
set(QUICKMORPHISM_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../..")
add_subdirectory(${QUICKMORPHISM_SOURCE_DIR} quickmorphism_build)

# ===================================
# Example App 1: Direct QuickMorphism components
# ===================================
qt_add_executable(appquickmorphismexample
    main.cpp
)

qt_add_qml_module(appquickmorphismexample
    URI quickmorphismexample
    VERSION ${PROJECT_VERSION}
    NO_GENERATE_PLUGIN_SOURCE
    QML_FILES
        Demo.qml
        MainForm.ui.qml
)

set_target_properties(appquickmorphismexample PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.theopencompany.quickmorphismexample
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Android SDK configuration
if(ANDROID)
    set_target_properties(appquickmorphismexample PROPERTIES
        QT_ANDROID_SDK_BUILD_TOOLS_REVISION "35.0.0"
        QT_ANDROID_TARGET_SDK_VERSION 35
        QT_ANDROID_COMPILE_SDK_VERSION "android-35"
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
    )
endif()

target_link_libraries(appquickmorphismexample PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Gui
    Qt6::Qml
    Qt6::QuickControls2
    QuickMorphism
)

target_include_directories(appquickmorphismexample PRIVATE
    ${QUICKMORPHISM_SOURCE_DIR}/include
)

target_compile_definitions(appquickmorphismexample PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    QT_DEPRECATED_WARNINGS
)

# ===================================
# Example App 2: QQuickStyle approach
# ===================================
qt_add_executable(appquickmorphism_quickstyle
    main_quickstyle.cpp
)

qt_add_qml_module(appquickmorphism_quickstyle
    URI quickmorphismexample_quickstyle
    VERSION 1.0
    QML_FILES
        Demo_quickstyle.qml
)

set_target_properties(appquickmorphism_quickstyle PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.theopencompany.quickmorphism.quickstyle
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

if(ANDROID)
    set_target_properties(appquickmorphism_quickstyle PROPERTIES
        QT_ANDROID_SDK_BUILD_TOOLS_REVISION "35.0.0"
        QT_ANDROID_TARGET_SDK_VERSION 35
        QT_ANDROID_COMPILE_SDK_VERSION "android-35"
    )
endif()

target_link_libraries(appquickmorphism_quickstyle PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Gui
    Qt6::Qml
    Qt6::QuickControls2
    QuickMorphism
)

target_include_directories(appquickmorphism_quickstyle PRIVATE
    ${QUICKMORPHISM_SOURCE_DIR}/include
)

target_compile_definitions(appquickmorphism_quickstyle PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    QT_DEPRECATED_WARNINGS
)

# ===================================
# QML Import Paths for Qt Creator / Designer
# ===================================
# The parent QuickMorphism project already sets QML_IMPORT_PATH,
# but we extend it with the example's own build directory.
set(QML_IMPORT_PATH
    "${QUICKMORPHISM_SOURCE_DIR}"
    "${CMAKE_BINARY_DIR}/quickmorphism_build/qml"
    "${CMAKE_BINARY_DIR}"
    CACHE STRING "Qt Creator QML import paths" FORCE
)

set(QML_DESIGNER_IMPORT_PATH
    "${QUICKMORPHISM_SOURCE_DIR}"
    "${CMAKE_BINARY_DIR}/quickmorphism_build/qml"
    CACHE STRING "Qt Creator Designer QML import paths" FORCE
)

# Installation
include(GNUInstallDirs)

install(TARGETS appquickmorphismexample
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(TARGETS appquickmorphism_quickstyle
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Debug output
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "=== QuickMorphism Example Configuration ===")
    message(STATUS "QuickMorphism source: ${QUICKMORPHISM_SOURCE_DIR}")
    message(STATUS "QML import paths: ${QML_IMPORT_PATH}")
    message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
    message(STATUS "============================================")
endif()
