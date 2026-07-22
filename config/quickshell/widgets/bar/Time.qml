import Quickshell
import QtQuick
import qs.config

BarItem {
    padding: 20
    spacing: 4

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Text {
        text: Qt.formatDateTime(clock.date, "hh")
        color: Config.colors.text
        font.family: "Maple Mono NF"
    }

    Text {
        text: Qt.formatDateTime(clock.date, "mm")
        color: Config.colors.text
        font.family: "Maple Mono NF"
    }
}
