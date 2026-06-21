import QtQuick
import Quickshell
import qs.config

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData
        aboveWindows: false
        exclusionMode: ExclusionMode.Ignore

        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }

        Image {
            anchors.fill: parent
            asynchronous: true
            source: Config.wallpaper
            fillMode: Image.PreserveAspectCrop
        }
    }
}
