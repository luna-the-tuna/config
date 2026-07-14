pragma Singleton

import QtCore
import Quickshell
import Quickshell.Io

Singleton {
    property alias wallpaper: adapter.wallpaper

    FileView {
        path: StandardPaths.locate(StandardPaths.ConfigLocation, "quickshell.json")
        watchChanges: true

        onFileChanged: reload()
        onAdapterChanged: writeAdapter()

        JsonAdapter {
            id: adapter

            property string wallpaper
        }
    }
}
