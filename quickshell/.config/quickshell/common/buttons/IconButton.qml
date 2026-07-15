import QtQuick
import Quickshell.Widgets
import qs.common

Rectangle {
    id: root

    property color buttonColor: Foundations.palette.base02
    property real buttonSize: 48
    property color focusColor: Foundations.palette.base04
    property color focusIconColor: Foundations.palette.base0F

    property string icon: ""
    property color iconColor: Foundations.palette.base07
    property string iconPath: ""
    property int iconPointSize: Foundations.font.size.xl
    readonly property bool useImageIcon: iconPath !== ""

    signal clicked
    signal hovered

    color: activeFocus ? focusColor : buttonColor
    implicitHeight: buttonSize
    implicitWidth: buttonSize
    radius: Foundations.radius.l

    // height: buttonSize
    // width: buttonSize
    InteractiveArea {
        function onClicked(): void {
            root.clicked();
        }
        function onEntered(): void {
            root.hovered();
        }

        color: root.activeFocus ? root.focusIconColor : root.iconColor
        radius: parent.radius
    }

    // MouseArea {
    //     anchors.fill: parent
    //     hoverEnabled: true
    //
    //     onClicked: root.clicked()
    //     onEntered: root.hovered()
    // }

    Text {
        anchors.centerIn: parent

        visible: !root.useImageIcon

        text: root.icon

        color: root.activeFocus
            ? root.focusIconColor
            : root.iconColor

        font.pointSize: root.iconPointSize
    }

    // Image icon (for app icons, etc.)
    IconImage {
        anchors.centerIn: parent
        asynchronous: true
        height: root.buttonSize
        source: root.iconPath
        visible: root.useImageIcon
        width: root.buttonSize
    }
}
