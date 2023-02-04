import QtQuick 2.10
import QtQuick.Window 2.10
import QtGraphicalEffects 1.0
import QtQuick.VirtualKeyboard 2.4
import com.nourbakhsh.IOReader 1.0
import com.nourbakhsh.RNElapsedTimer 1.0
import com.nourbakhsh.ModbusController 1.0
import com.nourbakhsh.GPIO 1.0
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

    property int gpio_number_buzzer: 20
    property int gpio_number_relay: 3
    property int gpio_number_input1: 0
    property int gpio_number_input2: 6
    property int gpio_number_input3: 11
    property int gpio_number_input4: 12
    property bool isInited: false

    property bool isMuted: false
    property bool hasAlarm: false
    property bool fullMuted: false

    width: 800
    height: 480
    visible: true

    RNElapsedTimer{
        id: muteTimer

    }
    Timer{
        id: timerBell
        interval: 500
        property bool lastActive: false
        running: true;
        repeat: true
        onTriggered: {

//            console.log(imgBell.isActive);
//            console.log(root.isMuted);
//            console.log(root.fullMuted);

            if((!imgBell.isActive && !root.hasAlarm )){
                timerBell.lastActive = false;
                modbusController.setCoilWithId(0,false);
                gpio.gpio_set_value(root.gpio_number_buzzer,false);
                modbusController.setCoilWithId(1,false);
                gpio.gpio_set_value(root.gpio_number_relay,false);
//                console.log("!imgBell.isActive");
                return;
            }
            if((root.hasAlarm || imgBell.isActive) && (!root.isMuted && !root.fullMuted)){
                timerBell.lastActive = !timerBell.lastActive;
                modbusController.setCoilWithId(0,timerBell.lastActive);
                gpio.gpio_set_value(root.gpio_number_buzzer,timerBell.lastActive);
                modbusController.setCoilWithId(1,true);
                gpio.gpio_set_value(root.gpio_number_relay,true);
//                console.log("imgBell.isActive && (!root.isMuted || !root.fullMuted)");
                return;

            }
            if((imgBell.isActive || root.hasAlarm) && (root.isMuted  || root.fullMuted) ){
                timerBell.lastActive = false;
                modbusController.setCoilWithId(0,timerBell.lastActive);
                gpio.gpio_set_value(root.gpio_number_buzzer,timerBell.lastActive);
                modbusController.setCoilWithId(1,false);
                gpio.gpio_set_value(root.gpio_number_relay,false);
//                console.log("imgBell.isActive && (root.isMuted  || root.fullMuted) ");
                return;
            }

        }
    }

    Timer {
        interval: 50;
        running: true;
        repeat: true
        onTriggered: {
            root.setHasAlarm();


            if(muteTimer.elapsed > (setting.timer_time * 1000) && root.isMuted ){
                root.isMuted = false;
//                console.log("muteTimer.elapsed > (setting.timer_time * 1000) && root.isMuted ");
                muteTimer.stop();
            }

//            if(root.hasAlarm && (!root.isMuted && !root.fullMuted)){
//                modbusController.setCoilWithId(1,true);
//            }
//            else{
//                modbusController.setCoilWithId(1,false);
//            }


            if(!root.isInited) return;
            let in1 = gpio.gpio_get_value(root.gpio_number_input1);
            let in2 = gpio.gpio_get_value(root.gpio_number_input2);
            let in3 = gpio.gpio_get_value(root.gpio_number_input3);
            let in4 = gpio.gpio_get_value(root.gpio_number_input4);
            modbusController.setDiscreteInputWithId(1,in1);
            dashboard.o2_hasError = in1;
            modbusController.setDiscreteInputWithId(3,in2);
            dashboard.n2o_hasError = in2;
            modbusController.setDiscreteInputWithId(5,in3);
            dashboard.air_hasError = in3;
            modbusController.setDiscreteInputWithId(7,in4);
            dashboard.vac_hasError = in4;
        }
    }

    ModbusController{
        id: modbusController
        Component.onCompleted: {
            console.log(isConnected);
        }

        onCoilUpdated: function(id,val){
            if(id == 0 && root.isInited){
                gpio.gpio_set_value(root.gpio_number_buzzer,val);
            }
            if(id == 1 && root.isInited){
                gpio.gpio_set_value(root.gpio_number_relay,val);
            }
        }
        onIsConnectedChanged: {
            console.log(isConnected);
        }
    }

    GPIO{
        id: gpio
        Component.onCompleted: {
            // Buzzer
            gpio_export(root.gpio_number_buzzer);
            gpio_set_dir(root.gpio_number_buzzer,1);
            // Relay
            gpio_export(root.gpio_number_relay);
            gpio_set_dir(root.gpio_number_relay,1);
            // Input 1
            gpio_export(root.gpio_number_input1);
            gpio_set_dir(root.gpio_number_input1,0);
            // Input 2
            gpio_export(root.gpio_number_input2);
            gpio_set_dir(root.gpio_number_input2,0);
            // Input 3
            gpio_export(root.gpio_number_input3);
            gpio_set_dir(root.gpio_number_input3,0);
            // Input 4
            gpio_export(root.gpio_number_input4);
            gpio_set_dir(root.gpio_number_input4,0);

            root.isInited = true;
        }
    }

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
        onO2_isActiveChanged: {
            modbusController.setDiscreteInputWithId(0,setting.o2_isActive);
        }
        onN2o_isActiveChanged: {
            modbusController.setDiscreteInputWithId(2,setting.n2o_isActive);
        }
        onAir_isActiveChanged: {
            modbusController.setDiscreteInputWithId(4,setting.air_isActive);
        }
        onVac_isActiveChanged: {
            modbusController.setDiscreteInputWithId(6,setting.vac_isActive);
        }
        Component.onCompleted: {
            modbusController.setDiscreteInputWithId(0,setting.o2_isActive);
            modbusController.setDiscreteInputWithId(2,setting.n2o_isActive);
            modbusController.setDiscreteInputWithId(4,setting.air_isActive);
            modbusController.setDiscreteInputWithId(6,setting.vac_isActive);
        }

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

    InfoPage{
        id: info
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: imgIcon.bottom
        anchors.topMargin: 16
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 56 + 16 + 16
        visible: root.mState == 3
        clip: true
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
        anchors.right: root.mState == 3 ? imgHome.left : parent.right
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
        visible: root.mState != 3
        onMClicked: {
            root.mState = 3;
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
//            modbusController.setCoilWithId(0,isActive);
//            modbusController.setCoilWithId(1,isActive);
        }
    }
    IconButtonHold{
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
//            isActive = !isActive;
            muteTimer.stop();
            muteTimer.start();
            console.log("Mute");
            root.isMuted = true;
            root.fullMuted = false;
        }
        onMHolded: {
            //muteTimer.start();
            console.log("fullMute");
            root.isMuted = true;
            root.fullMuted = true;
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

    function setHasAlarm(){
        let hasError = (dashboard.o2_isActive && dashboard.o2_hasError) ||
                        (dashboard.n2o_isActive&& dashboard.n2o_hasError) ||
                        (dashboard.vac_isActive && dashboard.vac_hasError) ||
                        (dashboard.air_isActive && dashboard.air_hasError);
        root.hasAlarm = hasError;
        if(!hasError && !imgBell.isActive){
            root.isMuted = false;
            root.fullMuted = false;
        }
    }

}
