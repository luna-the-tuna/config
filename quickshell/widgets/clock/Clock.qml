import QtQml
import QtQuick
import QtQuick.Effects
import Quickshell
import qs.config

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData
        aboveWindows: false
        color: "transparent"

        anchors {
            top: true
            right: true
            bottom: true
            left: true
        }

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        Text {
            color: Config.theme.text
            text: Qt.formatDateTime(clock.date, "hh:mm")

            font {
                family: Config.font
                pointSize: 65
                weight: 700
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 125
            }

            layer {
                enabled: true

                effect: MultiEffect {
                    shadowEnabled: true
                    shadowBlur: 0.4
                    shadowOpacity: 0.5
                    shadowColor: Config.theme.crust
                }
            }
        }
    }
}
