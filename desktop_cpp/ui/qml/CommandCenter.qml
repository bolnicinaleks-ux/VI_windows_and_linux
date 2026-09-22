import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

ColumnLayout {
    spacing: 16

    Text {
        text: "Оперативное управление"
        color: Theme.textPrimary
        font: Theme.fontTitle
    }

    RowLayout {
        spacing: 12

        Button {
            text: "Проверить статус"
            onClicked: controller.refreshData()
        }

        Button {
            text: "Очистить чат"
            onClicked: controller.clearChatHistory()
        }
    }

    Item { Layout.fillHeight: true }
}
