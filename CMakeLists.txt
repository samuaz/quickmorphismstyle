cmake_minimum_required(VERSION 3.16)

project(QuickMorphism VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR})
find_package(Qt6 COMPONENTS COMPONENTS Core Quick Gui Qml REQUIRED)

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
file(GLOB_RECURSE QML_RESOURCES LIST_DIRECTORIES false QuickMorphism/*.ttf qmldir)

#qt_add_resources(RESOURCES QuickMorphism/quickmorphism.qrc)
set(QML_IMPORT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/QuickMorphism" CACHE STRING "Qt Creator QuickMorphism paths")


if(ANDROID)
    qt_add_library(${PROJECT_NAME} SHARED
        ${PROJECT_SOURCES}
        ${STATUSBAR_COMMON_SOURCES}
        ${STATUSBAR_PLATFORM_SOURCES}
        ${RESOURCES}
    )
qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    VERSION 1.0
    QML_FILES
        ${QML_SOURCES}
    SOURCES
        ${PROJECT_SOURCES}
        ${STATUSBAR_COMMON_SOURCES}
        ${STATUSBAR_PLATFORM_SOURCES}
    RESOURCES
        ${RESOURCES}
        ${QML_RESOURCES}
)
else()
    qt_add_library(${PROJECT_NAME} STATIC
      ${PROJECT_SOURCES}
      ${STATUSBAR_COMMON_SOURCES}
      ${STATUSBAR_PLATFORM_SOURCES}
      ${RESOURCES}
    )

qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    VERSION 1.0
    QML_FILES
        ${QML_SOURCES}
    SOURCES
        ${PROJECT_SOURCES}
        ${STATUSBAR_COMMON_SOURCES}
        ${STATUSBAR_PLATFORM_SOURCES}
    RESOURCES
        ${RESOURCES}
        ${QML_RESOURCES}
)
endif()

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER dev.theopencompany
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
target_include_directories(${PROJECT_NAME}plugin PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/QuickMorphismStyle)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/QuickMorphismStyle/statusbar/)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/QuickMorphismStyle/ui)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include/QuickMorphismStyle/ui/theme)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(${PROJECT_NAME})
    qt_finalize_executable(${PROJECT_NAME})
endif()


set(CMAKE_INCLUDE_CURRENT_DIR ON)

include(GenerateExportHeader)
generate_export_header(${PROJECT_NAME})
