import QtQuick 2.10
import QtGraphicalEffects 1.0
import App 1.0
Item {
    id:root
    property color background_color: Colors.element_dark
    property color text_element_color: Colors.text_element_dark
    property color text_color: Colors.text_dark
    property color gradient_top_color: Colors.gradient_top
    property color gradient_bottom_color: Colors.gradient_bottom
    property color border_color: Colors.border_dark
    property alias mWidth: root.width
    property alias mHeight: root.height
    property alias mName: txtName.text
    property alias mState: root.state
    property alias mMin: sdf.mMinTime
    property alias mMax: sdf.mMaxTime
    property alias mValue: sdf.mCurrentTime
    property alias mCircleHeader: sdf.mHeader
    state: "close"
    property int iconSize: 160


    Text{
        id: txtName
        anchors.left: root.left
        anchors.leftMargin: 16
        anchors.top: root.top
        anchors.right: root.right
        anchors.rightMargin: 16
        height: 48
        font.family: "Cooper Hewitt"
        font.pixelSize: 24
        font.styleName: "Light"
        font.weight: Font.Bold
        color: root.text_color
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Text{
        id: txtState
        text:"ICU RM 102,103,104"
        anchors.left: root.left
        anchors.leftMargin: 16
        anchors.top: txtName.bottom
        anchors.right: root.right
        anchors.rightMargin: 16
        horizontalAlignment: Text.AlignHCenter
        height: 48
        font.family: "Cooper Hewitt"
        font.pixelSize: 28
        font.styleName: "Thin"
        font.weight: Font.Bold
        fontSizeMode: Text.Fit
        color: Colors.text_dark
        verticalAlignment: Text.AlignVCenter
    }


    GasGauge{
        id:sdf
        anchors.top: txtState.bottom
        anchors.left: root.left
        anchors.leftMargin: 16
        anchors.right: root.right
        anchors.rightMargin: 16
        size: root.width - 32
        height: root.width - 32
        mHeader: "PSIG"
        mMinTime: 40
        mMaxTime: 100
        text_color: root.text_color
        mCurrentTime: 102
        mTotalTime: 150
    }

    Rectangle{
        id: underPresure
        anchors.top: sdf.bottom
        anchors.left: root.left
        anchors.leftMargin: 16
        width: root.width / 4
        height: 8
        radius: 4
        color:((sdf.mMinTime > sdf.mCurrentTime) ? Colors.danger_light : "#737373")//"#737373"
    }

    Rectangle{
        id: overPresure
        anchors.top: sdf.bottom
        anchors.right: root.right
        anchors.rightMargin: 16
        width: root.width / 4
        height: 8
        radius: 4
        color:((sdf.mMaxTime < sdf.mCurrentTime) ? Colors.danger_light : "#737373")
    }

    Rectangle{
        id: normalPresure
        anchors.top: sdf.bottom
        anchors.right: overPresure.left
        anchors.left: underPresure.right
        height: 8
        radius: 4
        color:((sdf.mCurrentTime <= sdf.mMaxTime && sdf.mCurrentTime >= sdf.mMinTime) ? Colors.success_light : "#737373")
    }

    states: [
        State {
            name: "close"
//            PropertyChanges {
//                target: imgIcon
//                source: "qrc:/images/door_closed.svg"
//            }
//            PropertyChanges {
//                target: txtState
//                text: "CLOSE"
//            }
        },
        State {
            name: "open"
//            PropertyChanges {
//                target: imgIcon
//                source: "qrc:/images/door_open.svg"
//            }
//            PropertyChanges {
//                target: txtState
//                text: "OPEN"
//            }
        },
        State {
            name: "error"
//            PropertyChanges {
//                target: txtState
//                text: "ERROR"
//            }
        }
    ]
}
