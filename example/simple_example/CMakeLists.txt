cmake_minimum_required(VERSION 3.21)

project(QuickMorphismStyleTest VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 REQUIRED COMPONENTS Core Quick QuickControls2)

qt_standard_project_setup()

qt_add_executable(QuickMorphismStyleTest
    main.cpp
)

qt_add_resources(QuickMorphismStyleTest "qml"
    PREFIX "/"
    FILES
        TestBasic.qml
        qtquickcontrols2.conf
)

target_link_libraries(QuickMorphismStyleTest PRIVATE
    Qt6::Core
    Qt6::Quick
    Qt6::QuickControls2
)