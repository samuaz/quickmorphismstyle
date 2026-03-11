#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // Set QuickMorphism as the Qt Quick Controls style
    QQuickStyle::setStyle("QuickMorphism");
    qDebug() << "Set style to:" << QQuickStyle::name();
    
    QQmlApplicationEngine engine;
    
    // Add our build directory to QML import path
    engine.addImportPath("/Users/samuaz/Projects/toc/quickmorphismstyle/build/qml");
    
    // Simple QML content inline
    engine.loadData(R"(
        import QtQuick
        import QtQuick.Controls

        ApplicationWindow {
            visible: true
            width: 400
            height: 300
            title: "QuickMorphism Style Test"
            
            Column {
                anchors.centerIn: parent
                spacing: 20
                
                Button {
                    text: "Neumorphic Button"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                TextField {
                    placeholderText: "Neumorphic TextField"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Switch {
                    text: "Neumorphic Switch" 
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    )");

    return app.exec();
}