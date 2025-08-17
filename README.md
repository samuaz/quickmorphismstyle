# QuickMorphismStyle

A modern UI Kit for QML based on the Neumorphism design style, built for Qt6.9+.

## 🚀 Features

- ✅ **Qt6.9 Support** - Fully migrated and optimized for Qt6.9
- ✅ **Neumorphic Components** - Beautiful soft UI elements  
- ✅ **Cross-Platform** - macOS, Android, iOS support
- ✅ **CMake Integration** - Modern build system with FetchContent support
- ✅ **Qt Design Studio Ready** - Components available in visual editor
- ✅ **Example Project** - Complete integration example

## 📋 Quick Start

```bash
# Clone the repository
git clone https://github.com/samuaz/quickmorphismstyle.git
cd quickmorphismstyle

# Build the library
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/path/to/qt/6.9.x"
make -j$(nproc)

# Try the example
cd ../example/quickmorphismexample
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/path/to/qt/6.9.x"
make -j$(nproc)
```

## 📁 Project Structure

- **`QuickMorphism/`** - QML components and themes
- **`include/`** - C++ headers
- **`src/`** - C++ implementation  
- **`example/`** - Integration examples and documentation
- **`cmake/`** - CMake configuration files
- **`designer/`** - Qt Design Studio integration
