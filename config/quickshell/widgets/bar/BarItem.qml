import QtQuick
import QtQuick.Effects
import qs.config

Item {
    id: root

    default property alias content: contentItem.data

    readonly property var spacing: 15
    readonly property var padding: spacing * 2

    implicitHeight: contentItem.childrenRect.height + padding

    RectangularShadow {
        anchors.fill: rectangle
        radius: rectangle.radius
        blur: 10
        spread: 2
        color: Qt.alpha(Config.colors.crust, 0.5)
    }

    Rectangle {
        id: rectangle
        anchors.fill: parent
        color: Config.colors.base
        radius: 4

        Column {
            id: contentItem
            anchors.centerIn: parent
            width: childrenRect.width
            height: childrenRect.height
            spacing: root.spacing
        }
    }
}
