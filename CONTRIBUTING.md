# Contributing to QuickMorphismStyle

## 🛠️ Development Setup

### Prerequisites
- Qt 6.9.x or later
- CMake 3.21 or later
- Git

### Building for Development
```bash
git clone https://github.com/samuaz/quickmorphismstyle.git
cd quickmorphismstyle
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/path/to/qt/6.9.x"
make -j$(nproc)
```

## 📝 Git Workflow

### .gitignore Configuration

The project includes comprehensive `.gitignore` files:

- **Root `.gitignore`** - Covers all build artifacts, IDE files, and generated content
- **`example/.gitignore`** - Additional patterns for example projects

### What Gets Ignored

**Build Artifacts:**
- `build/`, `build-*/`, `*-build/` - All build directories
- `_deps/` - FetchContent downloads
- CMake generated files (`CMakeCache.txt`, `CMakeFiles/`, etc.)

**Qt6 Generated Files:**
- `*_autogen/` - MOC autogen directories
- `meta_types/` - Qt6 meta type files
- `qmlcache/` - QML cache directories
- `*_qmltyperegistrations.cpp/h` - QML type registrations
- `*.aotstats` - AOT compilation stats

**IDE Files:**
- `*.user*` - Qt Creator user files
- `*.qtds` - Qt Design Studio files
- `.vscode/`, `.idea/` - IDE configurations

**Platform Files:**
- `.DS_Store` - macOS Finder files
- `*.app/` - macOS bundles
- `*.exe`, `*.pdb` - Windows executables and debug files

**Temporary Files:**
- `Generated/` - Qt Creator/Design Studio generated content
- `*.tmp`, `*.temp` - Temporary files
- `CMakeLists_backup.txt` - Development backups

### What Gets Committed

**Source Files:**
- `*.qml`, `*.js` - QML and JavaScript sources
- `*.cpp`, `*.h` - C++ source and headers
- `CMakeLists.txt` - Build configuration
- `qmldir` - QML module definitions
- `*.qrc` - Qt resource files (sources)
- `*.ui` - Qt Designer UI files

**Documentation:**
- `README.md`, `*.md` - Documentation files
- `*.ts` - Translation source files (not compiled `.qm`)

## 🔧 Development Tips

### After Pulling Changes
```bash
# Clean build if you encounter issues
rm -rf build
mkdir build && cd build
cmake .. && make
```

### Working with FetchContent
```bash
# Clear FetchContent cache if needed
rm -rf build/_deps/quickmorphism-*
cmake .. && make
```

### Qt Design Studio Integration
1. Build the project first (to generate QML files)
2. Open `.qmlproject` file in Qt Design Studio
3. Components should appear automatically

## 🚀 Contributing Guidelines

1. **Follow existing code style** - Check surrounding code patterns
2. **Test your changes** - Build both main project and examples
3. **Update documentation** - If adding features, update relevant README files
4. **Don't commit build artifacts** - The .gitignore should handle this automatically

## 🐛 Troubleshooting

### Build Issues
- Ensure Qt6.9+ is properly installed and configured
- Check that CMAKE_PREFIX_PATH points to your Qt installation
- Try clean build: `rm -rf build && mkdir build`

### Git Issues
- If you accidentally committed build files: `git rm -r --cached build/`
- To check what will be ignored: `git status --ignored`

## 📋 Checklist Before Committing

- [ ] Code builds successfully
- [ ] Example project compiles and runs
- [ ] No build artifacts in commit
- [ ] Documentation updated if needed
- [ ] .gitignore catches all generated files