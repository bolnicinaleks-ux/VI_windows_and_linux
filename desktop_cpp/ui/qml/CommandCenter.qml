import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

ColumnLayout {
    spacing: 16

    Text {
        text: "⚡ Центр быстрых команд"
        color: Theme.textPrimary
        font: Theme.fontTitle
    }

    Text {
        text: "Оперативное исполнение сценариев и быстрая отправка команд в Vi"
        color: Theme.textSecondary
        font: Theme.fontBody
    }

    GridLayout {
        columns: 2
        Layout.fillWidth: true
        columnSpacing: 14
        rowSpacing: 14

        Card {
            Layout.fillWidth: true
            implicitHeight: 110

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 14

                Rectangle {
                    width: 44; height: 44; radius: 12
                    color: Theme.accentGlow
                    border.color: Theme.accent
                    Text { anchors.centerIn: parent; text: "📊"; font.pixelSize: 22 }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Text { text: "Полный сброс метрик и состояния"; color: Theme.textPrimary; font: Theme.fontHeader }
                    Text { text: "Синхронизировать статус всех служб с бэкендом"; color: Theme.textMuted; font: Theme.fontCaption }

                    Button {
                        text: "Синхронизировать сейчас"
                        onClicked: controller.refreshData()
                        background: Rectangle { color: Theme.accent; radius: Theme.radiusSmall }
                        contentItem: Text { text: parent.text; color: "#ffffff"; font: Theme.fontCaption; horizontalAlignment: Text.AlignHCenter }
                    }
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 110

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 14

                Rectangle {
                    width: 44; height: 44; radius: 12
                    color: Theme.accentGlow
                    border.color: Theme.accent
                    Text { anchors.centerIn: parent; text: "💬"; font.pixelSize: 22 }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Text { text: "Сбросить историю диалога"; color: Theme.textPrimary; font: Theme.fontHeader }
                    Text { text: "Очистить текущую сессию общения с ассистентом"; color: Theme.textMuted; font: Theme.fontCaption }

                    Button {
                        text: "Очистить чат"
                        onClicked: controller.clearChatHistory()
                        background: Rectangle { color: Theme.bgCardHover; radius: Theme.radiusSmall; border.color: Theme.borderLight }
                        contentItem: Text { text: parent.text; color: Theme.textSecondary; font: Theme.fontCaption; horizontalAlignment: Text.AlignHCenter }
                    }
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 110

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 14

                Rectangle {
                    width: 44; height: 44; radius: 12
                    color: Theme.accentGlow
                    border.color: Theme.accent
                    Text { anchors.centerIn: parent; text: "📝"; font.pixelSize: 22 }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Text { text: "Быстрый запрос: План на день"; color: Theme.textPrimary; font: Theme.fontHeader }
                    Text { text: "Попросить Vi составить сводку активных задач"; color: Theme.textMuted; font: Theme.fontCaption }

                    Button {
                        text: "Отправить запрос"
                        onClicked: controller.sendMessage("Составь расписание и план выполнения на сегодня", "Auto")
                        background: Rectangle { color: Theme.accent; radius: Theme.radiusSmall }
                        contentItem: Text { text: parent.text; color: "#ffffff"; font: Theme.fontCaption; horizontalAlignment: Text.AlignHCenter }
                    }
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 110

            RowLayout {
                anchors.fill: parent
                anchors.margins: 14
                spacing: 14

                Rectangle {
                    width: 44; height: 44; radius: 12
                    color: Theme.accentGlow
                    border.color: Theme.accent
                    Text { anchors.centerIn: parent; text: "🔍"; font.pixelSize: 22 }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Text { text: "Быстрый запрос: Диагностика"; color: Theme.textPrimary; font: Theme.fontHeader }
                    Text { text: "Проанализировать нагрузку системы"; color: Theme.textMuted; font: Theme.fontCaption }

                    Button {
                        text: "Проверить нагрузку"
                        onClicked: controller.sendMessage("Проведи диагностику производительности ПК и метрик", "Auto")
                        background: Rectangle { color: Theme.accent; radius: Theme.radiusSmall }
                        contentItem: Text { text: parent.text; color: "#ffffff"; font: Theme.fontCaption; horizontalAlignment: Text.AlignHCenter }
                    }
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
