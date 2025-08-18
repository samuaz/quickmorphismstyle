# Cómo resolver "QML module not found (QuickMorphism)" en Qt Creator

## 🔧 Solución Paso a Paso

### 1. Verificar que el proyecto esté compilado
```bash
cd build
make -j$(nproc)  # Asegurar que FetchContent descargó QuickMorphism
```

### 2. Verificar que los archivos QML existen
```bash
ls build/_deps/quickmorphism-src/QuickMorphism/qmldir
ls build/QuickMorphism/qmldir
```

### 3. Reiniciar Qt Creator
1. **Cerrar Qt Creator completamente**
2. **Reabrir el proyecto** (`CMakeLists.txt`)
3. **Esperar a que CMake termine de configurar**

### 4. Configurar manualmente las rutas QML (si es necesario)

#### Opción A: En Qt Creator
1. **Tools → Options → Qt Quick → QML/JS Editing**
2. **En "Path to QML sources" agregar:**
   ```
   /ruta/completa/al/proyecto/build/_deps/quickmorphism-src/QuickMorphism
   /ruta/completa/al/proyecto/build/QuickMorphism  
   ```

#### Opción B: Variable de entorno
```bash
export QML2_IMPORT_PATH="/ruta/al/proyecto/build/_deps/quickmorphism-src/QuickMorphism:$QML2_IMPORT_PATH"
# Luego abrir Qt Creator desde la terminal
```

### 5. Verificar CMakeCache.txt
```bash
grep QML_IMPORT_PATH build/CMakeCache.txt
```
Debería mostrar las rutas correctas.

### 6. Limpiar y recompilar (último recurso)
```bash
rm -rf build
mkdir build && cd build
cmake .. -DCMAKE_PREFIX_PATH="/ruta/a/qt/6.9.x"
make -j$(nproc)
```

## 🎯 Lo que hace CMake automáticamente

El `CMakeLists.txt` ya configura:
- ✅ `QML_IMPORT_PATH` en CMakeCache.txt
- ✅ Copia archivos QML a `build/QuickMorphism/`
- ✅ Crea `.qmllint.ini` para el analizador QML
- ✅ Descarga QuickMorphism via FetchContent

## 🔍 Debug Information

Para verificar que todo está correcto:

```bash
# Ver rutas configuradas
cat build/CMakeCache.txt | grep QML_IMPORT_PATH

# Ver archivos descargados
ls build/_deps/quickmorphism-src/QuickMorphism/

# Ver archivos copiados
ls build/QuickMorphism/

# Ver configuración QML lint
cat .qmllint.ini
```

## ⚠️ Problemas Comunes

### FetchContent no terminó
- **Síntoma**: No existe `build/_deps/quickmorphism-src/`
- **Solución**: Esperar a que termine la descarga o compilar desde terminal

### Qt Creator usa cache viejo
- **Síntoma**: Error persiste después de compilar
- **Solución**: Reiniciar Qt Creator completamente

### Rutas no actualizadas
- **Síntoma**: CMakeCache.txt tiene rutas incorrectas
- **Solución**: `rm -rf build && mkdir build` y recompilar

## 🚀 Para desarrolladores nuevos

Si eres un desarrollador nuevo clonando este proyecto:

1. **Clona el repositorio**
2. **Compila PRIMERO desde terminal** (para descargar dependencias)
3. **Luego abre en Qt Creator**

Esto evita problemas de rutas QML en la primera apertura.