//@ pragma UseQApplication
import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.common

ShellRoot {
	id: root

    // Font
    property string fontFamily: "CommitMono Nerd Font Propo, Symbols Nerd Font, Noto Sans CJK"
    property int fontSize: 14
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

			margins {
				top: 10
				left: 10
				right: 10
			}

            Loader {
                anchors.fill: parent

                source:
                    screen.name === "DP-3"
                        ? "LG_ULTRA.qml"
                        : screen.name === "HDMI-A-1"
                            ? "ASUS_CODE.qml"
                            : "placeholder_bar.qml"
            }
        }
    }
}
