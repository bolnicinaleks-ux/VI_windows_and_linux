import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import ".."

Rectangle {
    id: root
    property color cardColor: Theme.bgCard
    property color hoverColor: Theme.bgCardHover
    property int cornerRadius: Theme.radiusMedium
    property color borderColor: Theme.borderLight

    color: mouseArea.containsMouse ? hoverColor : cardColor
    radius: cornerRadius
    border.color: borderColor
    border.width: 1

    Behavior on color {
        ColorAnimation { duration: 150 }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
