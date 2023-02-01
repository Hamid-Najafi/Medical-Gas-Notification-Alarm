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
    property int type: 1
    property bool hasError : false
    property alias mWidth: root.width
    property alias mHeight: root.height
    property alias mName: txtHeader.text
    property alias mState: root.state
    property int mMin: 1
    property int mMax: 100
    property int mValue: 50
    property alias mSubHeader: txtSubHeader.text
    state: "close"
    property int iconSize: 160
    Image{
        id: img
        anchors.fill: parent
        source: root.type == 1 ?
                    ((root.hasError ? "qrc:/images/O2_error.png" : "qrc:/images/O2_ok.png")) :
                    (root.type == 2 ?
                         ((root.hasError ? "qrc:/images/N2O_error.png" : "qrc:/images/N2O_ok.png")) :
                         (root.type == 3 ?
                              ((root.hasError ? "qrc:/images/AIR_error.png" : "qrc:/images/AIR_ok.png")) :
                              (root.type == 4 ?
                                   ((root.hasError ? "qrc:/images/VAC_error.png" : "qrc:/images/VAC_ok.png")) :
                                   (""))))
    }

    Text{
        id: txtHeader
        anchors.left: root.left
        anchors.leftMargin: 16
        anchors.top: root.top
        anchors.topMargin: 10
        anchors.right: root.right
        anchors.rightMargin: 16
        height: 40
        font.family: "Cooper Hewitt"
        font.pixelSize: 24
        font.styleName: "Bold"
        font.weight: Font.ExtraBold
        color: root.text_color
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
    Text{
        id: txtSubHeader
        anchors.left: root.left
        anchors.leftMargin: 16
        anchors.top: txtHeader.bottom
        anchors.right: root.right
        anchors.rightMargin: 16
        horizontalAlignment: Text.AlignHCenter
        height: 30
        font.family: "Cooper Hewitt"
        font.pixelSize: 28
        font.styleName: "Thin"
        font.weight: Font.Bold
        fontSizeMode: Text.Fit
        color: Colors.text_dark
        verticalAlignment: Text.AlignVCenter
    }

    Text{
        id: txtState
        text: root.hasError ? "ERROR" : "NORMAL"
        anchors.left: root.left
        anchors.leftMargin: 16
        anchors.top: txtSubHeader.bottom
        anchors.right: root.right
        anchors.rightMargin: 16
        horizontalAlignment: Text.AlignHCenter
        height: 120
        font.family: "Cooper Hewitt"
        font.pixelSize: 30
        font.styleName: "Normal"
        font.weight: Font.Bold
        fontSizeMode: Text.Fit
        color: root.hasError ? Colors.red : Colors.text_dark
        verticalAlignment: Text.AlignVCenter
    }



//    Rectangle{
//        id: underPresure
//        anchors.top: sdf.bottom
//        anchors.left: root.left
//        anchors.leftMargin: 16
//        width: root.width / 4
//        height: 8
//        radius: 4
//        color:((sdf.mMinTime > sdf.mCurrentTime) ? Colors.danger_light : "#737373")//"#737373"
//    }

//    Rectangle{
//        id: overPresure
//        anchors.top: sdf.bottom
//        anchors.right: root.right
//        anchors.rightMargin: 16
//        width: root.width / 4
//        height: 8
//        radius: 4
//        color:((sdf.mMaxTime < sdf.mCurrentTime) ? Colors.danger_light : "#737373")
//    }

//    Rectangle{
//        id: normalPresure
//        anchors.top: sdf.bottom
//        anchors.right: overPresure.left
//        anchors.left: underPresure.right
//        height: 8
//        radius: 4
//        color:((sdf.mCurrentTime <= sdf.mMaxTime && sdf.mCurrentTime >= sdf.mMinTime) ? Colors.success_light : "#737373")
//    }

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
