import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

ColumnLayout {
    spacing: 12

    RowLayout {
        Layout.fillWidth: true
        spacing: 12

        Text {
            text: "💬 Чат с ассистентом Vi"
            color: Theme.textPrimary
            font: Theme.fontTitle
        }

        Item { Layout.fillWidth: true }

        Button {
            text: "🗑️ Очистить"
            onClicked: controller.clearChatHistory()
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

        Text {
            text: "Модель:"
            color: Theme.textSecondary
            font: Theme.fontBody
        }

        ComboBox {
            id: modelCombo
            model: ["Auto", "Gemini", "Ollama", "Local"]
            currentIndex: 0
            implicitWidth: 120
            implicitHeight: 32

            background: Rectangle {
                color: Theme.bgInput
                radius: Theme.radiusSmall
                border.color: modelCombo.hovered ? Theme.borderFocus : Theme.borderLight
            }

            contentItem: Text {
                text: modelCombo.displayText
                color: Theme.textPrimary
                font: Theme.fontCaption
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color: Theme.bgSurface
        radius: Theme.radiusMedium
        border.color: Theme.borderLight

        ListView {
            id: chatList
            anchors.fill: parent
            anchors.margins: 14
            clip: true
            spacing: 12
            model: controller.chatHistory

            onCountChanged: chatList.positionViewAtEnd()

            delegate: Item {
                width: chatList.width
                height: msgCard.height + 4

                RowLayout {
                    id: msgCard
                    anchors.left: modelData.sender === "user" ? undefined : parent.left
                    anchors.right: modelData.sender === "user" ? parent.right : undefined
                    width: Math.min(chatList.width * 0.75, msgContent.implicitWidth + 80)
                    spacing: 10

                    // Assistant Avatar Icon
                    Rectangle {
                        width: 32; height: 32; radius: 16
                        color: Theme.accentGlow
                        border.color: Theme.accent
                        visible: modelData.sender !== "user"
                        Layout.alignment: Qt.AlignTop

                        Text { anchors.centerIn: parent; text: "🤖"; font.pixelSize: 14 }
                    }

                    Rectangle {
                        id: msgBubble
                        Layout.fillWidth: true
                        radius: Theme.radiusMedium
                        color: modelData.sender === "user" ? Theme.accent : Theme.bgCard
                        border.color: modelData.sender === "user" ? Theme.borderFocus : Theme.borderLight

                        ColumnLayout {
                            id: msgContent
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 6

                            Text {
                                text: modelData.text
                                color: modelData.sender === "user" ? "#ffffff" : Theme.textPrimary
                                font: Theme.fontBody
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }

                            RowLayout {
                                Layout.fillWidth: true

                                Text {
                                    text: modelData.modelUsed ? ("ИИ: " + modelData.modelUsed) : ""
                                    color: modelData.sender === "user" ? "#e0e7ff" : Theme.textMuted
                                    font: Theme.fontCaption
                                    visible: text.length > 0
                                }

                                Item { Layout.fillWidth: true }

                                Text {
                                    text: modelData.timestamp
                                    color: modelData.sender === "user" ? "#e0e7ff" : Theme.textMuted
                                    font: Theme.fontCaption
                                }
                            }
                        }
                    }

                    // User Avatar Icon
                    Rectangle {
                        width: 32; height: 32; radius: 16
                        color: Theme.bgCardHover
                        border.color: Theme.borderLight
                        visible: modelData.sender === "user"
                        Layout.alignment: Qt.AlignTop

                        Text { anchors.centerIn: parent; text: "👤"; font.pixelSize: 14 }
                    }
                }
            }
        }
    }

    // Input prompt bar
    RowLayout {
        Layout.fillWidth: true
        spacing: 10

        TextField {
            id: inputField
            Layout.fillWidth: true
            placeholderText: controller.isThinking ? "Vi обдумывает ответ..." : "Задайте вопрос или введите команду..."
            enabled: !controller.isThinking
            font: Theme.fontBody
            color: Theme.textPrimary
            placeholderTextColor: Theme.textMuted
            onAccepted: sendBtn.clicked()

            background: Rectangle {
                color: Theme.bgInput
                radius: Theme.radiusMedium
                border.color: inputField.activeFocus ? Theme.borderFocus : Theme.borderLight
                border.width: inputField.activeFocus ? 2 : 1
            }
        }

        Button {
            id: sendBtn
            text: controller.isThinking ? "⏳" : "Отправить ➔"
            enabled: !controller.isThinking && inputField.text.trim().length > 0
            implicitHeight: 40
            implicitWidth: 110

            onClicked: {
                controller.sendMessage(inputField.text, modelCombo.currentText)
                inputField.clear()
            }

            background: Rectangle {
                color: sendBtn.enabled ? (sendBtn.hovered ? Theme.accentHover : Theme.accent) : Theme.bgCard
                radius: Theme.radiusMedium
            }

            contentItem: Text {
                text: sendBtn.text
                color: sendBtn.enabled ? "#ffffff" : Theme.textMuted
                font: Theme.fontHeader
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}
