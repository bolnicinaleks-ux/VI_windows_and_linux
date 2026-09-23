import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

ColumnLayout {
    spacing: 16

    RowLayout {
        Layout.fillWidth: true
        spacing: 12

        Text {
            text: "📈 Мониторинг производительности"
            color: Theme.textPrimary
            font: Theme.fontTitle
        }

        Item { Layout.fillWidth: true }

        Button {
            text: "🔄 Обновить"
            onClicked: controller.refreshData()
            background: Rectangle {
                color: Theme.bgCard
                radius: Theme.radiusSmall
                border.color: parent.hovered ? Theme.borderFocus : Theme.borderLight
            }
            contentItem: Text {
                text: parent.text
                color: Theme.textSecondary
                font: Theme.fontCaption
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    GridLayout {
        columns: 3
        Layout.fillWidth: true
        columnSpacing: 14
        rowSpacing: 14

        // CPU Metric
        Card {
            Layout.fillWidth: true
            implicitHeight: 140

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 8

                RowLayout {
                    Text { text: "💻 Процессор (CPU)"; color: Theme.textSecondary; font: Theme.fontHeader }
                    Item { Layout.fillWidth: true }
                    Text { text: (controller.cpuUsage || 0).toFixed(1) + "%"; color: Theme.accent; font: Theme.fontHeader }
                }

                ProgressBar {
                    Layout.fillWidth: true
                    value: (controller.cpuUsage || 0) / 100.0
                    background: Rectangle { color: Theme.bgInput; radius: 6; height: 10 }
                    contentItem: Item {
                        Rectangle {
                            width: parent.width * parent.parent.value
                            height: 10; radius: 6
                            color: Theme.accent
                        }
                    }
                }

                Text { text: "Загрузка ядер процессора хоста"; color: Theme.textMuted; font: Theme.fontCaption }
            }
        }

        // RAM Metric
        Card {
            Layout.fillWidth: true
            implicitHeight: 140

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 8

                RowLayout {
                    Text { text: "🧠 Оперативная память (RAM)"; color: Theme.textSecondary; font: Theme.fontHeader }
                    Item { Layout.fillWidth: true }
                    Text { text: (controller.ramUsage || 0).toFixed(1) + "%"; color: Theme.statusOnline; font: Theme.fontHeader }
                }

                ProgressBar {
                    Layout.fillWidth: true
                    value: (controller.ramUsage || 0) / 100.0
                    background: Rectangle { color: Theme.bgInput; radius: 6; height: 10 }
                    contentItem: Item {
                        Rectangle {
                            width: parent.width * parent.parent.value
                            height: 10; radius: 6
                            color: Theme.statusOnline
                        }
                    }
                }

                Text { text: "Занятость динамической памяти"; color: Theme.textMuted; font: Theme.fontCaption }
            }
        }

        // Disk Metric
        Card {
            Layout.fillWidth: true
            implicitHeight: 140

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 8

                RowLayout {
                    Text { text: "💽 Дисковое пространство (Disk)"; color: Theme.textSecondary; font: Theme.fontHeader }
                    Item { Layout.fillWidth: true }
                    Text { text: (controller.diskUsage || 0).toFixed(1) + "%"; color: Theme.statusWarning; font: Theme.fontHeader }
                }

                ProgressBar {
                    Layout.fillWidth: true
                    value: (controller.diskUsage || 0) / 100.0
                    background: Rectangle { color: Theme.bgInput; radius: 6; height: 10 }
                    contentItem: Item {
                        Rectangle {
                            width: parent.width * parent.parent.value
                            height: 10; radius: 6
                            color: Theme.statusWarning
                        }
                    }
                }

                Text { text: "Основной накопитель системы"; color: Theme.textMuted; font: Theme.fontCaption }
            }
        }
    }

    // Server Uptime Card
    Card {
        Layout.fillWidth: true
        implicitHeight: 90

        RowLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 16

            Rectangle {
                width: 48; height: 48; radius: 12
                color: Theme.accentGlow
                border.color: Theme.accent
                Text { anchors.centerIn: parent; text: "⏱️"; font.pixelSize: 22 }
            }

            ColumnLayout {
                spacing: 2
                Text { text: "Время непрерывной работы (Uptime)"; color: Theme.textSecondary; font: Theme.fontBody }
                Text {
                    text: Math.floor(controller.serverUptime / 3600) + " часов " + Math.floor((controller.serverUptime % 3600) / 60) + " минут " + (controller.serverUptime % 60) + " секунд"
                    color: Theme.textPrimary
                    font: Theme.fontHeader
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
