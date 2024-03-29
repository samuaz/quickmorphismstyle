cmake_minimum_required(VERSION 3.16)

project(QuickMorphismStyle VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR})
find_package(Qt6 6.2 COMPONENTS COMPONENTS Core Quick Gui Qml REQUIRED)

if(ANDROID)
    find_package(QT NAMES Qt6 COMPONENTS AndroidExtras REQUIRED)
    find_package(Qt${QT_VERSION_MAJOR} AndroidExtras REQUIRED)
endif()

# prevent error "You must build your code with position independent code if Qt was built with..
if (Qt5_POSITION_INDEPENDENT_CODE OR Qt6_POSITION_INDEPENDENT_CODE)
  SET(CMAKE_POSITION_INDEPENDENT_CODE ON)
endif()


set(PROJECT_SOURCES
    src/quickmorphism.cpp
    src/ui/quickmorphismui.cpp
    src/ui/snackbar.cpp
    include/QuickMorphismStyle/quickmorphism.h
    include/QuickMorphismStyle/ui/quickmorphismui.h
    include/QuickMorphismStyle/ui/snackbar.h
    include/QuickMorphismStyle/ui/theme/dark_theme.h
    include/QuickMorphismStyle/ui/theme/light_theme.h
    include/QuickMorphismStyle/ui/theme/theme.h
)

##### STATUSBAR

set(STATUSBAR_COMMON_SOURCES
include/QuickMorphismStyle/statusbar/statusbar.h
src/statusbar/statusbar.cpp
)

if (ANDROID)
set(STATUSBAR_PLATFORM_SOURCES src/statusbar/statusbar_android.cpp)
elseif (CMAKE_SYSTEM_NAME STREQUAL iOS)
set(STATUSBAR_PLATFORM_SOURCES src/statusbar/statusbar_ios.mm)
set(STATUSBAR_PLATFORM_LIBS "-framework UIKit")
else()
set(STATUSBAR_PLATFORM_SOURCES src/statusbar/statusbar_dummy.cpp)
endif()

#####

file(GLOB_RECURSE QML_SOURCES LIST_DIRECTORIES false QuickMorphism/*.qml)
file(GLOB_RECURSE QML_RESOURCES LIST_DIRECTORIES false QuickMorphism/*.ttf)

qt_add_resources(RESOURCES QuickMorphism/quickmorphism.qrc)
set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}" CACHE STRING "Qt Creator QuickMorphism paths")

#qt_add_library(${PROJECT_NAME} STATIC ${PROJECT_SOURCES} ${STATUSBAR_COMMON_SOURCES} ${STATUSBAR_PLATFORM_SOURCES})
#qt_add_qml_module(QuickMorphismStyle
#    URI QuickMorphismStyle
#    VERSION 1.0
#    QML_FILES ${QML_SOURCES}
#    RESOURCES ${QML_RESOURCES}
#    SOURCES ${PROJECT_SOURCES} ${STATUSBAR_COMMON_SOURCES} ${STATUSBAR_PLATFORM_SOURCES}
#)

#qt_add_qml_module(Statusbar
#    VERSION 1.0
#    URI Statusbar
#    SOURCES ${STATUSBAR_COMMON_SOURCES} ${STATUSBAR_PLATFORM_SOURCES}
#)

##### CREATE LIBRARY

if(ANDROID)
    add_library(${PROJECT_NAME} SHARED
        ${PROJECT_SOURCES}
        ${STATUSBAR_COMMON_SOURCES}
        ${STATUSBAR_PLATFORM_SOURCES}
        ${RESOURCES}
    )
else()
    add_library(${PROJECT_NAME}
      ${PROJECT_SOURCES}
      ${STATUSBAR_COMMON_SOURCES}
      ${STATUSBAR_PLATFORM_SOURCES}
      ${RESOURCES}
    )
endif()

#####

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER dev.theopencompany.${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(${PROJECT_NAME}
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)


  if(ANDROID)
    target_link_libraries(${PROJECT_NAME}
                            PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Gui Qt${QT_VERSION_MAJOR}::Qml Qt${QT_VERSION_MAJOR}::AndroidExtras ${STATUSBAR_PLATFORM_LIBS})

    else()
    target_link_libraries(${PROJECT_NAME}
                            PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Gui Qt${QT_VERSION_MAJOR}::Qml ${STATUSBAR_PLATFORM_LIBS})
endif()


target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(${PROJECT_NAME})
    qt_finalize_executable(${PROJECT_NAME})
endif()


# Example Project
#qt_add_executable(ExampleProject example/example.cpp)
#qt_add_qml_module(ExampleProject
#    URI ExampleProjectApp
#    VERSION 1.0
#    QML_FILES example/example.qml
#)
#target_link_libraries(ExampleProject PRIVATE Qt6::Quick QuickMorphismStyleplugin)
#target_compile_definitions(ExampleProject PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)

