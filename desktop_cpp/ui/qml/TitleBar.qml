import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

Rectangle {
    id: titleBar
    height: 42
    color: Theme.bgBase

    signal minimizeRequested()
    signal maximizeRequested()
    signal closeRequested()

    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: Theme.borderLight
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 8
        spacing: 12

        // App Logo Icon
        Rectangle {
            width: 24
            height: 24
            radius: 6
            color: Theme.accent

            Text {
                anchors.centerIn: parent
                text: "V"
                color: "#ffffff"
                font.bold: true
                font.pixelSize: 13
            }
        }

        Text {
            text: "Vi Desktop"
            color: Theme.textPrimary
            font: Theme.fontHeader
            Layout.alignment: Qt.AlignVCenter
        }

        StatusBadge {
            isOnline: controller.isOnline
            Layout.alignment: Qt.AlignVCenter
        }

        Item { Layout.fillWidth: true }

        // Quick Theme Selector
        RowLayout {
            spacing: 6
            Layout.alignment: Qt.AlignVCenter

            Text {
                text: "🎨 Тема:"
                color: Theme.textSecondary
                font: Theme.fontCaption
            }

            ComboBox {
                id: themePicker
                model: Theme.availableThemes
                currentIndex: Math.max(0, Theme.availableThemes.indexOf(Theme.themeName))
                implicitWidth: 140
                implicitHeight: 26

                onActivated: (index) => {
                    var sel = model[index]
                    controller.setTheme(sel)
                }

                background: Rectangle {
                    color: Theme.bgInput
                    radius: Theme.radiusSmall
                    border.color: themePicker.hovered ? Theme.borderFocus : Theme.borderLight
                }

                contentItem: Text {
                    text: themePicker.displayText
                    color: Theme.textPrimary
                    font: Theme.fontCaption
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 8
                }
            }
        }

        IconButton {
            iconText: "─"
            onClicked: titleBar.minimizeRequested()
        }

        IconButton {
            iconText: "□"
            onClicked: titleBar.maximizeRequested()
        }

        IconButton {
            iconText: "✕"
            hoverBg: "#dc2626"
            iconColor: hovered ? "#ffffff" : Theme.textSecondary
            onClicked: titleBar.closeRequested()
        }
    }
}
