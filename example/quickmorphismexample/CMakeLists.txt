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

# ===================================
# FetchContent for QuickMorphism
# ===================================
include(FetchContent)

FetchContent_Declare(
    QuickMorphism
    GIT_REPOSITORY https://github.com/samuaz/quickmorphismstyle.git
    GIT_TAG  qt6.9-migration-style # Specific commit from qt6.9-migration
    # Para usar la rama completa: GIT_TAG qt6.9-migration
)

message(STATUS "Fetching QuickMorphism from GitHub...")
FetchContent_MakeAvailable(QuickMorphism)

# Get properties for configuration
FetchContent_GetProperties(QuickMorphism)

message(STATUS "Finish QuickMorphism from GitHub")


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
    ${quickmorphism_SOURCE_DIR}/include
)

# ===================================
# QML Import Path Configuration for Qt Design Studio
# ===================================

# Configure paths for FetchContent
set(QUICKMORPHISM_QML_SOURCE "${quickmorphism_SOURCE_DIR}/QuickMorphism")
set(QUICKMORPHISM_BUILD_OUTPUT "${quickmorphism_BINARY_DIR}")

# Set QML import paths for Qt Creator and Qt Design Studio
set(QML_IMPORT_PATH 
    "${QUICKMORPHISM_QML_SOURCE}"          # Source QML files from FetchContent
    "${QUICKMORPHISM_BUILD_OUTPUT}"        # Build output from FetchContent
    "${CMAKE_CURRENT_BINARY_DIR}"          # Current build directory
    "${CMAKE_CURRENT_SOURCE_DIR}"          # Current source directory
    CACHE STRING "Qt Creator import paths" FORCE
)

# Export to CMakeCache.txt for Qt Design Studio
set(QML_IMPORT_PATH "${QML_IMPORT_PATH}" CACHE STRING "QML Import Paths" FORCE)

# Force CMake to write QML_IMPORT_PATH to qtcsettings.cmake for Qt Creator
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/qtcsettings.cmake" 
"# Qt Creator settings file
set(QML_IMPORT_PATH \"${QML_IMPORT_PATH}\")
set(QML_DESIGNER_IMPORT_PATH \"${QML_IMPORT_PATH}\")
")

# Also set it as a target property for Qt Creator's QML analyzer
set_target_properties(appquickmorphismexample PROPERTIES
    QT_QML_MODULE_INSTALL_QMLTYPES TRUE
    QT_QML_IMPORT_PATH "${QML_IMPORT_PATH}"
)

# Copy QuickMorphism QML files to build directory for Qt Design Studio
add_custom_command(TARGET appquickmorphismexample POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${quickmorphism_SOURCE_DIR}/QuickMorphism"
        "${CMAKE_CURRENT_BINARY_DIR}/QuickMorphism"
    COMMENT "Copying QuickMorphism QML files from FetchContent for Qt Design Studio"
)

# Create .qmllint.ini for Qt Creator QML analyzer
file(WRITE "${CMAKE_CURRENT_SOURCE_DIR}/.qmllint.ini"
"[General]
AdditionalQmlPath=${quickmorphism_SOURCE_DIR}/QuickMorphism
AdditionalQmlPath=${CMAKE_CURRENT_BINARY_DIR}/QuickMorphism
AdditionalQmlPath=${CMAKE_CURRENT_BINARY_DIR}
")

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
    message(STATUS "=== QuickMorphism FetchContent Configuration ===")
    message(STATUS "QuickMorphism source directory: ${quickmorphism_SOURCE_DIR}")
    message(STATUS "QuickMorphism binary directory: ${quickmorphism_BINARY_DIR}")
    message(STATUS "QML source path: ${QUICKMORPHISM_QML_SOURCE}")
    message(STATUS "QML import paths: ${QML_IMPORT_PATH}")
    message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
    message(STATUS "============================================")
endif()
