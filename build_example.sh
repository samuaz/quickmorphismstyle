#!/bin/bash

# Script para construir QuickMorphism y el ejemplo
# Uso: ./build_example.sh

set -e

QT_PATH="/Users/samuaz/Qt/6.9.1/macos"
PROJECT_ROOT="/Users/samuaz/Projects/toc/quickmorphismstyle"

echo "🔨 Construyendo QuickMorphism Style para Qt6.9..."

# Construir QuickMorphism primero
cd "$PROJECT_ROOT"
rm -rf build
mkdir -p build
cd build

echo "📦 Configurando QuickMorphism..."
cmake .. -DCMAKE_PREFIX_PATH="$QT_PATH" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX="$PROJECT_ROOT/install"

echo "⚡ Compilando QuickMorphism..."
make -j$(nproc)

echo "📋 Instalando QuickMorphism..."
make install

echo "🎯 Ahora construyendo el ejemplo..."

# Crear CMakeLists.txt alternativo para el ejemplo que use find_package
cd "$PROJECT_ROOT/example/quickmorphismexample"

# Crear CMakeLists.txt que use la instalación local
cat > CMakeLists_with_install.txt << 'EOF'
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
qt_standard_project_setup()

# Find Qt6 components
find_package(Qt6 6.2 REQUIRED COMPONENTS 
    Core Quick Gui Qml QuickControls2
)

# Find QuickMorphism from install directory
list(APPEND CMAKE_PREFIX_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../install")
find_package(QuickMorphism REQUIRED)

# Create executable
qt_add_executable(appquickmorphismexample main.cpp)

# Add QML module for the example
qt_add_qml_module(appquickmorphismexample
    URI quickmorphismexample
    VERSION ${PROJECT_VERSION}
    QML_FILES demo.qml MainForm.ui.qml
)

# Target properties
set_target_properties(appquickmorphismexample PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER com.theopencompany.quickmorphismexample
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Link libraries
target_link_libraries(appquickmorphismexample PRIVATE
    Qt6::Core Qt6::Quick Qt6::Gui Qt6::Qml Qt6::QuickControls2
    QuickMorphism::QuickMorphism
)

# Compile definitions
target_compile_definitions(appquickmorphismexample PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)
EOF

# Construir el ejemplo
rm -rf build_with_install
mkdir -p build_with_install
cd build_with_install

echo "📦 Configurando ejemplo..."
cmake .. -f ../CMakeLists_with_install.txt -DCMAKE_PREFIX_PATH="$QT_PATH"

echo "⚡ Compilando ejemplo..."
make -j$(nproc)

echo "✅ ¡Construcción completada!"
echo "🚀 Ejecutable creado en: $PROJECT_ROOT/example/quickmorphismexample/build_with_install/appquickmorphismexample"