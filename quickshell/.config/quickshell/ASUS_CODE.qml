import QtQuick
import QtQuick.Layouts
import qs.common

Rectangle {
    anchors.fill: parent
    color: Theme.palette.bg_highlight

    RowLayout {
        anchors.fill: parent

        Item { Layout.fillWidth: true }

        Text {
            text: "Bar 2"
            color: Theme.palette.blue
            font.pixelSize: 14
            font.bold: true
        }

        Item { Layout.fillWidth: true }
    }
}
