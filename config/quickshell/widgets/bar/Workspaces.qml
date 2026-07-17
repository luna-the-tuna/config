import QtQuick
import Quickshell.Hyprland
import qs.config

BarItem {
    readonly property var workspaces: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    readonly property var buttonSize: 12

    readonly property var activeColor: Config.colors.mauve
    readonly property var inactiveColor: Config.colors.overlay0

    function focusWorkspace(name) {
        Hyprland.dispatch(`hl.dsp.focus({ workspace = ${name} })`);
    }

    Repeater {
        model: workspaces

        Rectangle {
            required property var modelData
            readonly property var isActive: Hyprland.focusedWorkspace.name == modelData

            width: buttonSize
            height: buttonSize
            radius: 100
            color: isActive ? activeColor : inactiveColor

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: focusWorkspace(modelData)
            }
        }
    }
}
