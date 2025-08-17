# Notas de Construcción - QuickMorphism Qt6.9

## 🐛 Problema Solucionado: Error MOC

### Error Original
```
Error opening /path/to/moc_quickmorphismui.cpp.json for reading
make[2]: *** [meta_types/qt6quickmorphism_debug_metatypes.json.gen] Error 1
```

### ⚡ Causa del Problema

El problema estaba en la configuración avanzada de `qt_add_qml_module()` que intentaba generar automáticamente:
- Metatipos QML automáticos
- Plugin sources automáticos
- Integración QML_ELEMENT avanzada

En Qt6.9, esta funcionalidad puede ser problemática con ciertas configuraciones de headers.

### ✅ Solución Implementada

1. **Headers Simplificados**
   - Removidas las macros `QML_ELEMENT` y `QML_SINGLETON` temporalmente
   - Los tipos se registran manualmente en `quickmorphism.cpp`

2. **CMakeLists.txt Simplificado**
   - Usar `add_library()` estándar en lugar de `qt_add_qml_module()` avanzado
   - Usar `qt_add_resources()` para archivos QML
   - Evitar generación automática de plugins

3. **Configuración de Recursos Manual**
   ```cmake
   qt_add_resources(${PROJECT_NAME} "quickmorphism_qml"
       PREFIX "/"
       FILES
           QuickMorphism/ApplicationWindow.qml
           QuickMorphism/Button.qml
           # ... otros archivos QML
   )
   ```

## 🚀 Cómo Construir

### Para Qt Creator
1. Abrir el proyecto con el `CMakeLists.txt` actual
2. Configurar kit Qt 6.9.1 for macOS
3. Build → Clean All
4. Build → Rebuild All

### Para línea de comandos
```bash
cd /Users/samuaz/Projects/toc/quickmorphismstyle
rm -rf build
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/Users/samuaz/Qt/6.9.1/macos" -DCMAKE_BUILD_TYPE=Debug
make -j$(nproc)
```

## 📁 Archivos de Configuración

### CMakeLists.txt (Principal - Funciona)
- Configuración simplificada y estable
- Usa `add_library()` + `qt_add_resources()`
- Compatible con Qt Creator

### CMakeLists_simple_working.txt (Respaldo)
- Copia de la configuración que funciona
- Para referencia futura

### CMakeLists_fetchcontent.txt (Alternativa)
- Para proyectos que usan FetchContent
- Descarga automática desde Git

## 🔮 Mejoras Futuras

Cuando Qt6.9 estabilice las siguientes características, se podrán reactivar:

1. **Restaurar QML_ELEMENT**
   ```cpp
   class QuickMorphismUI: public QObject
   {
       Q_OBJECT
       QML_ELEMENT      // Reactivar cuando se estabilice
       QML_SINGLETON    // Reactivar cuando se estabilice
   ```

2. **qt_add_qml_module Avanzado**
   ```cmake
   qt_add_qml_module(${PROJECT_NAME}
       URI ${PROJECT_NAME}
       VERSION ${PROJECT_VERSION}
       # ... configuración avanzada
   )
   ```

3. **Generación Automática de Plugins**
   - Plugin automático para Qt Designer
   - Metatipos automáticos

## ✅ Problemas Adicionales Solucionados

### Warning de Deprecación Qt6.9
**Error**: `'operator""_qs' is deprecated: Use _s from Qt::StringLiterals namespace instead.`

**Solución**:
```cpp
#include <QuickMorphismStyle/quickmorphism.h>
using namespace Qt::StringLiterals;  // Añadido

// Cambiado de:
const QUrl url(u"qrc:/quickmorphismexample/demo.qml"_qs);
// A:
const QUrl url(u"qrc:/quickmorphismexample/demo.qml"_s);
```

### Error de Plugin No Encontrado
**Error**: `module "QuickMorphism" plugin "QuickMorphismPlugin" not found`

**Solución**:
1. Comentar línea de plugin en `qmldir`:
   ```
   # plugin QuickMorphismPlugin  # Disabled - using static library instead
   ```

2. Remover import problemático en `qmldir`:
   ```
   # Removido: import QtQuick.Controls.Basic auto
   ```

3. Arreglar referencias en temas:
   ```qml
   // Cambiado de:
   property string style: QuickMorphismStyle.DARK
   // A:
   property int style: 1  // DARK style
   ```

## ⚠️ Consideraciones

### Para Desarrolladores
- El build actual es **estable y funcional**
- Los componentes QML están **completamente disponibles**
- La funcionalidad **no se ve afectada**
- **Aplicación de ejemplo funciona correctamente**

### Para Usuarios de la Librería
- Usar los métodos de integración documentados en `example/README.md`
- Preferir el método `add_subdirectory()` para desarrollo local
- Usar `FetchContent` para proyectos de producción

## 🛠 Troubleshooting

### Si el error MOC vuelve a aparecer:
1. `rm -rf build`
2. Verificar que no hay `QML_ELEMENT` en headers
3. Reconfigurar desde cero

### Para integración en otros proyectos:
1. Usar `CMakeLists_simple.txt` del ejemplo
2. Incluir archivos fuente directamente si es necesario
3. Verificar paths de `QML_IMPORT_PATH`