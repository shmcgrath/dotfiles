import qs.services
import qs.common
import QtQuick
import Quickshell.Widgets

MouseArea {
    id: root

    // Visual properties
    property color color: Foundations.palette.base07

    // Interaction properties
    property bool disabled: false
    property bool hoverEffectEnabled: true
    property real hoverOpacity: 0.08
    property real pressOpacity: 0.1
    property real radius: parent?.radius ?? 0

    // Callback
    function onClicked(): void {
    }

    anchors.fill: parent
    cursorShape: enabled ? Qt.PointingHandCursor : undefined
    enabled: !disabled
    hoverEnabled: enabled && root.hoverEffectEnabled

    onClicked: event => enabled && onClicked(event)
    onPressed: event => {
        if (!enabled || !rippleEnabled)
            return;

        const dist = (ox, oy) => ox * ox + oy * oy;

    }

    ClippingRectangle {
        id: hoverLayer

        anchors.fill: parent
        color: {
            if (root.disabled)
                return "transparent";
            if (!root.hoverEffectEnabled)
                return "transparent";

            const alpha = root.pressed ? root.pressOpacity : root.containsMouse ? root.hoverOpacity : 0;
            return Qt.alpha(root.color, alpha);
        }
        radius: root.radius

        Rectangle {

            color: root.color
            opacity: 0
            radius: Foundations.radius.all
        }
    }
}
