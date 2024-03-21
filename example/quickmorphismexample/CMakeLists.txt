cmake_minimum_required(VERSION 3.16)

project(quickmorphismexample VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR})
set(Qt6_DIR ${Qt6_DIR})
set(QT_DIR ${Qt6_DIR})


find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml QuickControls2)


qt_add_executable(appquickmorphismexample
    main.cpp
)

qt_add_qml_module(appquickmorphismexample
    URI quickmorphismexample
    VERSION 1.0
    QML_FILES demo.qml MainForm.ui.qml
)

include(FetchContent)
set(FETCHCONTENT_QUIET OFF)
set(THIRD_PARTY_DIR ${CMAKE_SOURCE_DIR}/third_party)

FetchContent_Declare(
        QuickMorphismStyle
        GIT_REPOSITORY git@github.com:samuaz/quickmorphismstyle.git
        GIT_TAG        QT6-PLUGIN-2
        GIT_PROGRESS   TRUE
        SOURCE_DIR ${THIRD_PARTY_DIR}/QuickMorphismStyle
)
FetchContent_GetProperties(QuickMorphismStyle)
if(NOT QuickMorphismStyle_POPULATED)
    FetchContent_Populate(QuickMorphismStyle)
    add_subdirectory(${THIRD_PARTY_DIR}/QuickMorphismStyle)
endif()

#include(${THIRD_PARTY_DIR}/QuickMorphismStyle/CMakeLists.txt)

FetchContent_MakeAvailable(QuickMorphismStyle)

set(QML_IMPORT_PATH /Users/samuaz/Projects/toc/build-quickmorphismstyle-Qt_6_6_2_for_macOS-Debug/  /Users/samuaz/Projects/toc/build-quickmorphismstyle-Qt_6_6_2_for_macOS-Debug/QuickMorphism ${CMAKE_BINARY_DIR}/imports CACHE STRING "" FORCE)

#set(QML_IMPORT_PATH ${QuickMorphism_BINARY_DIR} ${CMAKE_BINARY_DIR}/imports CACHE STRING "" FORCE)


set_target_properties(appquickmorphismexample PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER theopencompany.dev
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appquickmorphismexample
    PRIVATE Qt6::Quick QuickMorphism QuickMorphismplugin)

install(TARGETS appquickmorphismexample
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})


