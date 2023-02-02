import QtQuick 2.10
import QtGraphicalEffects 1.0
import com.nourbakhsh.RNElapsedTimer 1.0
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
    signal mHolded();

    RNElapsedTimer{
        id: timer
    }

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
            property bool isLongPress: false
            anchors.fill: parent
            pressAndHoldInterval: 3000
            onPressed: {
                //timer.start();
                isLongPress = false;
                //console.log("PRESED");
            }
            onPressAndHold: {
                isLongPress = true;
                root.mHolded();
                //console.log("HOLDED");
            }

            onReleased: {
                if(isLongPress) return;
                root.mClicked();
                //console.log("RELASED")
//                let t = timer.elapsed();
//                timer.stop();
//                if(t>=3000) return;
//                root.mClicked();
            }

        }
    }

}
