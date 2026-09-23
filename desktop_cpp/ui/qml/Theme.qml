pragma Singleton
import QtQuick 2.15

Item {
    id: themeSingleton

    property string themeName: (typeof controller !== "undefined" && controller && controller.currentTheme) ? controller.currentTheme : "Dark Glass"

    // Responsive theme definitions
    readonly property var themes: ({
        "Dark Glass": {
            bgBase: "#0b0c10",
            bgSurface: "#12141d",
            bgCard: "#1a1d29",
            bgCardHover: "#232738",
            bgInput: "#0f1118",
            accent: "#8a5cf6",
            accentHover: "#9d72f8",
            accentGlow: "#358a5cf6",
            accentGradStart: "#8a5cf6",
            accentGradEnd: "#6366f1",
            textPrimary: "#f3f4f6",
            textSecondary: "#9ca3af",
            textMuted: "#6b7280",
            borderLight: "#272a3b",
            borderFocus: "#8a5cf6",
            borderGlow: "#4d8a5cf6",
            statusOnline: "#10b981",
            statusOffline: "#ef4444",
            statusWarning: "#f59e0b"
        },
        "Cyberpunk Neon": {
            bgBase: "#05050d",
            bgSurface: "#0c0d1a",
            bgCard: "#141628",
            bgCardHover: "#1d203a",
            bgInput: "#090a14",
            accent: "#00f0ff",
            accentHover: "#33f3ff",
            accentGlow: "#4000f0ff",
            accentGradStart: "#00f0ff",
            accentGradEnd: "#ff007f",
            textPrimary: "#ffffff",
            textSecondary: "#8f92b2",
            textMuted: "#5b5e7a",
            borderLight: "#1f223f",
            borderFocus: "#00f0ff",
            borderGlow: "#6000f0ff",
            statusOnline: "#00ff99",
            statusOffline: "#ff0055",
            statusWarning: "#ffcc00"
        },
        "Light Glass": {
            bgBase: "#f1f5f9",
            bgSurface: "#ffffff",
            bgCard: "#f8fafc",
            bgCardHover: "#e2e8f0",
            bgInput: "#ffffff",
            accent: "#2563eb",
            accentHover: "#3b82f6",
            accentGlow: "#252563eb",
            accentGradStart: "#2563eb",
            accentGradEnd: "#06b6d4",
            textPrimary: "#0f172a",
            textSecondary: "#475569",
            textMuted: "#94a3b8",
            borderLight: "#e2e8f0",
            borderFocus: "#2563eb",
            borderGlow: "#302563eb",
            statusOnline: "#059669",
            statusOffline: "#dc2626",
            statusWarning: "#d97706"
        },
        "OLED Obsidian": {
            bgBase: "#000000",
            bgSurface: "#080808",
            bgCard: "#121212",
            bgCardHover: "#1c1c1c",
            bgInput: "#0a0a0a",
            accent: "#10b981",
            accentHover: "#34d399",
            accentGlow: "#3510b981",
            accentGradStart: "#10b981",
            accentGradEnd: "#059669",
            textPrimary: "#ffffff",
            textSecondary: "#a1a1aa",
            textMuted: "#52525b",
            borderLight: "#27272a",
            borderFocus: "#10b981",
            borderGlow: "#4d10b981",
            statusOnline: "#10b981",
            statusOffline: "#f43f5e",
            statusWarning: "#fbbf24"
        },
        "Sunset Horizon": {
            bgBase: "#120e16",
            bgSurface: "#1a1422",
            bgCard: "#251d30",
            bgCardHover: "#322741",
            bgInput: "#150f1d",
            accent: "#f97316",
            accentHover: "#fb923c",
            accentGlow: "#35f97316",
            accentGradStart: "#f97316",
            accentGradEnd: "#ec4899",
            textPrimary: "#fdf8f6",
            textSecondary: "#b4a9bd",
            textMuted: "#72657d",
            borderLight: "#392c47",
            borderFocus: "#f97316",
            borderGlow: "#4df97316",
            statusOnline: "#10b981",
            statusOffline: "#ef4444",
            statusWarning: "#f59e0b"
        }
    })

    readonly property var current: themes[themeName] || themes["Dark Glass"]

    readonly property color bgBase: current.bgBase
    readonly property color bgSurface: current.bgSurface
    readonly property color bgCard: current.bgCard
    readonly property color bgCardHover: current.bgCardHover
    readonly property color bgInput: current.bgInput

    readonly property color accent: current.accent
    readonly property color accentHover: current.accentHover
    readonly property color accentGlow: current.accentGlow
    readonly property color accentGradStart: current.accentGradStart
    readonly property color accentGradEnd: current.accentGradEnd

    readonly property color textPrimary: current.textPrimary
    readonly property color textSecondary: current.textSecondary
    readonly property color textMuted: current.textMuted

    readonly property color borderLight: current.borderLight
    readonly property color borderFocus: current.borderFocus
    readonly property color borderGlow: current.borderGlow

    readonly property color statusOnline: current.statusOnline
    readonly property color statusOffline: current.statusOffline
    readonly property color statusWarning: current.statusWarning

    readonly property font fontTitle: Qt.font({ family: "Segoe UI", pixelSize: 22, weight: Font.Bold })
    readonly property font fontHeader: Qt.font({ family: "Segoe UI", pixelSize: 16, weight: Font.DemiBold })
    readonly property font fontBody: Qt.font({ family: "Segoe UI", pixelSize: 13, weight: Font.Normal })
    readonly property font fontCaption: Qt.font({ family: "Segoe UI", pixelSize: 11, weight: Font.Normal })

    readonly property int radiusSmall: 8
    readonly property int radiusMedium: 12
    readonly property int radiusLarge: 18

    readonly property var availableThemes: ["Dark Glass", "Cyberpunk Neon", "Light Glass", "OLED Obsidian", "Sunset Horizon"]
}
