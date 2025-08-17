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

# Find Qt6 components
find_package(Qt6 6.2 REQUIRED COMPONENTS 
    Core 
    Quick 
    Gui 
    Qml 
    QuickControls2
)

# Qt6 setup
qt_standard_project_setup()

# Add the QuickMorphismStyle as a subdirectory
# This uses the local version in the parent directory
set(QUICKMORPHISM_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../)
add_subdirectory(${QUICKMORPHISM_SOURCE_DIR} quickmorphism_build)

# Create executable
qt_add_executable(appquickmorphismexample
    main.cpp
)

# Add QML module for the example
qt_add_qml_module(appquickmorphismexample
    URI quickmorphismexample
    VERSION ${PROJECT_VERSION}
    NO_GENERATE_PLUGIN_SOURCE
    QML_FILES 
        Demo.qml 
        MainForm.ui.qml
)

# Target properties
set_target_properties(appquickmorphismexample PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.theopencompany.quickmorphismexample
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Link libraries
target_link_libraries(appquickmorphismexample PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Gui
    Qt6::Qml
    Qt6::QuickControls2
    QuickMorphism
)

# Include directories for headers
target_include_directories(appquickmorphismexample PRIVATE
    ${QUICKMORPHISM_SOURCE_DIR}/include
)

# Set QML import path for Qt Creator
set(QML_IMPORT_PATH 
    "${CMAKE_BINARY_DIR}/quickmorphism_build"
    "${CMAKE_BINARY_DIR}"
    CACHE STRING "Qt Creator import paths" FORCE
)

# Compile definitions
target_compile_definitions(appquickmorphismexample PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
    QT_DEPRECATED_WARNINGS
)

# Installation
include(GNUInstallDirs)

install(TARGETS appquickmorphismexample
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Debug output
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    message(STATUS "QuickMorphism source directory: ${QUICKMORPHISM_SOURCE_DIR}")
    message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
    message(STATUS "QML import paths: ${QML_IMPORT_PATH}")
endif()