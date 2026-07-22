import QtQuick
import Quickshell

Variants {
    model: Quickshell.screens

    readonly property var margin: 10
    readonly property var size: 44

    PanelWindow {
        required property var modelData

        screen: modelData
        exclusiveZone: size
        implicitWidth: size + margin
        color: "transparent"

        anchors {
            top: true
            bottom: true
            right: true
        }

        Column {
            spacing: margin

            anchors {
                margins: margin
                top: parent.top
                right: parent.right
                left: parent.left
            }

            Time {
                anchors.left: parent.left
                anchors.right: parent.right
            }

            Workspaces {
                anchors.left: parent.left
                anchors.right: parent.right
            }
        }
    }
}
