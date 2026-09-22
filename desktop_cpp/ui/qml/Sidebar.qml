import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "."

Rectangle {
    id: sidebar
    width: 200
    color: Theme.bgSurface
    border.color: Theme.borderLight
    border.width: 1

    property int currentIndex: 0

    ListModel {
        id: navModel
        ListElement { name: "Дашборд"; icon: "📊"; viewIndex: 0 }
        ListElement { name: "Чат VI"; icon: "💬"; viewIndex: 1 }
        ListElement { name: "Задачи"; icon: "📋"; viewIndex: 2 }
        ListElement { name: "Метрики"; icon: "📈"; viewIndex: 3 }
        ListElement { name: "Память"; icon: "🧠"; viewIndex: 4 }
        ListElement { name: "Командный центр"; icon: "⚡"; viewIndex: 5 }
        ListElement { name: "Настройки"; icon: "⚙️"; viewIndex: 6 }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 12
        anchors.bottomMargin: 12
        spacing: 4

        ListView {
            id: navList
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: navModel
            interactive: false

            delegate: Rectangle {
                width: navList.width - 16
                height: 40
                anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
                radius: Theme.radiusSmall
                color: sidebar.currentIndex === index ? Theme.accentGlow : (itemMouse.containsMouse ? Theme.bgCard : "transparent")
                border.color: sidebar.currentIndex === index ? Theme.accent : "transparent"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 10

                    Text {
                        text: icon
                        font.pixelSize: 16
                    }

                    Text {
                        text: name
                        color: sidebar.currentIndex === index ? Theme.textPrimary : Theme.textSecondary
                        font: Theme.fontBody
                        Layout.fillWidth: true
                    }
                }

                MouseArea {
                    id: itemMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: sidebar.currentIndex = index
                }
            }
        }
    }
}
