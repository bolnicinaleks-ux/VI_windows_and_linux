import QtQuick 2.15
import QtQuick.Controls 2.15
import ".."

Rectangle {
    id: root
    property color cardColor: Theme.bgCard
    property color hoverColor: Theme.bgCardHover
    property int cornerRadius: Theme.radiusMedium
    property color borderColor: Theme.borderLight
    property color hoverBorderColor: Theme.borderFocus
    property bool enableHoverGlow: true

    color: mouseArea.containsMouse ? hoverColor : cardColor
    radius: cornerRadius
    border.color: (enableHoverGlow && mouseArea.containsMouse) ? hoverBorderColor : borderColor
    border.width: 1

    Behavior on color { ColorAnimation { duration: 200 } }
    Behavior on border.color { ColorAnimation { duration: 200 } }

    Rectangle {
        id: glowAccent
        anchors.fill: parent
        anchors.margins: -1
        radius: parent.radius + 1
        color: "transparent"
        border.color: Theme.accentGlow
        border.width: 2
        opacity: mouseArea.containsMouse && enableHoverGlow ? 1.0 : 0.0
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
