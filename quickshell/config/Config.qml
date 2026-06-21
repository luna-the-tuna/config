pragma Singleton

import QtCore
import Quickshell
import Quickshell.Io

Singleton {
    property alias wallpaper: adapter.wallpaper
    property alias font: adapter.font
    property alias theme: adapter.theme

    FileView {
        path: StandardPaths.locate(StandardPaths.ConfigLocation, "quickshell.json")
        watchChanges: true

        onFileChanged: reload()
        onAdapterChanged: writeAdapter()

        JsonAdapter {
            id: adapter

            property string wallpaper
            property string font

            property JsonObject theme: JsonObject {
                property string base
                property string blue
                property string crust
                property string flamingo
                property string green
                property string lavender
                property string mantle
                property string maroon
                property string mauve
                property string overlay0
                property string overlay1
                property string overlay2
                property string peach
                property string pink
                property string red
                property string rosewater
                property string sapphire
                property string sky
                property string subtext0
                property string subtext1
                property string surface0
                property string surface1
                property string surface2
                property string teal
                property string text
                property string yellow
            }
        }
    }
}
