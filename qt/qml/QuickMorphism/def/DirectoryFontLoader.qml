import QtQuick
import Qt.labs.folderlistmodel

QtObject {
    id: loader

    property url fontDirectory: Qt.resolvedUrl("qrc:/" + relativeFontDirectory)
    property string relativeFontDirectory: "assets/font"

    function loadFont(url) {
        var fontLoader = Qt.createQmlObject(
                    'import QtQuick 2.12; FontLoader { source: "' + url + '"; }',
                    loader, "dynamicFontLoader")
    }

    property FolderListModel folderModel: FolderListModel {
        id: folderModel
        folder: loader.fontDirectory
        nameFilters: ["*.ttf", "*.otf"]
        showDirs: false

        onStatusChanged: {
            if (folderModel.status == FolderListModel.Ready) {
                var i
                for (i = 0; i < count; i++) {
                    loadFont(folderModel.get(i, "fileURL"))
                }
            }
        }
    }
}
