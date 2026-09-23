import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "components"
import "."

Rectangle {
    id: titleBar
    height: 36
    color: Theme.bgBase

    signal minimizeRequested()
    signal maximizeRequested()
    signal closeRequested()

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 0
        spacing: 8

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
