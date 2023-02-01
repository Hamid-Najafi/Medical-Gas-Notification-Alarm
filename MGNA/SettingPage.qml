import QtQuick 2.10
import QtQuick.Layouts 1.0
import App 1.0
import Qt.labs.settings 1.0

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
    property alias mState: root.state
    property int setTime: 10
    property int setInterLockTime: 3
    property int mInterLockTime: 3
    property int setUlockTime: 3
    property int mUlockTime: 5
    property string pass: ""
    property int mTime: 30
    property int doorsCount: 3
    signal okClicked();
    signal cancelClicked();
    property int mMode: 1

    property bool isIn: false;
    // O2
    // $#################################
    property bool o2_isActive: false
    property string o2_header: "OXYGEN"
    property string o2_subHeader: "ICU RM 102,103,104"
    // N2O
    // $#################################
    property bool n2o_isActive: false
    property string n2o_header: "NITROUS OXIDE"
    property string n2o_subHeader: "ICU RM 102,103,104"
    // VAC
    // $#################################
    property bool vac_isActive: false
    property string vac_header: "VACUUM"
    property string vac_subHeader: "ICU RM 102,103,104"
    // AIR
    // $#################################
    property bool air_isActive: false
    property string air_header: "MEDIACAL AIR"
    property string air_subHeader: "ICU RM 102,103,104"
    // TIMER
    // $#################################
    property int timer_time: 300


    onMStateChanged: {
        //console.log("'"+root.mState+"'");
        if(root.mState == "password" && root.isIn){
            root.savePage();
        }


        if(root.mState != "password")
            root.isIn = true;
        else
            root.isIn = false;
    }

    onStateChanged: {
        //console.log(root.state);
    }

    state: "password"

    GridLayout{
        id: grdPassword
        rows: 3
        columns: 6
        anchors.fill: parent
        anchors.leftMargin: 65
        anchors.rightMargin: 65
        anchors.topMargin: 32
        anchors.bottomMargin: 32
        columnSpacing: 16
        rowSpacing: 16

        Rectangle{
            Layout.fillWidth : true
            Layout.columnSpan: 6
            height: 80
            color: Colors.transparent
            border.width: 2
            border.color: root.text_color
            radius: (Math.min(root.width,root.height) / 2)
            TextInput {
                id: txtPass
                maximumLength: 5
                font.family: "Cooper Hewitt"
                font.pixelSize: 24
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                echoMode: TextInput.Password
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.passwordEntered();
                }
                property string placeholderText: "Enter password here..."

                Text {
                    text: txtPass.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 24
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !txtPass.text && !txtPass.focus
                }
            }
        }

        Rectangle{
            width: 120
            height: 80
            color: "#01000000"
            Layout.row: 2
            Layout.column: 4
            border.color: Colors.gray
            border.width: 2
            radius: (Math.min(root.width,root.height) / 2)
            Text {
                text: "Cancel"
                anchors.centerIn: parent
                font.family: "Cooper Hewitt"
                font.pixelSize: 28
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
            MouseArea{
                anchors.fill: parent
                onClicked : {
                    root.cancelPage();
                }
            }
        }
        Rectangle{
            width: 120
            height: 80
            color: "#01000000"
            Layout.row: 2
            Layout.column: 3
            border.color: Colors.green
            border.width: 2
            radius: (Math.min(root.width,root.height) / 2)
            Text {
                text: "Ok"
                anchors.centerIn: parent
                font.family: "Cooper Hewitt"
                font.pixelSize: 28
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.green
            }
            MouseArea{
                anchors.fill: parent
                onClicked : {
                    if(root.pass == "9998"){
                        root.state = "door"
                    }
                    if(root.pass == "1234"){
                        root.state = "time"
                    }
                }
            }
        }
    }

    GridLayout{
        property bool isActive: root.o2_isActive

        id: grdO2
        rows: 3
        columns: 6
        anchors.fill: parent
        anchors.leftMargin: 75
        anchors.rightMargin: 75
        anchors.topMargin: 32
        anchors.bottomMargin: 32
        columnSpacing: 32
        rowSpacing: 32
        // Is Active
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth : true
            Layout.columnSpan: 1
            Text {
                text: "Is Active"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.fillWidth : true
            Layout.row: 1
            Layout.column: 2
            Layout.columnSpan: 5
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                radius: (Math.min(width,height) / 2)
                width: 48
                color: grdO2.isActive ? Colors.green : Colors.gray
                MouseArea{
                    anchors.fill: parent
                    onClicked : {
                        grdO2.isActive = !grdO2.isActive;
                    }
                }
            }
        }
        // Header
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "Header"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtO2Header
                text: root.o2_header
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter header..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }
        }
        // Sub Header
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 3
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "SubHeader"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 3
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtO2SubHeader
                text: root.o2_subHeader

                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter sub header..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }

        }
    }

    GridLayout{
        property bool isActive: root.n2o_isActive

        id: grdN2O
        rows: 3
        columns: 6
        anchors.fill: parent
        anchors.leftMargin: 75
        anchors.rightMargin: 75
        anchors.topMargin: 32
        anchors.bottomMargin: 32
        columnSpacing: 32
        rowSpacing: 32
        // Is Active
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth : true
            Layout.columnSpan: 1
            Text {
                text: "Is Active"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.fillWidth : true
            Layout.row: 1
            Layout.column: 2
            Layout.columnSpan: 5
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                radius: (Math.min(width,height) / 2)
                width: 48
                color: grdN2O.isActive ? Colors.green : Colors.gray
                MouseArea{
                    anchors.fill: parent
                    onClicked : {
                        grdN2O.isActive = !grdN2O.isActive;
                    }
                }
            }
        }
        // Header
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "Header"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtN2OHeader
                text : root.n2o_header
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter header..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }

        }
        // Sub Header
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 3
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "SubHeader"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 3
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtN2OSubHeader
                text: root.n2o_subHeader
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter sub header..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }

        }
    }

    GridLayout{
        property bool isActive: root.air_isActive

        id: grdAIR
        rows: 3
        columns: 6
        anchors.fill: parent
        anchors.leftMargin: 75
        anchors.rightMargin: 75
        anchors.topMargin: 32
        anchors.bottomMargin: 32
        columnSpacing: 32
        rowSpacing: 32
        // Is Active
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth : true
            Layout.columnSpan: 1
            Text {
                text: "Is Active"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.fillWidth : true
            Layout.row: 1
            Layout.column: 2
            Layout.columnSpan: 5
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                radius: (Math.min(width,height) / 2)
                width: 48
                color: grdAIR.isActive ? Colors.green : Colors.gray
                MouseArea{
                    anchors.fill: parent
                    onClicked : {
                        grdAIR.isActive = !grdAIR.isActive;
                    }
                }
            }
        }
        // Header
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "Header"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtAIRHeader
                text: root.air_header
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter header..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }

        }
        // Sub Header
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 3
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "SubHeader"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 3
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtAIRSubHeader
                text: root.air_subHeader
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter sub header..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }

        }
    }

    GridLayout{
        property bool isActive: root.vac_isActive

        id: grdVAC
        rows: 3
        columns: 6
        anchors.fill: parent
        anchors.leftMargin: 75
        anchors.rightMargin: 75
        anchors.topMargin: 32
        anchors.bottomMargin: 32
        columnSpacing: 32
        rowSpacing: 32
        // Is Active
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth : true
            Layout.columnSpan: 1
            Text {
                text: "Is Active"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.fillWidth : true
            Layout.row: 1
            Layout.column: 2
            Layout.columnSpan: 5
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                radius: (Math.min(width,height) / 2)
                width: 48
                color: grdVAC.isActive ? Colors.green : Colors.gray
                MouseArea{
                    anchors.fill: parent
                    onClicked : {
                        grdVAC.isActive = !grdVAC.isActive;
                    }
                }
            }
        }
        // Header
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "Header"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtVACHeader
                text: root.vac_header
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter header..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }

        }
        // Sub Header
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 3
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "SubHeader"
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 3
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtVACSubHeader
                text: root.vac_subHeader
                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter sub header..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }

        }
    }

    GridLayout{
        property int time: root.timer_time

        id: grdTimer
        rows: 3
        columns: 6
        anchors.fill: parent
        anchors.leftMargin: 75
        anchors.rightMargin: 75
        anchors.topMargin: 32
        anchors.bottomMargin: 32
        columnSpacing: 32
        rowSpacing: 32
        // Time
        // $#####################################
        Rectangle{
            width: 120
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillWidth : true
            Text {
                text: "Time(sec.)"
                anchors.fill: parent
                font.family: "Cooper Hewitt"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
                font.styleName: "Bold"
                font.weight: Font.ExtraBold
                color: Colors.gray
            }
        }
        Rectangle{
            width: 498
            height: 64
            color: "#01000000"
            Layout.row: 2
            Layout.column: 2
            Layout.columnSpan: 5
            Layout.fillWidth : true
            border.color: root.text_color
            border.width: 2
            radius: 4
            TextInput {
                id: txtTime
                text: root.timer_time
                validator: IntValidator{
                    bottom: 0
                    top: 9999
                }

                font.family: "Cooper Hewitt"
                font.pixelSize: 18
                font.styleName: "Bold"
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.ExtraBold
                color: root.text_color
                anchors.fill: parent
                anchors.margins: 8
                onAccepted: {
                    root.okClicked();
                }
                property string placeholderText: "Enter timer in second..."

                Text {
                    text: parent.placeholderText
                    font.family: "Cooper Hewitt"
                    font.pixelSize: 18
                    font.styleName: "Bold"
                    horizontalAlignment: TextInput.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: Font.ExtraBold
                    color: "#aaa"
                    anchors.fill: parent
                    anchors.margins: 8
                    visible: !parent.text && !parent.focus
                }
            }

        }
    }

    states: [
        State {
            name: "password"
            PropertyChanges {
                target: grdO2
                visible: false
            }
            PropertyChanges {
                target: grdN2O
                visible: false
            }
            PropertyChanges {
                target: grdAIR
                visible: false
            }
            PropertyChanges {
                target: grdVAC
                visible: false
            }
            PropertyChanges {
                target: grdTimer
                visible: false
            }
            PropertyChanges {
                target: grdPassword
                visible: true
            }
        },
        State {
            name: "o2"
            PropertyChanges {
                target: grdO2
                visible: true
            }
            PropertyChanges {
                target: grdN2O
                visible: false
            }
            PropertyChanges {
                target: grdAIR
                visible: false
            }
            PropertyChanges {
                target: grdVAC
                visible: false
            }
            PropertyChanges {
                target: grdTimer
                visible: false
            }
            PropertyChanges {
                target: grdPassword
                visible: false
            }
        },
        State {
            name: "n2o"
            PropertyChanges {
                target: grdO2
                visible: false
            }
            PropertyChanges {
                target: grdN2O
                visible: true
            }
            PropertyChanges {
                target: grdAIR
                visible: false
            }
            PropertyChanges {
                target: grdVAC
                visible: false
            }
            PropertyChanges {
                target: grdTimer
                visible: false
            }
            PropertyChanges {
                target: grdPassword
                visible: false
            }
        },
        State {
            name: "air"
            PropertyChanges {
                target: grdO2
                visible: false
            }
            PropertyChanges {
                target: grdN2O
                visible: false
            }
            PropertyChanges {
                target: grdAIR
                visible: true
            }
            PropertyChanges {
                target: grdVAC
                visible: false
            }
            PropertyChanges {
                target: grdTimer
                visible: false
            }
            PropertyChanges {
                target: grdPassword
                visible: false
            }
        },
        State {
            name: "vac"
            PropertyChanges {
                target: grdO2
                visible: false
            }
            PropertyChanges {
                target: grdN2O
                visible: false
            }
            PropertyChanges {
                target: grdAIR
                visible: false
            }
            PropertyChanges {
                target: grdVAC
                visible: true
            }
            PropertyChanges {
                target: grdTimer
                visible: false
            }
            PropertyChanges {
                target: grdPassword
                visible: false
            }
        },
        State {
            name: "time"
            PropertyChanges {
                target: grdO2
                visible: false
            }
            PropertyChanges {
                target: grdN2O
                visible: false
            }
            PropertyChanges {
                target: grdAIR
                visible: false
            }
            PropertyChanges {
                target: grdVAC
                visible: false
            }
            PropertyChanges {
                target: grdTimer
                visible: true
            }
            PropertyChanges {
                target: grdPassword
                visible: false
            }
        }
    ]

    function savePage(){
        root.o2_header = txtO2Header.text;
        root.o2_isActive = grdO2.isActive;
        root.o2_subHeader = txtO2SubHeader.text;

        root.n2o_header = txtN2OHeader.text;
        root.n2o_isActive = grdN2O.isActive;
        root.n2o_subHeader = txtN2OSubHeader.text;

        root.air_header = txtAIRHeader.text;
        root.air_isActive = grdAIR.isActive;
        root.air_subHeader = txtAIRSubHeader.text;

        root.vac_header = txtVACHeader.text;
        root.vac_isActive = grdVAC.isActive;
        root.vac_subHeader = txtVACSubHeader.text;

        root.timer_time = txtTime.text;
    }


    function passwordEntered(){
        //root.mState = "password"

        if(txtPass.text == "1234"){
            root.state = "o2";
            txtPass.text = "";
            txtPass.focus = false;
        }
    }

    function cancelPage(){
        root.mState = "password"
        txtPass.text = "";
        txtPass.focus = false;
        root.cancelClicked();
    }

}
