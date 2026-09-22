import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

ColumnLayout {
    spacing: 16

    Text {
        text: "Настройки приложения"
        color: Theme.textPrimary
        font: Theme.fontTitle
    }

    Rectangle {
        Layout.fillWidth: true
        implicitHeight: 220
        color: Theme.bgSurface
        radius: Theme.radiusMedium
        border.color: Theme.borderLight

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 16

            ColumnLayout {
                spacing: 6
                Text { text: "URL Сервера FastAPI:"; color: Theme.textSecondary; font: Theme.fontBody }
                TextField {
                    id: urlInput
                    Layout.fillWidth: true
                    text: controller.serverUrl
                    placeholderText: "http://localhost:8000"
                }
            }

            ColumnLayout {
                spacing: 6
                Text { text: "API Ключ (VI_API_KEY):"; color: Theme.textSecondary; font: Theme.fontBody }
                TextField {
                    id: keyInput
                    Layout.fillWidth: true
                    text: controller.apiKey
                    echoMode: TextInput.Password
                    placeholderText: "Введите API ключ..."
                }
            }

            RowLayout {
                Item { Layout.fillWidth: true }
                Button {
                    text: "Сохранить настройки"
                    onClicked: controller.saveSettings(urlInput.text, keyInput.text)
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
