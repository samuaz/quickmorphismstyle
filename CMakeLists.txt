cmake_minimum_required(VERSION 3.14)

project(quickmorphism VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# QtCreator supports the following variables for Android, which are identical to qmake Android variables.
# Check https://doc.qt.io/qt/deployment-android.html for more information.
# They need to be set before the find_package(...) calls below.

#if(ANDROID)
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    if (ANDROID_ABI STREQUAL "armeabi-v7a")
#        set(ANDROID_EXTRA_LIBS
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libcrypto.so
#            ${CMAKE_CURRENT_SOURCE_DIR}/path/to/libssl.so)
#    endif()
#endif()

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)

set(PROJECT_SOURCES
    src/quickmorphism.cpp src/quickmorphism.h
    src/ui/quickmorphismui.cpp src/ui/quickmorphismui.h
    src/ui/snackbar.cpp src/ui/snackbar.h
    src/ui/theme/dark_theme.h
    src/ui/theme/light_theme.h
    src/ui/theme/theme.h
    QuickMorphism/quickmorphism.qrc
)

add_subdirectory(statusbar)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_library(quickmorphism
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
else()
    if(ANDROID)
        add_library(quickmorphism SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_library(quickmorphism
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_compile_definitions(quickmorphism
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(quickmorphism
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick StatusBar)

set_target_properties(quickmorphism PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(quickmorphism)
    qt_finalize_executable(quickmorphism)
endif()