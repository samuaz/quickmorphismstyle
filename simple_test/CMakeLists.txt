cmake_minimum_required(VERSION 3.21)

project(QuickMorphismSimpleTest VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Quick Gui Qml QuickControls2)

qt_standard_project_setup()

qt_add_executable(simple_test
    main.cpp
)

qt_add_qml_module(simple_test
    URI QuickMorphismSimpleTest
    VERSION 1.0
    QML_FILES
        main.qml
)

target_link_libraries(simple_test PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::Gui
    Qt6::Qml
    Qt6::QuickControls2
)