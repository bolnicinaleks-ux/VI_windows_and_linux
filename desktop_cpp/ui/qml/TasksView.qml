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
            text: "Менеджер задач"
            color: Theme.textPrimary
            font: Theme.fontTitle
        }

        Item { Layout.fillWidth: true }

        Button {
            text: "Обновить"
            onClicked: controller.refreshData()
        }
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: 8

        TextField {
            id: taskInput
            Layout.fillWidth: true
            placeholderText: "Новая задача..."
            onAccepted: addBtn.clicked()
        }

        TextField {
            id: dueInput
            implicitWidth: 100
            placeholderText: "18:00"
            onAccepted: addBtn.clicked()
        }

        Button {
            id: addBtn
            text: "+ Добавить"
            enabled: taskInput.text.trimmed().length > 0
            onClicked: {
                controller.addTask(taskInput.text, dueInput.text)
                taskInput.clear()
                dueInput.clear()
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
            id: taskList
            anchors.fill: parent
            anchors.margins: 12
            clip: true
            spacing: 8
            model: controller.tasks

            delegate: Rectangle {
                width: taskList.width
                height: 48
                radius: Theme.radiusSmall
                color: Theme.bgCard
                border.color: Theme.borderLight

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12

                    CheckBox {
                        checked: modelData.done
                        onClicked: controller.toggleTaskDone(modelData.id)
                    }

                    Text {
                        text: modelData.title
                        color: modelData.done ? Theme.textMuted : Theme.textPrimary
                        font.pixelSize: 13
                        font.strikeout: modelData.done
                        Layout.fillWidth: true
                    }

                    Text {
                        text: modelData.dueAt ? "⏰ " + modelData.dueAt : ""
                        color: Theme.textSecondary
                        font: Theme.fontCaption
                        visible: modelData.dueAt.length > 0
                    }

                    Text {
                        text: modelData.source ? "[" + modelData.source + "]" : ""
                        color: Theme.textMuted
                        font: Theme.fontCaption
                    }
                }
            }
        }
    }
}
