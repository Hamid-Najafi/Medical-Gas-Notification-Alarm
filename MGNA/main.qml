import QtQuick 2.10
import QtQuick.Window 2.10
import QtGraphicalEffects 1.0
import QtQuick.VirtualKeyboard 2.4
import com.nourbakhsh.IOReader 1.0
import com.nourbakhsh.RNElapsedTimer 1.0
import Qt.labs.settings 1.0
import App 1.0

Window {
    id: root
    property color background_color: Colors.background
    property color text_element_color: Colors.gradient_top_dark
    property color text_color: Colors.text_dark
    property string currentPage: "Dashboard"
    property bool isDark : true
    property int mState: 1

    width: 800
    height: 480
    visible: true

    onMStateChanged: {
        root.pageChanged();
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: root.height
        width: root.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: root.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }



    Settings {
        id: settings
        property string theme: "dark"
        // O2
        // $#################################
        property alias o2_isActive: setting.o2_isActive
        property alias o2_header: setting.o2_header
        property alias o2_subHeader: setting.o2_subHeader
        // N2O
        // $#################################
        property alias n2o_isActive: setting.n2o_isActive
        property alias n2o_header: setting.n2o_header
        property alias n2o_subHeader: setting.n2o_subHeader
        // VAC
        // $#################################
        property alias vac_isActive: setting.vac_isActive
        property alias vac_header: setting.vac_header
        property alias vac_subHeader: setting.vac_subHeader
        // AIR
        // $#################################
        property alias air_isActive: setting.air_isActive
        property alias air_header: setting.air_header
        property alias air_subHeader: setting.air_subHeader
        // TIMER
        // $#################################
        property alias timer_time: setting.timer_time
        //        property alias time: setting.setTime
        //        property alias interlockTime: setting.mInterLockTime
        //        property alias unlockTime: setting.mUlockTime
        property alias state: root.mState
        //        property alias doors: setting.doorsCount

    }


    Rectangle{
        id: rectBackground
        anchors.fill: parent
        color: "#2e2e2e" //root.background_color
        Image {
            id: name
            anchors.fill: parent
            source: "qrc:/images/background.png"
        }
    }

    Image {
        id: imgIcon
        width: 120
        height: 56
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.top: parent.top
        anchors.topMargin: 16
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/44.png"
        sourceSize: Qt.size( 120, 56 )
        Image {
            id: imgIconInner
            source: parent.source
            width: 0
            height: 0
        }

    }

    Text{
        id: txtHeader
        width: 120
        height: 56
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.top: parent.top
        anchors.topMargin: 16
        text: root.currentPage
        font.family: "Cooper Hewitt"
        font.pixelSize: 24
        font.styleName: "Bold"
        font.weight: Font.ExtraBold
        color: root.text_color
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Dashboard {
        id: dashboard
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: imgIcon.bottom
        anchors.topMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 56 + 16 + 16
        o2_isActive: setting.o2_isActive
        o2_header: setting.o2_header
        o2_subHeader: setting.o2_subHeader
        // N2O
        // $#################################
        n2o_isActive: setting.n2o_isActive
        n2o_header: setting.n2o_header
        n2o_subHeader: setting.n2o_subHeader
        // VAC
        // $#################################
        vac_isActive: setting.vac_isActive
        vac_header: setting.vac_header
        vac_subHeader: setting.vac_subHeader
        // AIR
        // $#################################
        air_isActive: setting.air_isActive
        air_header: setting.air_header
        air_subHeader: setting.air_subHeader
        visible: root.mState == 1
    }
    SettingPage{
        id: setting
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: imgIcon.bottom
        anchors.topMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 56 + 16 + 16
        mState: "password"
        visible: root.mState == 2
        clip: true
        onOkClicked: {

            root.mState = 1
            setting.mState = "password"
            setting.pass = "";
        }
        onCancelClicked: {
            root.mState = 1
        }
    }

    //    Rectangle{
    //        id: rectHalo
    //        height: 56 + 16 + 16
    //        anchors.right: parent.right
    //        anchors.left: parent.left
    //        anchors.bottom: parent.bottom
    //        color: "#a0111111"
    //    }

    IconButton{
        id: imgSetting
        mWidth: 56
        mHeight: 56
        mColor: Colors.text_dark
        mSource: "qrc:/images/settings.svg"
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        visible: root.mState != 2
        onMClicked: {
            root.mState = 2
        }
    }


    //    Image {
    //        id: imgSetting
    //        width: 56
    //        height: 56
    //        anchors.right: parent.right
    //        anchors.rightMargin: 16
    //        anchors.bottom: parent.bottom
    //        anchors.bottomMargin: 16
    //        fillMode: Image.PreserveAspectFit
    //        source: "qrc:/images/setting.svg"
    //        sourceSize: Qt.size( 56, 56 )
    //        visible: root.mState != 2
    //        Image {
    //            id: imgSettingInner
    //            source: parent.source
    //            width: 0
    //            height: 0
    //        }
    //        MouseArea
    //        {
    //            anchors.fill: parent
    //            onClicked: {
    //                root.mState = 2
    //            }

    //        }
    //    }
    //    ColorOverlay{
    //        visible: root.mState != 2
    //        anchors.fill: imgSetting
    //        source: imgSetting
    //        color: Colors.text_dark
    //    }
    IconButton{
        id: imgHome
        mWidth: 56
        mHeight: 56
        anchors.right: parent.right
        anchors.rightMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mSource: "qrc:/images/dashboard.svg"
        visible: root.mState != 1
        onMClicked: {
            root.mState = 1
            setting.mState = "password"
            setting.pass = "";
        }
    }

    IconButton{
        id: imgInfo
        mWidth: 56
        mHeight: 56
        anchors.right: imgHome.left
        anchors.rightMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mSource: "qrc:/images/info.svg"
        onMClicked: {
        }
    }
    //    Image {
    //        id: imgHome
    //        width: 56
    //        height: 56
    //        anchors.right: parent.right
    //        anchors.rightMargin: 16
    //        anchors.bottom: parent.bottom
    //        anchors.bottomMargin: 16
    //        fillMode: Image.PreserveAspectFit
    //        source: "qrc:/images/home.svg"
    //        visible: root.mState != 1
    //        sourceSize: Qt.size( 56, 56 )
    //        Image {
    //            id: imgHomeInner
    //            source: parent.source
    //            width: 0
    //            height: 0
    //        }
    //        MouseArea
    //        {
    //            anchors.fill: parent
    //            onClicked: {
    //                root.mState = 1
    //                setting.mState = "password"
    //                setting.pass = "";
    //            }

    //        }
    //    }
    //    ColorOverlay{
    //        anchors.fill: imgHome
    //        visible: root.mState != 1
    //        source: imgHome
    //        color: Colors.text_dark
    //    }
    IconButton{
        id: imgBell
        mWidth: 56
        mHeight: 56
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mActiveColor: Colors.red
        mSource: "qrc:/images/bell.svg"
        visible: root.mState == 1
        onMClicked: {
            isActive = !isActive;
        }
    }
    IconButton{
        id: imgMute
        mWidth: 56
        mHeight: 56
        anchors.left: imgBell.right
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mActiveColor: Colors.gray
        mSource: "qrc:/images/mute.svg"
        visible: root.mState == 1
        onMClicked: {
            isActive = !isActive;
        }
    }

    IconButton{
        id: imgO2
        mWidth: 56
        mHeight: 56
        anchors.left: parent.left
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mActiveColor: Colors.gray
        mSource: "qrc:/images/o2.png"
        visible: root.mState == 2 && setting.mState != "password"
        isActive: setting.mState == "o2"
        onMClicked: {
            setting.mState = "o2";
            //isActive = !isActive;
        }
    }
    IconButton{
        id: imgN2O
        mWidth: 56
        mHeight: 56
        anchors.left: imgO2.right
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mActiveColor: Colors.gray
        mSource: "qrc:/images/n2o.png"
        visible: root.mState == 2 && setting.mState != "password"
        isActive: setting.mState == "n2o"
        onMClicked: {
            setting.mState = "n2o";
        }
    }
    IconButton{
        id: imgAIR
        mWidth: 56
        mHeight: 56
        anchors.left: imgN2O.right
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mActiveColor: Colors.gray
        mSource: "qrc:/images/air.png"
        visible: root.mState == 2 && setting.mState != "password"
        isActive: setting.mState == "air"
        onMClicked: {
            setting.mState = "air";
        }
    }
    IconButton{
        id: imgVAC
        mWidth: 56
        mHeight: 56
        anchors.left: imgAIR.right
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mActiveColor: Colors.gray
        mSource: "qrc:/images/vac.png"
        visible: root.mState == 2 && setting.mState != "password"
        isActive: setting.mState == "vac"
        onMClicked: {
            setting.mState = "vac";
        }
    }
    IconButton{
        id: imgTimer
        mWidth: 56
        mHeight: 56
        anchors.left: imgVAC.right
        anchors.leftMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 16
        mColor: Colors.text_dark
        mActiveColor: Colors.gray
        mSource: "qrc:/images/time.svg"
        visible: root.mState == 2 && setting.mState != "password"
        isActive: setting.mState == "time"
        onMClicked: {
            setting.mState = "time";
        }
    }
//    Image {
//        id: imgMute
//        width: 56
//        height: 56
//        anchors.right: imgSetting.left
//        anchors.rightMargin: 16
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 16
//        fillMode: Image.PreserveAspectFit
//        source: "qrc:/images/mute.svg"
//        sourceSize: Qt.size( 56, 56 )
//        Image {
//            id: imgMuteInner
//            source: parent.source
//            width: 0
//            height: 0
//        }
//        MouseArea
//        {
//            //            anchors.fill: parent
//            //            onClicked: {
//            //                root.mState = 2
//            //            }

//        }
//    }
//    ColorOverlay{
//        anchors.fill: imgMute
//        source: imgMute
//        color: "#737373"
//    }

//    Image {
//        id: imgChart
//        width: 56
//        height: 56
//        anchors.right: imgMute.left
//        anchors.rightMargin: 16
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 16
//        fillMode: Image.PreserveAspectFit
//        source: "qrc:/images/chart.svg"
//        sourceSize: Qt.size( 56, 56 )
//        Image {
//            id: imgChartInner
//            source: parent.source
//            width: 0
//            height: 0
//        }
//        MouseArea
//        {
//            //            anchors.fill: parent
//            //            onClicked: {
//            //                root.mState = 2
//            //            }

//        }
//    }
//    ColorOverlay{
//        anchors.fill: imgChart
//        source: imgChart
//        color: "#737373"
//    }

//    Image {
//        id: imgInfo
//        width: 56
//        height: 56
//        anchors.right: imgChart.left
//        anchors.rightMargin: 16
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 16
//        fillMode: Image.PreserveAspectFit
//        source: "qrc:/images/info.svg"
//        sourceSize: Qt.size( 56, 56 )
//        Image {
//            id: imgInfoInner
//            source: parent.source
//            width: 0
//            height: 0
//        }
//        MouseArea
//        {
//            //            anchors.fill: parent
//            //            onClicked: {
//            //                root.mState = 2
//            //            }

//        }
//    }
//    ColorOverlay{
//        anchors.fill: imgInfo
//        source: imgInfo
//        color: Colors.text_dark
//    }


//    Image {
//        id: imgAlarm
//        width: 56
//        height: 56
//        anchors.right: imgInfo.left
//        anchors.rightMargin: 16
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 16
//        fillMode: Image.PreserveAspectFit
//        source: "qrc:/images/alarm.svg"
//        sourceSize: Qt.size( 56, 56 )
//        Image {
//            id: imgAlarmInner
//            source: parent.source
//            width: 0
//            height: 0
//        }
//        MouseArea
//        {
//            //            anchors.fill: parent
//            //            onClicked: {
//            //                root.mState = 2
//            //            }

//        }
//    }
//    ColorOverlay{
//        anchors.fill: imgAlarm
//        source: imgAlarm
//        color: Colors.danger_light
//    }

    function pageChanged(){
        txtHeader.text = root.mState == 1 ? "Dashboard" :
                                            ( root.mState == 2 ? "Settings" : "" )
    }

}
