import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.common

Rectangle {
	id: root
	implicitWidth: layout.implicitWidth
	implicitHeight: layout.implicitHeight
	Component.onCompleted: {
		console.log("tray items:", SystemTray.items)
		console.log("tray length:", SystemTray.items ? SystemTray.items.length : "null")
	}

	// readonly property alias items: items

	// property int margin: Foundations.spacing.xxs
	// property int spacingItems: Foundations.spacing.xs
	property int spacingItems: 6
	property int buttonSize: Foundations.font.size.xl

	// clip: true
	color: "transparent"
	// implicitHeight: height
	// implicitWidth: layout.implicitWidth + margin * 2
	// radius: Foundations.radius.all
	// visible: width > 0 && height > 0

	RowLayout {
		id: layout

		anchors.centerIn: parent
		// spacing: root.spacingItems

		// anchors.fill: parent
		spacing: 6

		Repeater {
			id: sysTrayItemRepeater
			model: SystemTray.items
			delegate: Rectangle {
				Component.onCompleted: {
					console.log("MODEL DATA")
					console.log(modelData)
					console.log("hasMenu: ", modelData.hasMenu)
					console.log("onlyMenu: ", modelData.onlyMenu)
				}
				id: trayItemDelegate
				width: 20
				height: 20
				color: "transparent"

				required property SystemTrayItem modelData
				property var item: modelData

				property string iconSource: {
					let icon = modelData.icon;

					if (icon.includes("?path=")) {
						const [rawName, path] = icon.split("?path=");
						const name = rawName.split("/").pop();

						// Dropbox tray icons live in a non-standard location
						if (rawName.includes("dropboxstatus-")) {
							return `file://${path}/hicolor/16x16/status/${name}.png`;
						}

						// Generic ?path= handling
						return `file://${path}/${name}`;
					}

					return icon;
				}

				Image {
					anchors.fill: parent
					anchors.centerIn: parent
					source: parent.iconSource
					fillMode: Image.PreserveAspectFit
					smooth: true
				}

				QsMenuAnchor {
					id: menuAnchor
					menu: item.menu
					anchor.item: trayItemDelegate
				}
				
				MouseArea {
					id: mouseArea
					anchors.fill: parent
					acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
					hoverEnabled: true
					onClicked: (mouse) => {
						console.log("SystemTray: Clicked " + item.id + " Button: " + mouse.button);
						if (mouse.button === Qt.LeftButton) {
							item.activate();
						} else if (mouse.button === Qt.MiddleButton) {
							item.secondaryActivate();
						} else if (mouse.button === Qt.RightButton) {
							console.log("SystemTray: Opening menu for " + item.id);
							menuAnchor.open();
						}
					}
				}
			}
		}
	}
}
