import QtQuick 2.10
import QtGraphicalEffects 1.0
import App 1.0
Item {
    id: root
    property alias mSource: img.source
    property alias mWidth: root.width
    property alias mHeight: root.height
    property string mColor
    property string mActiveColor
    property bool isActive: false
    signal mClicked();

    Rectangle{
        anchors.fill: parent
        border.width: 2
        border.color: root.isActive ? root.mActiveColor : root.mColor
        radius: (Math.min(root.width,root.height) / 2)
        color: root.isActive ? root.mActiveColor : Colors.transparent
        clip: true
        Image {
            id: img
            anchors.fill: parent
            anchors.margins: 8
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size( width, height )
            Image {
                id: imgInner
                source: parent.source
                width: 0
                height: 0
            }
        }
        ColorOverlay{
            id: colorOverlay
            anchors.fill: img
            source: img
            color: root.isActive ? root.mColor : root.mColor
        }
        MouseArea
        {
            anchors.fill: parent
            onClicked: {
                root.mClicked();
            }

        }
    }

}
