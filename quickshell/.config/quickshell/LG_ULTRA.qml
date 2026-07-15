import QtQuick
import qs.components
import qs.common
import qs.services

Rectangle {
    id: root

    property QtObject window

    anchors.fill: parent
    color: Theme.palette.bg_highlight

    // Left
    Row {
        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }

        spacing: 6
    }

    // Center
    Row {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        spacing: 6

        Rectangle {
            color: Theme.palette.bg
            radius: 4

            implicitWidth: clockLeft.implicitWidth + 12
            implicitHeight: clockLeft.implicitHeight + 6

            Text {
                id: clockLeft

                anchors.centerIn: parent

                text: DateTime.now
                color: Theme.palette.blue
                font.pixelSize: 14
                font.bold: true
            }
        }

        Rectangle {
            color: Theme.palette.bg
            radius: 4

            implicitWidth: clockCenter.implicitWidth + 12
            implicitHeight: clockCenter.implicitHeight + 6

            Text {
                id: clockCenter

                anchors.centerIn: parent

                text: DateTime.now
                color: Theme.palette.blue
                font.pixelSize: 14
                font.bold: true
            }
        }
    }

    // Right
    Row {
        anchors {
            right: parent.right
            rightMargin: 10
            verticalCenter: parent.verticalCenter
        }

        spacing: 6

        Tray { }
    }
}
