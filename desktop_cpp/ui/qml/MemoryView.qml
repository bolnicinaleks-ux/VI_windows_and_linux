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
            text: "Долгосрочная память Vi"
            color: Theme.textPrimary
            font: Theme.fontTitle
        }

        Item { Layout.fillWidth: true }

        TextField {
            id: searchBox
            placeholderText: "Поиск в памяти..."
            implicitWidth: 200
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

            delegate: Rectangle {
                width: memList.width
                implicitHeight: 56
                radius: Theme.radiusSmall
                color: Theme.bgCard
                border.color: Theme.borderLight
                visible: searchBox.text.length === 0 || modelData.key.toLowerCase().includes(searchBox.text.toLowerCase()) || modelData.value.toLowerCase().includes(searchBox.text.toLowerCase())

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    Text {
                        text: "🧠"
                        font.pixelSize: 18
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 2

                        Text {
                            text: modelData.key
                            color: Theme.accent
                            font.bold: true
                            font.pixelSize: 13
                        }

                        Text {
                            text: modelData.value
                            color: Theme.textPrimary
                            font: Theme.fontBody
                        }
                    }

                    Rectangle {
                        color: Theme.bgInput
                        radius: 4
                        implicitWidth: catText.implicitWidth + 12
                        implicitHeight: 20

                        Text {
                            id: catText
                            anchors.centerIn: parent
                            text: modelData.category
                            color: Theme.textMuted
                            font: Theme.fontCaption
                        }
                    }
                }
            }
        }
    }
}
