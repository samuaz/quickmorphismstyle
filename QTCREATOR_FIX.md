# Qt Creator Fix para appquickmorphism_quickstyle

## 🐛 Problema Identificado

El ejecutable `appquickmorphism_quickstyle` falla en Qt Creator con el error:
```
module "QuickMorphism" is not installed
```

## 🔍 Causa del Problema

El archivo `main_quickstyle.cpp` tenía una ruta hardcodeada que no funciona cuando se ejecuta desde Qt Creator:

```cpp
// PROBLEMA: Ruta hardcodeada que solo funciona desde terminal
engine.addImportPath("/Users/samuaz/Projects/toc/quickmorphismstyle/build/qml");
```

## ✅ Solución Implementada

He actualizado `main_quickstyle.cpp` para usar detección automática de rutas:

```cpp
QString findQuickMorphismStylePath() {
    QStringList possiblePaths = {
        // 1. Build directory (development) - relative to current executable
        QGuiApplication::applicationDirPath() + "/../../build/qml",
        QGuiApplication::applicationDirPath() + "/../../../build/qml", 
        QGuiApplication::applicationDirPath() + "/../../../../build/qml",
        
        // 2. Environment variable
        qEnvironmentVariable("QUICKMORPHISM_STYLE_PATH"),
        
        // 3. Common locations
        QDir::currentPath() + "/qml",
        QDir::currentPath() + "/../qml",
        QDir::currentPath() + "/../../qml",
        
        // 4. Application directory
        QGuiApplication::applicationDirPath() + "/qml",
        
        // 5. User data directory  
        QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/qml",
        
        // 6. System-wide installation
        "/usr/local/share/qml",
        "/opt/quickmorphism/qml"
    };
    
    for (const QString& path : possiblePaths) {
        if (!path.isEmpty() && QDir(path + "/QuickMorphism").exists()) {
            qDebug() << "Found QuickMorphism style at:" << path;
            return path;
        }
    }
    
    qWarning() << "QuickMorphism style not found in any standard location.";
    qWarning() << "Please set QUICKMORPHISM_STYLE_PATH environment variable";
    return QString();
}
```

## 🛠 Pasos para Aplicar la Solución

### 1. Recompilar el Proyecto Principal

Primero, asegúrate de que el proyecto principal esté compilado:

```bash
cd /Users/samuaz/Projects/toc/quickmorphismstyle
rm -rf build && mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/Users/samuaz/Qt/6.9.1/macos" -DCMAKE_BUILD_TYPE=Debug
make -j$(nproc)
```

### 2. Recompilar el Ejemplo

```bash
cd /Users/samuaz/Projects/toc/quickmorphismstyle/example/quickmorphismexample
rm -rf build && mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/Users/samuaz/Qt/6.9.1/macos"
make -j$(nproc)
```

### 3. Alternativa: Variable de Entorno

Si los pasos anteriores no funcionan, puedes configurar la variable de entorno en Qt Creator:

1. Ve a **Projects** > **Run Settings**
2. En **Environment**, agrega:
   - **Variable**: `QUICKMORPHISM_STYLE_PATH`
   - **Value**: `/Users/samuaz/Projects/toc/quickmorphismstyle/build/qml`

### 4. Verificar desde Terminal

Para confirmar que funciona:

```bash
cd /Users/samuaz/Projects/toc/quickmorphismstyle/example/quickmorphismexample/build
./appquickmorphism_quickstyle.app/Contents/MacOS/appquickmorphism_quickstyle
```

Deberías ver:
```
Found QuickMorphism style at: [ruta detectada]
QuickMorphism style configured successfully from: [ruta]
```

## 🎯 Diferencias entre los Ejecutables

### `appquickmorphismexample` (Funciona)
- Usa `QuickMorphism::init(engine)` 
- Incluye la biblioteca completa
- No depende de `QQuickStyle::setStyle()`

### `appquickmorphism_quickstyle` (Ahora Arreglado)
- Usa `QQuickStyle::setStyle("QuickMorphism")`
- Requiere que el estilo esté en el path de QML
- Ahora usa detección automática de rutas

## 🔮 Beneficios de la Solución

1. **Portable**: Funciona desde Qt Creator, terminal, y cualquier ubicación
2. **Flexible**: Múltiples rutas de búsqueda automática
3. **Debugging**: Logs claros sobre dónde encuentra el estilo
4. **Fallback**: Variable de entorno como respaldo
5. **Compatible**: Mantiene toda la funcionalidad existente

## 🚨 Solución de Problemas

Si aún tienes problemas:

1. **Verifica que el módulo exista**:
   ```bash
   ls /Users/samuaz/Projects/toc/quickmorphismstyle/build/qml/QuickMorphism/
   ```

2. **Ejecuta con debug**:
   ```bash
   QT_LOGGING_RULES="qt.qml.import.debug=true" ./appquickmorphism_quickstyle.app/Contents/MacOS/appquickmorphism_quickstyle
   ```

3. **Fuerza la variable de entorno**:
   ```bash
   QUICKMORPHISM_STYLE_PATH="/Users/samuaz/Projects/toc/quickmorphismstyle/build/qml" ./appquickmorphism_quickstyle.app/Contents/MacOS/appquickmorphism_quickstyle
   ```

Con estos cambios, ambos ejecutables deberían funcionar perfectamente tanto desde Qt Creator como desde terminal! 🎉