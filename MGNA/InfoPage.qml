import QtQuick 2.10
import App 1.0
Item {

    id: root
    width: 800
    height: 320

    Text {
        id: txtInfo
        anchors.fill: parent
        anchors.margins: 32
        font.family: "Cooper Hewitt"
        font.pixelSize: 14
        font.styleName: "Bold"
        font.weight: Font.Light
        color: Colors.text_dark
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        text: "FUM ICP gas Monitoring \n\r copyright 2023.";

    }

}
