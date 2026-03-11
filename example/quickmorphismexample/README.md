# QuickMorphism Example Application

Demonstrates how to integrate QuickMorphismStyle into a Qt6 application.

## Build

### Desktop (macOS/Linux/Windows)

```bash
cd example/quickmorphismexample
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/path/to/Qt/6.x.x/platform"
cmake --build . -j$(nproc)
```

### Android

Open the example project in Qt Creator with an Android kit configured, then build and deploy. The CMakeLists.txt automatically sets:

- `compileSdkVersion` to android-35
- `targetSdkVersion` to 35
- `buildToolsRevision` to 35.0.0

A custom `android/gradle.properties` is included to override Qt's default compileSdkVersion (android-33), which is too low for modern AndroidX dependencies.

**Requirements:**
- **NDK r27+** — Qt 6.10.2 requires NDK r27 or newer. NDK r25 causes `std::pmr` symbol errors at runtime. Configure in Qt Creator: **Preferences > Kits > Android NDK**.
- **arm64-v8a kit** — Use `Qt 6.10.2 for Android arm64-v8a` for modern devices and ARM64 emulators. The `armeabi-v7a` kit will fail with `INSTALL_FAILED_NO_MATCHING_ABIS` on x86_64/ARM64 emulators.
- **Android 14+ emulator** — Recommended API level 34 or higher for the AVD.

**Note:** If you get Gradle errors about compileSdkVersion, clean the build directory completely and reconfigure.

## Applications

This example builds two apps demonstrating different integration approaches:

### appquickmorphismexample

Direct usage of QuickMorphism components with full theme switching:

- `Demo.qml` / `MainForm.ui.qml` - Full UI with theme switch, custom theme, snackbar
- Uses `QuickMorphismUI` component for theme management
- Shows how to create a custom theme via `QuickMorphismTheme { }`

### appquickmorphism_quickstyle

Minimal example using direct component imports:

- `Demo_quickstyle.qml` - Simple layout with Button, TextField, Switch, CheckBox
- Shows the simplest way to use QuickMorphism components

## How It Works

The example uses `add_subdirectory()` to include the QuickMorphism library from the parent directory. This means:

- Changes to the library source are reflected immediately on rebuild
- No network download needed (unlike FetchContent)
- QML import paths are configured automatically for Qt Creator
- Android SDK versions are configured per-target via CMake properties

## Using FetchContent Instead

For external projects that aren't part of this repository:

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

## Qt Creator Design Mode

After building, open `MainForm.ui.qml` in Qt Creator's Design mode to see the neumorphic components rendered in the visual editor.
