import QtQuick
import QtQuick.Layouts
import qs.ds

Rectangle {
    anchors.fill: parent
    color: Theme.palette.red

    RowLayout {
        anchors.fill: parent

        Item { Layout.fillWidth: true }

        Text {
            text: "PLACEHOLDER - DEFINE BAR FOR THIS DISPLAY"
            color: Theme.palette.fg
            font.pixelSize: 14
            font.bold: true
        }

        Item { Layout.fillWidth: true }
    }
}
