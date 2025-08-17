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
find_package(Qt6 6.9 REQUIRED COMPONENTS 
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

# Project configuration
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(QML_IMPORT_PATH "${CMAKE_BINARY_DIR}" CACHE STRING "Qt Creator import paths")

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

# QML files discovery
file(GLOB_RECURSE QML_SOURCES_LIST LIST_DIRECTORIES false 
    ${CMAKE_CURRENT_SOURCE_DIR}/QuickMorphism/*.qml
)

file(GLOB_RECURSE QML_RESOURCES_LIST LIST_DIRECTORIES false 
    ${CMAKE_CURRENT_SOURCE_DIR}/QuickMorphism/assets/font/*.ttf
    ${CMAKE_CURRENT_SOURCE_DIR}/QuickMorphism/qmldir
    ${CMAKE_CURRENT_SOURCE_DIR}/QuickMorphism/def/qmldir
)

# Convert to relative paths for QML module
set(QML_SOURCES "")
foreach(qml_file ${QML_SOURCES_LIST})
    file(RELATIVE_PATH qml_relative "${CMAKE_CURRENT_SOURCE_DIR}" "${qml_file}")
    list(APPEND QML_SOURCES "${qml_relative}")
endforeach()

set(QML_RESOURCES "")
foreach(resource_file ${QML_RESOURCES_LIST})
    file(RELATIVE_PATH resource_relative "${CMAKE_CURRENT_SOURCE_DIR}" "${resource_file}")
    list(APPEND QML_RESOURCES "${resource_relative}")
endforeach()

# Qt policies
qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

# Create the main library
qt_add_library(${PROJECT_NAME})

# Add QML module
qt_add_qml_module(${PROJECT_NAME}
    URI ${PROJECT_NAME}
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    QML_FILES
        ${QML_SOURCES}
    SOURCES
        ${PROJECT_SOURCES}
        ${STATUSBAR_COMMON_SOURCES}
        ${STATUSBAR_PLATFORM_SOURCES}
    RESOURCES
        ${QML_RESOURCES}
    RESOURCE_PREFIX /
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${PROJECT_NAME}
    IMPORT_PATH ${CMAKE_BINARY_DIR}
)

# Link libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
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

# Export header generation
include(GenerateExportHeader)
generate_export_header(${PROJECT_NAME}
    EXPORT_FILE_NAME include/${PROJECT_NAME}/quickmorphism_export.h
)

# Target properties
set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.theopencompany.quickmorphism
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION}
    AUTOMOC_MOC_OPTIONS "-Muri=${PROJECT_NAME}"
)

# Installation
include(GNUInstallDirs)

# Install the library
install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Install QML plugin
install(TARGETS ${PROJECT_NAME}plugin
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/qt6/qml/${PROJECT_NAME}/
)

# Install QML files
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/qmldir
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/qt6/qml/${PROJECT_NAME}/
)

# Install headers
install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FILES_MATCHING PATTERN "*.h"
)

# Install export header
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_NAME}/quickmorphism_export.h
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}/
)

# Config file for find_package
include(CMakePackageConfigHelpers)

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

install(EXPORT ${PROJECT_NAME}Targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

# Qt Creator support
set(QML_IMPORT_PATH "${CMAKE_BINARY_DIR}" CACHE STRING "Qt Creator import paths" FORCE)

# Debug output
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "QML Sources found: ${QML_SOURCES}")
    message(STATUS "QML Resources found: ${QML_RESOURCES}")
    message(STATUS "Project version: ${PROJECT_VERSION}")
    message(STATUS "Install prefix: ${CMAKE_INSTALL_PREFIX}")
endif()