cmake_minimum_required(VERSION 3.18)

project(QuickMorphismExample VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

#set(Qt5Core_DIR "/home/samuaz/Qt/5.15.2/gcc_64/lib/cmake/Qt5Core")
#set(Qt5_DIR "/home/samuaz/Qt/5.15.2/gcc_64/lib/cmake/Qt5")
#set(QT_QMAKE_EXECUTABLE "/home/samuaz/Qt/5.15.2/gcc_64/bin/qmake")
#set(CMAKE_PREFIX_PATH "/home/samuaz/Qt/5.15.2/gcc_64"  CACHE PATH "Initial cahe" FORCE)
#include_directories("/home/samuaz/Qt/5.15.2/gcc_64/include/")

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
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

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick LinguistTools REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick LinguistTools REQUIRED)

include(FetchContent)
set(FETCHCONTENT_QUIET OFF)
set(THIRD_PARTY_DIR ${CMAKE_SOURCE_DIR}/third_party)


FetchContent_Declare(
        QuickMorphismStyle
        GIT_REPOSITORY https://samuaz@bitbucket.org/samuaz/quickmorphismstyle.git
        GIT_TAG        CMAKE
        GIT_PROGRESS   TRUE
        SOURCE_DIR ${THIRD_PARTY_DIR}/QuickMorphismStyle
)
FetchContent_GetProperties(QuickMorphismStyle)
if(NOT QuickMorphismStyle_POPULATED)
    FetchContent_Populate(QuickMorphismStyle)
    add_subdirectory(${THIRD_PARTY_DIR}/QuickMorphismStyle)
endif()

#include(${THIRD_PARTY_DIR}/QuickMorphismStyle/CMakeLists.txt)

#FetchContent_Declare(
#        QuickMorphismStyle
#        GIT_REPOSITORY https://samuaz@bitbucket.org/samuaz/quickmorphismstyle.git
#        GIT_TAG        CMAKE
#        SOURCE_DIR ${THIRD_PARTY_DIR}/QuickMorphismStyle
#)
#FetchContent_MakeAvailable(QuickMorphismStyle)
set(QT_CREATOR_SKIP_PACKAGE_MANAGER_SETUP ON)

#include(${QuickMorphismStyle_SOURCE_DIR}/CMakeLists.txt)

set(TS_FILES QuickMorphismExample_es_ES.ts)

set(PROJECT_SOURCES
        main.cpp
        qml.qrc
        ${TS_FILES}
)


if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(QuickMorphismExample
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )

    qt_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
else()
    if(ANDROID)
        add_library(QuickMorphismExample SHARED
            ${PROJECT_SOURCES}
        )
    else()
        add_executable(QuickMorphismExample
          ${PROJECT_SOURCES}
        )
    endif()

    qt5_create_translation(QM_FILES ${CMAKE_SOURCE_DIR} ${TS_FILES})
endif()

target_compile_definitions(QuickMorphismExample
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(QuickMorphismExample
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick QuickMorphismStyle)

set_target_properties(QuickMorphismExample PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(QuickMorphismExample)
    qt_finalize_executable(QuickMorphismExample)
endif()


