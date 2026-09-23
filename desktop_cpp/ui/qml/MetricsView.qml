import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

ColumnLayout {
    spacing: 16

    Text {
        text: "Системные метрики"
        color: Theme.textPrimary
        font: Theme.fontTitle
    }

    GridLayout {
        columns: 3
        Layout.fillWidth: true
        columnSpacing: 12
        rowSpacing: 12

        Card {
            Layout.fillWidth: true
            implicitHeight: 120

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 8

                Text {
                    text: "Загрузка CPU"
                    color: Theme.textSecondary
                    font: Theme.fontBody
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: controller.cpuUsage.toFixed(1) + "%"
                    color: Theme.accent
                    font.pixelSize: 28
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                ProgressBar {
                    value: controller.cpuUsage / 100.0
                    Layout.fillWidth: true
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 120

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 8

                Text {
                    text: "Использование RAM"
                    color: Theme.textSecondary
                    font: Theme.fontBody
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: controller.ramUsage.toFixed(1) + "%"
                    color: Theme.accent
                    font.pixelSize: 28
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                ProgressBar {
                    value: controller.ramUsage / 100.0
                    Layout.fillWidth: true
                }
            }
        }

        Card {
            Layout.fillWidth: true
            implicitHeight: 120

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 8

                Text {
                    text: "Занятость диска"
                    color: Theme.textSecondary
                    font: Theme.fontBody
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: controller.diskUsage.toFixed(1) + "%"
                    color: Theme.accent
                    font.pixelSize: 28
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                ProgressBar {
                    value: controller.diskUsage / 100.0
                    Layout.fillWidth: true
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
