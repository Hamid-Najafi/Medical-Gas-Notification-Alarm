import QtQuick 2.10
import QtGraphicalEffects 1.0
import com.nourbakhsh.IOReader 1.0
import com.nourbakhsh.RNElapsedTimer 1.0
import Qt.labs.settings 1.0
import App 1.0

Item {
    id: root
    width: 800
    height: 320

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

    Component.onCompleted: {
        root.calcPositions();
    }

    onO2_isActiveChanged: {
        root.calcPositions();
    }
    onN2o_isActiveChanged: {
        root.calcPositions();
    }
    onAir_isActiveChanged: {
        root.calcPositions();
    }
    onVac_isActiveChanged: {
        root.calcPositions();
    }


    GasBoxVector{
        id: oxygen
        anchors.top: parent.top
        anchors.topMargin:  (root.height - mHeight) / 2
        mWidth: root.width / 4
        mHeight: 260
        mName: root.o2_header
        mSubHeader: root.o2_subHeader
        mMin: 40
        mMax: 100
        mValue: 56
        visible: root.o2_isActive
        text_color: Colors.gradient_top_dark
    }

    GasBoxVector{
        id: nitrousOxide
        anchors.top: parent.top
        anchors.topMargin: (root.height - mHeight) / 2
        mWidth: root.width / 4
        mHeight: 260
        mName: root.n2o_header
        mSubHeader: root.n2o_subHeader
        mMin: 40
        mMax: 100
        mValue: 56
        type: 2
        visible: root.n2o_isActive
        text_color: Colors.text_dark
    }
    GasBoxVector{
        id: medicalAir
        anchors.top: parent.top
        anchors.topMargin:  (root.height - mHeight) / 2
        mWidth: root.width / 4
        mHeight: 260
        mName: root.air_header
        mSubHeader: root.air_subHeader
        mMin: 40
        mMax: 100
        mValue: 56
        type: 3
        visible: root.air_isActive
        text_color: Colors.text_dark
    }
    GasBoxVector{
        id: vacuum
        anchors.top: parent.top
        anchors.topMargin:  (root.height - mHeight) / 2
        mWidth: root.width / 4
        mHeight: 260
        mName: root.vac_header
        mSubHeader: root.vac_subHeader
        mMin: 40
        mMax: 100
        mValue: 56
        hasError: true
        type: 4
        visible: root.vac_isActive
        text_color: Colors.gradient_top_dark
    }

    function calcPositions(){
        let total = (root.o2_isActive? 1 : 0) +
            (root.n2o_isActive? 1 : 0) +
            (root.vac_isActive? 1 : 0) +
            (root.air_isActive? 1 : 0) ;
        let start = 0;
        let width = root.width / total;
        let margin = (width - (root.width / 4)) / 2;
        if(root.o2_isActive){
            oxygen.x = start++ * width + margin;
        }
        if(root.n2o_isActive){
            nitrousOxide.x = start++ * width + margin;
        }
        if(root.air_isActive){
            medicalAir.x = start++ * width + margin;
        }
        if(root.vac_isActive){
            vacuum.x = start * width + margin;
        }
    }
}
