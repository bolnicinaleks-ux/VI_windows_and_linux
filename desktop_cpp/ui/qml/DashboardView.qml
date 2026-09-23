import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

ColumnLayout {
    spacing: 16

    Text {
        text: "Командный центр"
        color: Theme.textPrimary
        font: Theme.fontTitle
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 12

        Card {
            Layout.fillWidth: true
            implicitHeight: 90

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 12

                Text { text: "🌐"; font.pixelSize: 24 }

                ColumnLayout {
                    Text { text: "Статус сервера"; color: Theme.textSecondary; font: Theme.fontBody }
                    Text { text: controller.isOnline ? "Онлайн (v" + controller.serverVersion + ")" : "Офлайн"; color: controller.isOnline ? Theme.statusOnline : Theme.statusOffline; font.bold: true; font.pixelSize: 16 }
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 90

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 12

                Text { text: "⚡"; font.pixelSize: 24 }

                ColumnLayout {
                    Text { text: "Аптайм сервера"; color: Theme.textSecondary; font: Theme.fontBody }
                    Text { text: Math.floor(controller.serverUptime / 3600) + " ч " + Math.floor((controller.serverUptime % 3600) / 60) + " мин"; color: Theme.textPrimary; font.bold: true; font.pixelSize: 16 }
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 90

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 12

                Text { text: "📋"; font.pixelSize: 24 }

                ColumnLayout {
                    Text { text: "Задач всего"; color: Theme.textSecondary; font: Theme.fontBody }
                    Text { text: controller.tasks.length.toString(); color: Theme.accent; font.bold: true; font.pixelSize: 16 }
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
