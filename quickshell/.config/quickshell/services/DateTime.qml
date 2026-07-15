pragma Singleton
import QtQuick
import Quickshell

pragma Singleton
import QtQuick

Singleton {
    property var now: new Date()

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: DateTime.now = new Date()
    }
}
