import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

Window {
    id: window
    width: 1000
    height: 650
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    title: "Vi Desktop"
    color: Theme.bgBase
    flags: Qt.Window | Qt.FramelessWindowHint

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        TitleBar {
            id: titleBar
            Layout.fillWidth: true
            onMinimizeRequested: window.showMinimized()
            onMaximizeRequested: window.visibility === Window.Maximized ? window.showNormal() : window.showMaximized()
            onCloseRequested: window.close()
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            Sidebar {
                id: sidebar
                Layout.fillHeight: true
            }

            StackLayout {
                id: contentStack
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.margins: 16
                currentIndex: sidebar.currentIndex

                DashboardView {}
                ChatView {}
                TasksView {}
                MetricsView {}
                MemoryView {}
                CommandCenter {}
                SettingsView {}
            }
        }
    }
}
