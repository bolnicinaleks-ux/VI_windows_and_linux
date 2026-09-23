import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

Rectangle {
    id: sidebar
    width: 210
    color: Theme.bgSurface

    property int currentIndex: 0

    Rectangle {
        anchors.right: parent.right
        width: 1
        height: parent.height
        color: Theme.borderLight
    }

    ListModel {
        id: navModel
        ListElement { name: "Дашборд"; icon: "📊"; viewIndex: 0 }
        ListElement { name: "Чат Vi"; icon: "💬"; viewIndex: 1 }
        ListElement { name: "Задачи"; icon: "📋"; viewIndex: 2 }
        ListElement { name: "Метрики"; icon: "📈"; viewIndex: 3 }
        ListElement { name: "Память"; icon: "🧠"; viewIndex: 4 }
        ListElement { name: "Команды"; icon: "⚡"; viewIndex: 5 }
        ListElement { name: "Настройки"; icon: "⚙️"; viewIndex: 6 }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 12
        anchors.bottomMargin: 12
        spacing: 4

        ListView {
            id: navList
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: navModel
            interactive: false
            spacing: 4

            delegate: Item {
                width: navList.width
                height: 42

                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    radius: Theme.radiusMedium
                    color: sidebar.currentIndex === index ? Theme.accentGlow : (itemMouse.containsMouse ? Theme.bgCardHover : "transparent")
                    border.color: sidebar.currentIndex === index ? Theme.borderFocus : "transparent"
                    border.width: 1

                    Behavior on color { ColorAnimation { duration: 150 } }

                    // Active indicator bar
                    Rectangle {
                        width: 4
                        height: 20
                        radius: 2
                        color: Theme.accent
                        anchors.left: parent.left
                        anchors.leftMargin: 6
                        anchors.verticalCenter: parent.verticalCenter
                        visible: sidebar.currentIndex === index
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 20
                        anchors.rightMargin: 12
                        spacing: 12

                        Text {
                            text: icon
                            font.pixelSize: 16
                        }

                        Text {
                            text: name
                            color: sidebar.currentIndex === index ? Theme.textPrimary : Theme.textSecondary
                            font: sidebar.currentIndex === index ? Theme.fontHeader : Theme.fontBody
                            Layout.fillWidth: true
                            Behavior on color { ColorAnimation { duration: 150 } }
                        }
                    }

                    MouseArea {
                        id: itemMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: sidebar.currentIndex = index
                    }
                }
            }
        }

        // Bottom version & system info badge
        Rectangle {
            Layout.fillWidth: true
            Layout.leftMargin: 12
            Layout.rightMargin: 12
            height: 48
            radius: Theme.radiusMedium
            color: Theme.bgCard
            border.color: Theme.borderLight

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 8

                Text { text: "🤖"; font.pixelSize: 18 }

                ColumnLayout {
                    spacing: 0
                    Text { text: "Vi Engine v" + controller.serverVersion; color: Theme.textPrimary; font: Theme.fontCaption }
                    Text { text: controller.isOnline ? "Подключено" : "Автономно"; color: controller.isOnline ? Theme.statusOnline : Theme.statusOffline; font: Theme.fontCaption }
                }
            }
        }
    }
}
