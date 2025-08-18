#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    
    // Test different styles to see what works
    qDebug() << "Available styles:" << QQuickStyle::availableStyles();
    
    // First try Basic to confirm it works
    QQuickStyle::setStyle("Basic");
    qDebug() << "Style set to:" << QQuickStyle::name();

    QQmlApplicationEngine engine;
    
    engine.loadData(R"(
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Ultra Simple Test"

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: "Style: " + (Qt.styleHints ? "Working" : "Unknown")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: "Test Button"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
)");

    return app.exec();
}