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
            text: "🧠 Долгосрочная память Vi"
            color: Theme.textPrimary
            font: Theme.fontTitle
        }

        Item { Layout.fillWidth: true }

        TextField {
            id: searchBox
            placeholderText: "🔍 Поиск по ключу или значению..."
            implicitWidth: 240
            font: Theme.fontBody
            color: Theme.textPrimary
            placeholderTextColor: Theme.textMuted

            background: Rectangle {
                color: Theme.bgInput
                radius: Theme.radiusMedium
                border.color: searchBox.activeFocus ? Theme.borderFocus : Theme.borderLight
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
            id: memList
            anchors.fill: parent
            anchors.margins: 12
            clip: true
            spacing: 8
            model: controller.memoryItems

            delegate: Item {
                property bool matchesFilter: searchBox.text.length === 0 ||
                                            modelData.key.toLowerCase().includes(searchBox.text.toLowerCase()) ||
                                            modelData.value.toLowerCase().includes(searchBox.text.toLowerCase())

                width: memList.width
                height: matchesFilter ? 62 : 0
                visible: matchesFilter

                Rectangle {
                    anchors.fill: parent
                    radius: Theme.radiusMedium
                    color: itemMouse.containsMouse ? Theme.bgCardHover : Theme.bgCard
                    border.color: itemMouse.containsMouse ? Theme.borderFocus : Theme.borderLight

                    MouseArea {
                        id: itemMouse
                        anchors.fill: parent
                        hoverEnabled: true
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 12

                        Rectangle {
                            width: 36; height: 36; radius: 10
                            color: Theme.accentGlow
                            border.color: Theme.accent
                            Text { anchors.centerIn: parent; text: "🧠"; font.pixelSize: 16 }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                text: modelData.key
                                color: Theme.accent
                                font: Theme.fontHeader
                            }

                            Text {
                                text: modelData.value
                                color: Theme.textPrimary
                                font: Theme.fontBody
                                elide: Text.ElideRight
                            }
                        }

                        Rectangle {
                            color: Theme.bgInput
                            radius: 6
                            implicitWidth: catText.implicitWidth + 12
                            implicitHeight: 24

                            Text {
                                id: catText
                                anchors.centerIn: parent
                                text: modelData.category || "General"
                                color: Theme.textSecondary
                                font: Theme.fontCaption
                            }
                        }
                    }
                }
            }
        }
    }
}
