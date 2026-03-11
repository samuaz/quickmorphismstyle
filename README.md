# QuickMorphismStyle

A modern Neumorphism UI Kit for Qt6 QML. Provides soft, 3D-like UI components with customizable light and dark themes.

![Qt 6.2+](https://img.shields.io/badge/Qt-6.2%2B-green) ![CMake 3.21+](https://img.shields.io/badge/CMake-3.21%2B-blue) ![Platforms](https://img.shields.io/badge/Platforms-macOS%20%7C%20Android%20%7C%20iOS-lightgrey)

## Features

- Neumorphic components: Button, TextField, Switch, CheckBox, Label, Page, ToolBar, and more
- Light and Dark themes with runtime switching
- Custom theme support from QML and C++
- Qt Creator Design mode compatible
- Cross-platform: macOS, Android, iOS
- CMake integration with FetchContent and add_subdirectory support

## Quick Start

### Build

```bash
git clone https://github.com/samuaz/quickmorphismstyle.git
cd quickmorphismstyle
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/path/to/Qt/6.x.x/platform"
cmake --build . -j$(nproc)
```

### Use in Your Project

**Option A: add_subdirectory (recommended for development)**

```cmake
add_subdirectory(path/to/quickmorphismstyle quickmorphism_build)
target_link_libraries(your_app PRIVATE QuickMorphism)
target_include_directories(your_app PRIVATE path/to/quickmorphismstyle/include)
```

**Option B: FetchContent (recommended for production)**

```cmake
include(FetchContent)
FetchContent_Declare(
    QuickMorphism
    GIT_REPOSITORY https://github.com/samuaz/quickmorphismstyle.git
    GIT_TAG main
)
FetchContent_MakeAvailable(QuickMorphism)
target_link_libraries(your_app PRIVATE QuickMorphism)
```

### Initialize in C++

```cpp
#include <QuickMorphismStyle/quickmorphism.h>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Register types, load fonts, and set up theme singleton
    QuickMorphism::init(engine);

    engine.addImportPath(":/");
    engine.load(QUrl(u"qrc:/your_app/main.qml"_s));
    return app.exec();
}
```

### Use in QML

```qml
import QtQuick
import QtQuick.Controls
import QuickMorphism

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 640

    // Theme switcher
    QuickMorphismUI {
        id: quickMorphismUI
        theme: DefaultQuickMorphismLightTheme
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Button {
            text: "Neumorphic Button"
        }

        TextField {
            placeholderText: "Enter text..."
        }

        Switch {
            text: "Dark Mode"
            onCheckedChanged: {
                quickMorphismUI.theme = checked
                    ? DefaultQuickMorphismDarkTheme
                    : DefaultQuickMorphismLightTheme
            }
        }

        CheckBox {
            text: "Neumorphic CheckBox"
        }
    }
}
```

## Theme System

QuickMorphismStyle has a dual C++/QML theme architecture. At runtime, C++ themes are the source of truth. In Qt Creator's Design mode, QML theme singletons provide fallback values.

### Architecture

```
C++ Layer                          QML Layer
-----------                        ----------
Theme (base class)                 QuickMorphismConfig.theme (singleton)
  |-- LightTheme                     |-- LightTheme.qml (Designer fallback)
  |-- DarkTheme                      |-- DarkTheme.qml  (Designer fallback)
  |                                  |
QuickMorphismUI (singleton)        QuickMorphismUI.qml (bridge)
  context property:                  syncs C++ -> Config.theme
  "QuickMorphism"                    |
  "DefaultQuickMorphismLightTheme"   v
  "DefaultQuickMorphismDarkTheme"  All components read from
                                   QuickMorphismConfig.theme.*
```

### Predefined Themes

Two built-in themes are available as C++ context properties:

| Property | Description |
|----------|-------------|
| `DefaultQuickMorphismLightTheme` | Light neumorphic theme (#E0E5EC background) |
| `DefaultQuickMorphismDarkTheme` | Dark neumorphic theme (#243441 background) |

### Runtime Theme Switching

```qml
QuickMorphismUI {
    id: ui
    theme: DefaultQuickMorphismLightTheme
}

// Switch to dark theme
ui.theme = DefaultQuickMorphismDarkTheme
```

All components update automatically via property bindings on `QuickMorphismConfig.theme`.

### Custom Theme from QML

Create a `QuickMorphismTheme` instance with your colors:

```qml
import QuickMorphism

QuickMorphismTheme {
    id: myTheme
    style: QuickMorphismStyle.LIGHT
    backgroundColor: "#f5f0eb"
    foregroundColor: "#f5f0eb"
    primaryTextColor: "#4a4a4a"
    secondaryTextColor: "#4a4a4a"
    hintTextColor: "#999999"
    topShadowColor: "#ffffff"
    bottonShadowColor: "#d1cdc7"
    primaryColor: "#f5f0eb"
    secondaryColor: "#f5f0eb"
    accentColor: "#e91e63"
    errorColor: "#f44336"
    highlightedColor: "#faf5f0"
    hoverColor: "#e91e63"
    statusBarColor: "#f5f0eb"
    navBarColor: "#f5f0eb"
}

// Apply it
QuickMorphismUI {
    theme: myTheme
}
```

### Custom Theme from C++

```cpp
#include <QuickMorphismStyle/ui/theme/theme.h>

Theme* myTheme = new Theme(
    "MyTheme",                        // name
    StyleNamespace::Style::DARK,      // style
    QColor("#1a1a2e"),                // backgroundColor
    QColor("#1a1a2e"),                // foregroundColor
    QColor("#eaeaea"),                // primaryTextColor
    QColor("#cccccc"),                // secondaryTextColor
    QColor("#888888"),                // hintTextColor
    QColor("#25254a"),                // topShadowColor
    QColor("#101020"),                // bottonShadowColor
    QColor("#1a1a2e"),                // primaryColor
    QColor("#1a1a2e"),                // secondaryColor
    QColor("#e94560"),                // accentColor
    QColor("#ff0000"),                // errorColor
    QColor("#2a2a4e"),                // highlightedColor
    QColor("#e94560"),                // hoverColor
    QColor("#1a1a2e"),                // statusBarColor
    QColor("#1a1a2e")                 // navBarColor
);

engine.rootContext()->setContextProperty("MyCustomTheme", myTheme);
```

Then in QML: `quickMorphismUI.theme = MyCustomTheme`

### Theme Properties Reference

| Property | Type | Description |
|----------|------|-------------|
| `name` | string | Theme identifier |
| `style` | int | `QuickMorphismStyle.LIGHT` (0), `.DARK` (1), or `.STYLE_FILLED` (2) |
| `backgroundColor` | color | Main background |
| `foregroundColor` | color | Component surface color |
| `primaryTextColor` | color | Primary text |
| `secondaryTextColor` | color | Secondary text |
| `hintTextColor` | color | Placeholder/hint text |
| `topShadowColor` | color | Top-left shadow (light source) |
| `bottonShadowColor` | color | Bottom-right shadow |
| `primaryColor` | color | Primary brand color |
| `secondaryColor` | color | Secondary brand color |
| `accentColor` | color | Accent/highlight color |
| `errorColor` | color | Error state color |
| `highlightedColor` | color | Highlighted/selected state |
| `hoverColor` | color | Hover state color |
| `statusBarColor` | color | Mobile status bar color |
| `navBarColor` | color | Mobile navigation bar color |
| `shadowOpacity` | double | Shadow opacity (default: 1.0) |
| `shadowGlow` | int | Shadow glow radius (default: 5) |
| `shadowSpread` | double | Shadow spread (default: 0.5) |
| `shadowOffSet` | int | Shadow offset (default: 5) |
| `titleSizeMultiplier` | double | Title font scale (default: 2.0) |
| `subTitleSizeMultiplier` | double | Subtitle font scale (default: 1.5) |

## Available Components

| Component | Description |
|-----------|-------------|
| `ApplicationWindow` | Themed application window |
| `Button` | Neumorphic push button |
| `TextField` | Text input with validation (isRequired, isPassword, errorMessage) |
| `Switch` | Neumorphic toggle switch |
| `SwitchDelegate` | Switch for use in delegates/lists |
| `CheckBox` | Neumorphic checkbox |
| `Label` | Themed text label |
| `Page` | Themed page container |
| `ToolBar` | Neumorphic toolbar |
| `ToolButton` | Toolbar button |
| `Title` | Title/subtitle component (pageTitle, subTitle) |
| `Elevation` | Neumorphic shadow effect (used internally) |
| `ScrollableContainer` | Scrollable content area |
| `SnackBar` | Material-style notification bar |
| `CalendarPicker` | Calendar date picker |
| `DatePicker` | Date selection component |
| `RoundImage` | Circular image |
| `StatusBar` | Platform status bar color control (Android/iOS) |

## Android Configuration

When targeting Android, the example project configures SDK versions via CMake target properties:

```cmake
if(ANDROID)
    set_target_properties(your_app PROPERTIES
        QT_ANDROID_SDK_BUILD_TOOLS_REVISION "35.0.0"
        QT_ANDROID_TARGET_SDK_VERSION 35
        QT_ANDROID_COMPILE_SDK_VERSION "android-35"
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
    )
endif()
```

You can also provide a custom `android/gradle.properties` to override the compileSdkVersion:

```properties
androidCompileSdkVersion=android-35
```

**Important:**
- Google Play requires `targetSdkVersion` 35 or higher as of 2026. The default Qt-generated `compileSdkVersion` (android-33) is too low for modern AndroidX dependencies. Always set it explicitly.
- Qt 6.10.2 requires **NDK r27+** (r25 causes `std::pmr` symbol errors at runtime). Configure the NDK in Qt Creator under **Preferences > Kits > Android NDK**.
- Use the **arm64-v8a** kit for modern devices and ARM64 emulators. The `armeabi-v7a` kit is only for legacy 32-bit devices.

## Qt Creator Design Mode

The build system automatically copies QML files to disk and configures `QML_IMPORT_PATH` and `QML_DESIGNER_IMPORT_PATH` so Qt Creator's Design mode can render components with the neumorphic style.

After building, components appear in the **My Components** palette in Design mode.

### If Design mode doesn't show the style

1. Clean and rebuild the project
2. Verify `QML_IMPORT_PATH` in **Projects > Build > CMake** includes the source and build/qml directories
3. Restart Qt Creator after the first build

## Project Structure

```
quickmorphismstyle/
├── CMakeLists.txt                    # Main build configuration
├── QuickMorphism/                    # QML components and themes
│   ├── qmldir                        # Module definition
│   ├── QuickMorphism.qmltypes        # C++ type info for Designer
│   ├── Config.qml                    # Theme config singleton
│   ├── Button.qml, TextField.qml... # UI components
│   ├── themes/                       # Theme definitions
│   │   ├── QuickMorphismLightTheme.qml
│   │   └── QuickMorphismDarkTheme.qml
│   ├── assets/font/                  # Bundled fonts
│   └── def/                          # Internal definitions
├── include/QuickMorphismStyle/       # C++ headers
│   ├── quickmorphism.h               # Main init class
│   ├── ui/
│   │   ├── quickmorphismui.h         # Theme singleton
│   │   ├── snackbar.h
│   │   └── theme/
│   │       ├── theme.h               # Base theme class
│   │       ├── light_theme.h         # Light theme preset
│   │       └── dark_theme.h          # Dark theme preset
│   └── statusbar/                    # Platform status bar
├── src/                              # C++ implementation
├── styles/QuickMorphism/             # QQuickStyle proxy components
├── designer/                         # Qt Designer metainfo
├── cmake/                            # CMake helper functions
└── example/quickmorphismexample/     # Example application
    └── android/                      # Android gradle overrides
```

## CMake Options

| Option | Default | Description |
|--------|---------|-------------|
| `QUICKMORPHISM_INSTALL_IN_QT_DIR` | OFF | Install style in Qt's standard QML directory |
| `QUICKMORPHISM_STYLE_INSTALL_DIR` | "" | Custom installation directory |

## Requirements

- Qt 6.2 or later (tested with Qt 6.10.2)
- CMake 3.21 or later
- C++17 compiler
- Qt modules: Core, Quick, Gui, Qml, QuickControls2
- Qt5Compat.GraphicalEffects (for shadow effects on Android/iOS)
- Android: compileSdkVersion 35+, NDK r27+, arm64-v8a recommended

## License

See [LICENSE](LICENSE) file.
