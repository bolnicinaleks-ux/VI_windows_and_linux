import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

ColumnLayout {
    spacing: 16

    RowLayout {
        Layout.fillWidth: true

        ColumnLayout {
            spacing: 2
            Text {
                text: "Панель управления Vi"
                color: Theme.textPrimary
                font: Theme.fontTitle
            }
            Text {
                text: "Центральный мониторинг и быстрый доступ к ИИ ассистенту"
                color: Theme.textSecondary
                font: Theme.fontBody
            }
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
                color: Theme.textPrimary
                font: Theme.fontCaption
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    // Top Stat Cards Grid
    RowLayout {
        Layout.fillWidth: true
        spacing: 14

        Card {
            Layout.fillWidth: true
            implicitHeight: 96

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 14

                Rectangle {
                    width: 44; height: 44; radius: 12
                    color: Theme.accentGlow
                    border.color: Theme.accent
                    Text { anchors.centerIn: parent; text: "🌐"; font.pixelSize: 20 }
                }

                ColumnLayout {
                    spacing: 2
                    Text { text: "Статус сервера"; color: Theme.textSecondary; font: Theme.fontCaption }
                    Text {
                        text: controller.isOnline ? "Онлайн (v" + controller.serverVersion + ")" : "Офлайн"
                        color: controller.isOnline ? Theme.statusOnline : Theme.statusOffline
                        font: Theme.fontHeader
                    }
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 96

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 14

                Rectangle {
                    width: 44; height: 44; radius: 12
                    color: Theme.accentGlow
                    border.color: Theme.accent
                    Text { anchors.centerIn: parent; text: "⚡"; font.pixelSize: 20 }
                }

                ColumnLayout {
                    spacing: 2
                    Text { text: "Аптайм сервера"; color: Theme.textSecondary; font: Theme.fontCaption }
                    Text {
                        text: Math.floor(controller.serverUptime / 3600) + " ч " + Math.floor((controller.serverUptime % 3600) / 60) + " мин"
                        color: Theme.textPrimary
                        font: Theme.fontHeader
                    }
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 96

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 14

                Rectangle {
                    width: 44; height: 44; radius: 12
                    color: Theme.accentGlow
                    border.color: Theme.accent
                    Text { anchors.centerIn: parent; text: "📋"; font.pixelSize: 20 }
                }

                ColumnLayout {
                    spacing: 2
                    Text { text: "Задач в системе"; color: Theme.textSecondary; font: Theme.fontCaption }
                    Text {
                        text: controller.tasks.length.toString()
                        color: Theme.accent
                        font: Theme.fontHeader
                    }
                }
            }
        }
    }

    // Mid section: System Metrics Overview & Quick Launch
    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 14

        // Left Card: Quick System Metrics
        Card {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 3

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                Text {
                    text: "📊 Нагрузка системы"
                    color: Theme.textPrimary
                    font: Theme.fontHeader
                }

                // CPU Progress
                ColumnLayout {
                    Layout.fillWidth: true; spacing: 4
                    RowLayout {
                        Text { text: "Процессор (CPU)"; color: Theme.textSecondary; font: Theme.fontCaption }
                        Item { Layout.fillWidth: true }
                        Text { text: controller.cpuUsage.toFixed(1) + "%"; color: Theme.textPrimary; font: Theme.fontCaption }
                    }
                    ProgressBar {
                        Layout.fillWidth: true
                        value: controller.cpuUsage / 100.0
                        background: Rectangle { color: Theme.bgInput; radius: 4; height: 8 }
                        contentItem: Item {
                            Rectangle {
                                width: parent.width * parent.parent.value
                                height: 8; radius: 4
                                color: Theme.accent
                            }
                        }
                    }
                }

                // RAM Progress
                ColumnLayout {
                    Layout.fillWidth: true; spacing: 4
                    RowLayout {
                        Text { text: "Оперативная память (RAM)"; color: Theme.textSecondary; font: Theme.fontCaption }
                        Item { Layout.fillWidth: true }
                        Text { text: controller.ramUsage.toFixed(1) + "%"; color: Theme.textPrimary; font: Theme.fontCaption }
                    }
                    ProgressBar {
                        Layout.fillWidth: true
                        value: controller.ramUsage / 100.0
                        background: Rectangle { color: Theme.bgInput; radius: 4; height: 8 }
                        contentItem: Item {
                            Rectangle {
                                width: parent.width * parent.parent.value
                                height: 8; radius: 4
                                color: Theme.statusOnline
                            }
                        }
                    }
                }

                // Disk Progress
                ColumnLayout {
                    Layout.fillWidth: true; spacing: 4
                    RowLayout {
                        Text { text: "Диск (Disk)"; color: Theme.textSecondary; font: Theme.fontCaption }
                        Item { Layout.fillWidth: true }
                        Text { text: controller.diskUsage.toFixed(1) + "%"; color: Theme.textPrimary; font: Theme.fontCaption }
                    }
                    ProgressBar {
                        Layout.fillWidth: true
                        value: controller.diskUsage / 100.0
                        background: Rectangle { color: Theme.bgInput; radius: 4; height: 8 }
                        contentItem: Item {
                            Rectangle {
                                width: parent.width * parent.parent.value
                                height: 8; radius: 4
                                color: Theme.statusWarning
                            }
                        }
                    }
                }

                Item { Layout.fillHeight: true }
            }
        }

        // Right Card: Recent Vi Chat Prompt Shortcut
        Card {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 2

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 16
                spacing: 12

                Text {
                    text: "💬 Статус ИИ ассистента"
                    color: Theme.textPrimary
                    font: Theme.fontHeader
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 80
                    radius: Theme.radiusMedium
                    color: Theme.bgInput
                    border.color: Theme.borderLight

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 12

                        Text { text: "🧠"; font.pixelSize: 28 }

                        ColumnLayout {
                            spacing: 2
                            Text {
                                text: controller.isThinking ? "Vi генерирует ответ..." : "Готов к работе"
                                color: controller.isThinking ? Theme.accent : Theme.statusOnline
                                font: Theme.fontHeader
                            }
                            Text {
                                text: controller.chatHistory.length + " сообщений в истории диалога"
                                color: Theme.textSecondary
                                font: Theme.fontCaption
                            }
                        }
                    }
                }

                Text {
                    text: "Активных записей в памяти: " + controller.memoryItems.length
                    color: Theme.textMuted
                    font: Theme.fontCaption
                }

                Item { Layout.fillHeight: true }
            }
        }
    }
}
