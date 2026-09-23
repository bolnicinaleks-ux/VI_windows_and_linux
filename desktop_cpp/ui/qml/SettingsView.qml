import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

ColumnLayout {
    spacing: 16

    Text {
        text: "⚙️ Настройки и параметры"
        color: Theme.textPrimary
        font: Theme.fontTitle
    }

    // Theme Selection Section
    Card {
        Layout.fillWidth: true
        implicitHeight: 140

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            Text {
                text: "🎨 Темы оформления интерфейса"
                color: Theme.textPrimary
                font: Theme.fontHeader
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Repeater {
                    model: Theme.availableThemes

                    delegate: Rectangle {
                        property bool isSelected: Theme.themeName === modelData

                        Layout.fillWidth: true
                        implicitHeight: 56
                        radius: Theme.radiusMedium
                        color: isSelected ? Theme.accentGlow : (themeBtnMouse.containsMouse ? Theme.bgCardHover : Theme.bgInput)
                        border.color: isSelected ? Theme.accent : Theme.borderLight
                        border.width: isSelected ? 2 : 1

                        MouseArea {
                            id: themeBtnMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: controller.setTheme(modelData)
                        }

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 2

                            Text {
                                text: modelData
                                color: isSelected ? Theme.textPrimary : Theme.textSecondary
                                font: Theme.fontCaption
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Rectangle {
                                width: 8; height: 8; radius: 4
                                color: isSelected ? Theme.accent : "transparent"
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }
            }
        }
    }

    // Connection & API Key Settings Card
    Card {
        Layout.fillWidth: true
        implicitHeight: 230

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 18
            spacing: 14

            Text {
                text: "🔌 Подключение к серверу Vi (FastAPI)"
                color: Theme.textPrimary
                font: Theme.fontHeader
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4
                Text { text: "URL Адрес Сервера:"; color: Theme.textSecondary; font: Theme.fontCaption }
                TextField {
                    id: urlInput
                    Layout.fillWidth: true
                    text: controller.serverUrl
                    placeholderText: "http://localhost:8000"
                    font: Theme.fontBody
                    color: Theme.textPrimary
                    placeholderTextColor: Theme.textMuted

                    background: Rectangle {
                        color: Theme.bgInput
                        radius: Theme.radiusSmall
                        border.color: urlInput.activeFocus ? Theme.borderFocus : Theme.borderLight
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4
                Text { text: "API Ключ (Bearer Token):"; color: Theme.textSecondary; font: Theme.fontCaption }
                TextField {
                    id: keyInput
                    Layout.fillWidth: true
                    text: controller.apiKey
                    echoMode: TextInput.Password
                    placeholderText: "Введите VI_API_KEY секретный ключ..."
                    font: Theme.fontBody
                    color: Theme.textPrimary
                    placeholderTextColor: Theme.textMuted

                    background: Rectangle {
                        color: Theme.bgInput
                        radius: Theme.radiusSmall
                        border.color: keyInput.activeFocus ? Theme.borderFocus : Theme.borderLight
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Item { Layout.fillWidth: true }

                Button {
                    text: "💾 Сохранить настройки"
                    implicitHeight: 36
                    onClicked: controller.saveSettings(urlInput.text, keyInput.text)

                    background: Rectangle {
                        color: parent.hovered ? Theme.accentHover : Theme.accent
                        radius: Theme.radiusMedium
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "#ffffff"
                        font: Theme.fontHeader
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }

    Item { Layout.fillHeight: true }
}
