pragma Singleton
import QtQuick 2.15

Item {
    readonly property color bgBase: "#0f0f13"
    readonly property color bgSurface: "#181824"
    readonly property color bgCard: "#202030"
    readonly property color bgCardHover: "#28283d"
    readonly property color bgInput: "#14141f"

    readonly property color accent: "#8a5cf6"
    readonly property color accentHover: "#7c3aed"
    readonly property color accentGlow: "#338a5cf6"

    readonly property color textPrimary: "#f3f4f6"
    readonly property color textSecondary: "#9ca3af"
    readonly property color textMuted: "#6b7280"

    readonly property color borderLight: "#2e2e42"
    readonly property color borderFocus: "#8a5cf6"

    readonly property color statusOnline: "#10b981"
    readonly property color statusOffline: "#ef4444"
    readonly property color statusWarning: "#f59e0b"

    readonly property font fontTitle: Qt.font({ family: "Segoe UI", pixelSize: 20, weight: Font.Bold })
    readonly property font fontHeader: Qt.font({ family: "Segoe UI", pixelSize: 16, weight: Font.DemiBold })
    readonly property font fontBody: Qt.font({ family: "Segoe UI", pixelSize: 13, weight: Font.Normal })
    readonly property font fontCaption: Qt.font({ family: "Segoe UI", pixelSize: 11, weight: Font.Normal })

    readonly property int radiusSmall: 6
    readonly property int radiusMedium: 10
    readonly property int radiusLarge: 14
}
