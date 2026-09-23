import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

ColumnLayout {
    spacing: 12

    RowLayout {
        Layout.fillWidth: true
        spacing: 12

        Text {
            text: "Чат с ассистентом Vi"
            color: Theme.textPrimary
            font: Theme.fontTitle
        }

        Item { Layout.fillWidth: true }

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
            anchors.margins: 12
            clip: true
            spacing: 10
            model: controller.chatHistory

            delegate: RowLayout {
                width: chatList.width
                Layout.alignment: modelData.sender === "user" ? Qt.AlignRight : Qt.AlignLeft

                Rectangle {
                    property real maxMsgWidth: chatList.width * 0.7
                    implicitWidth: Math.min(msgText.implicitWidth + 24, maxMsgWidth)
                    implicitHeight: msgText.implicitHeight + 20
                    radius: Theme.radiusMedium
                    color: modelData.sender === "user" ? Theme.accent : Theme.bgCard
                    border.color: modelData.sender === "user" ? Theme.accentHover : Theme.borderLight

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 4

                        Text {
                            id: msgText
                            text: modelData.text
                            color: Theme.textPrimary
                            font: Theme.fontBody
                            wrapMode: Text.Wrap
                            width: parent.width
                        }

                        Text {
                            text: (modelData.modelUsed ? "[" + modelData.modelUsed + "] " : "") + modelData.timestamp
                            color: Theme.textMuted
                            font: Theme.fontCaption
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                }
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 8

        TextField {
            id: inputField
            Layout.fillWidth: true
            placeholderText: controller.isThinking ? "Vi думает..." : "Напишите сообщение..."
            enabled: !controller.isThinking
            onAccepted: sendBtn.clicked()
        }

        Button {
            id: sendBtn
            text: "Отправить"
            enabled: !controller.isThinking && inputField.text.length > 0
            onClicked: {
                controller.sendMessage(inputField.text, modelCombo.currentText)
                inputField.clear()
            }
        }
    }
}
