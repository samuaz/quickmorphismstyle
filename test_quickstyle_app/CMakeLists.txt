cmake_minimum_required(VERSION 3.21)

project(test_quickstyle_app LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

qt_standard_project_setup()

qt_add_executable(test_quickstyle_app
    main.cpp
)

qt_add_qml_module(test_quickstyle_app
    URI test_quickstyle_app
    VERSION 1.0
    QML_FILES
        main.qml
)

target_link_libraries(test_quickstyle_app PRIVATE Qt6::Quick Qt6::QuickControls2)

set_target_properties(test_quickstyle_app PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)