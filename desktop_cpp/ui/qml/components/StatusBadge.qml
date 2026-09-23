import QtQuick 2.15
import QtQuick.Layouts 1.15
import ".."

Rectangle {
    id: root
    property bool isOnline: false
    property string text: isOnline ? "Online" : "Offline"

    implicitWidth: contentRow.implicitWidth + 16
    implicitHeight: 24
    radius: 12
    color: isOnline ? "#1a2e26" : "#3b1e22"
    border.color: isOnline ? "#059669" : "#dc2626"
    border.width: 1

    RowLayout {
        id: contentRow
        anchors.centerIn: parent
        spacing: 6

        Rectangle {
            width: 8
            height: 8
            radius: 4
            color: root.isOnline ? Theme.statusOnline : Theme.statusOffline
        }

        Text {
            text: root.text
            color: root.isOnline ? Theme.statusOnline : Theme.statusOffline
            font: Theme.fontCaption
        }
    }
}
