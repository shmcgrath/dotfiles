pragma Singleton
import QtQuick

Singleton {
    id: root

    property Palette palette: Palette {
    }
    property Font font: Font {
    }

    component Palette: QtObject {
		property color bg: "#16181a"
		property color bg_alt: "#1e2124"
		property color bg_highlight: "#3c4048"
		property color fg: "#ffffff"

		property color grey: "#7b8496"
		property color blue: "#5ea1ff"
		property color green: "#5eff6c"
		property color cyan: "#5ef1ff"
		property color red: "#ff6e5e"
		property color yellow: "#f1ff5e"
		property color magenta: "#ff5ef1"
		property color pink: "#ff5ea0"
		property color orange: "#ffbd5e"
		property color purple: "#bd5eff"
    }
    component Font: QtObject {
        property FontFamily family: FontFamily {
        }
        property FontSize size: FontSize {
        }
    }
    component FontFamily: QtObject {
        property string material: "Material Symbols Rounded"
        property string mono: "MesloLGS Nerd Font"
        property string sans: "NotoSans Nerd Font"
    }
    component FontSize: QtObject {
        property int l: 18
        property int m: 14
        property int s: 12
        property int xl: 20
        property int xs: 10
    }
}
