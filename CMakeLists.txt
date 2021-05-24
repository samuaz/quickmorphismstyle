cmake_minimum_required(VERSION 3.14)

project(QuickMorphismStyle VERSION 0.1 LANGUAGES CXX)

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
    src/quickmorphism.cpp
    src/ui/quickmorphismui.cpp
    src/ui/snackbar.cpp
    include/QuickMorphismStyle/quickmorphism.h
    include/QuickMorphismStyle/ui/quickmorphismui.h
    include/QuickMorphismStyle/ui/snackbar.h
    include/QuickMorphismStyle/ui/theme/dark_theme.h
    include/QuickMorphismStyle/ui/theme/light_theme.h
    include/QuickMorphismStyle/ui/theme/theme.h
    QuickMorphism/quickmorphism.qrc
)

add_subdirectory(statusbar)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_library(${PROJECT_NAME}
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
else()
    if(ANDROID)
        add_library(${PROJECT_NAME} SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_library(${PROJECT_NAME}
          ${PROJECT_SOURCES}
        )
    endif()
endif()

target_compile_definitions(${PROJECT_NAME}
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME}
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick QuickMorphismStatusBar)

set_target_properties(${PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER dev.theopencompany.${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(${PROJECT_NAME})
    qt_finalize_executable(${PROJECT_NAME})
endif()

target_include_directories(${PROJECT_NAME} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include/${PROJECT_NAME}>
        )

set(WINTER_INSTALL_DIR "$ENV{HOME}/winter-release/winter")

install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/include/" # source directory
            DESTINATION ${WINTER_INSTALL_DIR}/include/${PROJECT_NAME} # target directory
            FILES_MATCHING # install only matched files
            PATTERN "*.h*" # select header files
            )
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/include/" # source directory
            DESTINATION ${WINTER_INSTALL_DIR}/include/${PROJECT_NAME} # target directory
            FILES_MATCHING # install only matched files
            PATTERN "*.tpp*" # select header files
            )
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/cmake" # source directory
            DESTINATION ${WINTER_INSTALL_DIR}/include/${PROJECT_NAME}/cmake # target directory
            FILES_MATCHING # install only matched files
            PATTERN "*.cmake*" # select header files
            )
