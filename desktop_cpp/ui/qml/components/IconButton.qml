import QtQuick 2.15
import QtQuick.Controls 2.15
import ".."

Button {
    id: control
    property string iconText: ""
    property color iconColor: Theme.textSecondary
    property color hoverBg: Theme.bgCardHover
    property int iconSize: 14

    implicitWidth: 32
    implicitHeight: 32

    background: Rectangle {
        color: control.hovered ? control.hoverBg : "transparent"
        radius: Theme.radiusSmall
    }

    contentItem: Text {
        text: control.iconText
        font.pixelSize: control.iconSize
        color: control.iconColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
