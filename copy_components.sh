#!/bin/bash

# Script para copiar todos los componentes QuickMorphism al style plugin

SOURCE_DIR="/Users/samuaz/Projects/toc/quickmorphismstyle/QuickMorphism"
DEST_DIR="/Users/samuaz/Projects/toc/quickmorphismstyle/styles/QuickMorphism"

# Lista de componentes importantes a copiar
COMPONENTS=(
    "DatePicker.qml"
    "FontAwesomeRegular.qml" 
    "Icons.qml"
    "Fonts.qml"
    "Image.qml"
    "Label.qml"
    "Required.qml"
    "Ripple.qml"
    "RoundImage.qml"
    "ScrollableContainer.qml"
    "SnackBar.qml"
    "SwitchDelegate.qml"
    "ToolBar.qml"
    "ToolButton.qml"
    "QuickMorphismUI.qml"
    "Config.qml"
)

echo "Copiando componentes QuickMorphism al style plugin..."

for component in "${COMPONENTS[@]}"; do
    if [ -f "$SOURCE_DIR/$component" ]; then
        cp "$SOURCE_DIR/$component" "$DEST_DIR/"
        echo "✓ Copiado: $component"
    else
        echo "✗ No encontrado: $component"
    fi
done

echo "Copia completada!"