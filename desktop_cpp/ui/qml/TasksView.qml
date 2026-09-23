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
            text: "📋 Менеджер задач"
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

    // Add Task Row
    RowLayout {
        Layout.fillWidth: true
        spacing: 8

        TextField {
            id: taskInput
            Layout.fillWidth: true
            placeholderText: "Название новой задачи..."
            font: Theme.fontBody
            color: Theme.textPrimary
            placeholderTextColor: Theme.textMuted
            onAccepted: addBtn.clicked()

            background: Rectangle {
                color: Theme.bgInput
                radius: Theme.radiusMedium
                border.color: taskInput.activeFocus ? Theme.borderFocus : Theme.borderLight
            }
        }

        TextField {
            id: dueInput
            implicitWidth: 110
            placeholderText: "Срок (18:00)"
            font: Theme.fontBody
            color: Theme.textPrimary
            placeholderTextColor: Theme.textMuted
            onAccepted: addBtn.clicked()

            background: Rectangle {
                color: Theme.bgInput
                radius: Theme.radiusMedium
                border.color: dueInput.activeFocus ? Theme.borderFocus : Theme.borderLight
            }
        }

        Button {
            id: addBtn
            text: "+ Добавить"
            enabled: taskInput.text.trim().length > 0
            implicitHeight: 38

            onClicked: {
                controller.addTask(taskInput.text, dueInput.text)
                taskInput.clear()
                dueInput.clear()
            }

            background: Rectangle {
                color: addBtn.enabled ? (addBtn.hovered ? Theme.accentHover : Theme.accent) : Theme.bgCard
                radius: Theme.radiusMedium
            }

            contentItem: Text {
                text: addBtn.text
                color: addBtn.enabled ? "#ffffff" : Theme.textMuted
                font: Theme.fontHeader
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }

    // Task List Area
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
                height: 52
                radius: Theme.radiusMedium
                color: modelData.done ? Theme.bgCard : (itemMouse.containsMouse ? Theme.bgCardHover : Theme.bgCard)
                border.color: modelData.done ? Theme.borderLight : (itemMouse.containsMouse ? Theme.borderFocus : Theme.borderLight)

                MouseArea {
                    id: itemMouse
                    anchors.fill: parent
                    hoverEnabled: true
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12

                    // Custom Checkbox
                    Rectangle {
                        width: 22; height: 22; radius: 6
                        color: modelData.done ? Theme.accent : Theme.bgInput
                        border.color: modelData.done ? Theme.accent : Theme.borderLight

                        Text {
                            anchors.centerIn: parent
                            text: "✓"
                            color: "#ffffff"
                            font: Theme.fontCaption
                            visible: modelData.done
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: controller.toggleTaskDone(modelData.id)
                        }
                    }

                    Text {
                        text: modelData.title
                        color: modelData.done ? Theme.textMuted : Theme.textPrimary
                        font: Qt.font({ family: "Segoe UI", pixelSize: 13, strikeout: modelData.done })
                        Layout.fillWidth: true
                    }

                    Text {
                        text: modelData.dueAt ? "⏰ " + modelData.dueAt : ""
                        color: Theme.textSecondary
                        font: Theme.fontCaption
                        visible: modelData.dueAt && modelData.dueAt.length > 0
                    }

                    Rectangle {
                        color: Theme.accentGlow
                        radius: 4
                        implicitWidth: sourceTxt.implicitWidth + 8
                        implicitHeight: 20
                        visible: modelData.source && modelData.source.length > 0

                        Text {
                            id: sourceTxt
                            anchors.centerIn: parent
                            text: modelData.source || ""
                            color: Theme.accent
                            font: Theme.fontCaption
                        }
                    }
                }
            }
        }
    }
}
