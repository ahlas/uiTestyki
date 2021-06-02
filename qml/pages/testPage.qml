import QtQuick 2.15
import QtQuick.Controls 2.15
import "../controls"


Item {
    id: item1
    property bool communicationFlag: false

    Rectangle {
        id: testBg
        width: 1200
        height: 800
        color: "#282c34"
        anchors.fill: parent

        Label {
            id: label
            x: 342
            width: 116
            height: 43
            color: "#ffffff"
            text: qsTr("Test Page")
            anchors.right: parent.right
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 60
            anchors.topMargin: 20
            font.bold: false
            font.pointSize: 16
        }


        Rectangle {
            id: comArea
            x: 8
            y: 8
            width: 280
            height: 87
            color: "#00000000"

            Rectangle {
                id: subComArea
                x: 0
                width: 235
                height: 60
                color: "#1c1d20"
                radius: 10
                anchors.top: comLabel.bottom
                anchors.topMargin: -8

                CustomTextField
                {
                    id: portField
                    x: 19
                    y: 13
                    width: 123
                    height: 35
                    anchors.left: parent.left
                    anchors.top: parent.top
                    placeholderTextColor: "#313339"
                    colorDefault: "#a1a6ae"
                    colorMouseOver: "#c8ccd4"
                    colorOnFocus: "#e0e2e7"
                    anchors.topMargin: 12
                    anchors.leftMargin: 8
                    placeholderText: qsTr("Write Port Name")
                }

                CustomButton
                {
                    id: communicationBtn
                    x: 162
                    width: 89
                    height: 35
                    text: qsTr("Start")
                    anchors.left: portField.right
                    anchors.top: parent.top
                    colorDefault: "#4891d9"
                    anchors.topMargin: 12
                    anchors.leftMargin: 6
                    onClicked: {

                        if(communicationFlag === false)
                        {
                            communicationFlag = true
                        }
                        else
                        {
                            communicationFlag = false
                        }
                        backendCommunication.startCommunication(communicationFlag)
                    }
                }
            }


            Label {
                id: comLabel
                x: 104
                width: 67
                height: 16
                color: "#798ac6"
                text: qsTr("COM")
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.Bold
                clip: true
                anchors.topMargin: 5
                font.pointSize: 12
                anchors.horizontalCenter: subComArea.horizontalCenter
            }

        }

        CustomButton {
            id: armBtn
            x: 33
            width: 89
            height: 35
            text: qsTr("Arm")
            anchors.left: portField.right
            anchors.top: parent.top
            anchors.topMargin: 149
            anchors.leftMargin: 6
            colorDefault: "#4891d9"
            onClicked: {
                backendCommunication.writeMessageLogFunc("TEST")
            }

        }

        Rectangle {
            id: writeArea
            x: 400
            y: 637
            width: 325
            height: 140
            color: "#00000000"
            border.color: "#00000000"
            anchors.right: readArea.left
            anchors.bottom: parent.bottom
            anchors.rightMargin: 30
            anchors.bottomMargin: 30
            Rectangle {
                id: subWriteArea
                x: 2
                width: 317
                height: 129
                color: "#1c1d20"
                radius: 20
                border.color: "#4891d9"
                anchors.top: writeLabel.bottom
                anchors.topMargin: -25

                CustomTextEditor {
                    id: writeCustomArea
                    x: 54
                    y: 42
                    width: 300
                    height: 115
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    enabled: true
                }
            }

            Label {
                id: writeLabel
                x: 104
                width: 67
                height: 21
                color: "#eff0f1"
                text: qsTr("Write")
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenterOffset: 0
                font.weight: Font.Bold
                clip: true
                font.pointSize: 14
                anchors.topMargin: 5
                anchors.horizontalCenter: subWriteArea.horizontalCenter
            }
        }

        Rectangle {
            id: readArea
            x: 750
            y: 637
            width: 325
            height: 140
            color: "#00000000"
            border.color: "#00000000"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 30
            anchors.bottomMargin: 30
            Rectangle {
                id: subReadArea
                x: 2
                width: 317
                height: 129
                color: "#1c1d20"
                radius: 20
                border.color: "#4891d9"
                anchors.top: readLabel.bottom
                anchors.topMargin: -25
                CustomTextEditor {
                    id: readCustomArea
                    x: 54
                    y: 42
                    width: 300
                    height: 115
                    anchors.verticalCenter: parent.verticalCenter
                    enabled: true
                    anchors.horizontalCenterOffset: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Label {
                id: readLabel
                x: 104
                width: 67
                height: 21
                color: "#eff0f1"
                text: qsTr("Read")
                anchors.top: parent.top
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.Bold
                clip: true
                font.pointSize: 14
                anchors.horizontalCenterOffset: 0
                anchors.topMargin: 5
                anchors.horizontalCenter: subReadArea.horizontalCenter
            }
        }

        Rectangle {
            id: modeGroup
            x: 33
            width: 263
            height: 55
            color: "#00000000"
            anchors.top: armBtn.bottom
            anchors.topMargin: 20

            ComboBox {
                id: modeCmb
                y: 15
                width: 138
                height: 26
                anchors.left: parent.left
                anchors.leftMargin: 0
                textRole: ""
                currentIndex: 0
                model:["GUIDED","AUTO","STABILIZE","LOITER"]
            }

            CustomButton {
                id: modeBtn
                x: 157
                y: -101
                width: 89
                height: 35
                text: qsTr("Mode Active")
                anchors.verticalCenter: modeCmb.verticalCenter
                anchors.left: portField.right
                anchors.top: parent.top
                anchors.topMargin: 9
                anchors.leftMargin: 6
                colorDefault: "#4891d9"
            }
        }

        CustomButton {
            id: disarmBtn
            width: 89
            height: 35
            text: qsTr("DisArm")
            anchors.left: armBtn.right
            anchors.top: parent.top
            anchors.topMargin: 149
            anchors.leftMargin: 20
            colorDefault: "#4891d9"
        }
    }

    Connections
    {
        target: backendCommunication

        function onSetCommunicationState(communicationState)
        {
            if(communicationState === true)
            {
                label.text = "Started Communication"
                communicationBtn.text = "Close"
                communicationBtn.colorDefault   =	"#b02d34"
                communicationBtn.colorMouseOver =	"#d03840"
                communicationBtn.colorPressed   =	"#8d252b"
            }
            else
            {
                label.text = "Closed Communication"
                communicationBtn.text = "Start"
                communicationBtn.colorDefault   =	"#4891d9"
                communicationBtn.colorMouseOver =	"#55aaff"
                communicationBtn.colorPressed   =	"#3f7ebd"
            }
        }

        //Gonderilen komutlar ekrana yazdırılıyor.
        function onWriteMessageLog(byteArrayList)
        {
            writeCustomArea.setText = byteArrayList +"\n"+writeCustomArea.getText
        }

    }

    Rectangle {
        id: takeOffGroup
        x: 32
        y: 261
        width: 245
        height: 60
        color: "#00000000"
        radius: 10
        border.color: "#00000000"
        anchors.top: comLabel1.bottom
        anchors.topMargin: -8
        CustomTextField {
            id: takeOffField
            x: 19
            y: 13
            width: 129
            height: 35
            anchors.left: parent.left
            anchors.top: parent.top
            colorMouseOver: "#c8ccd4"
            placeholderText: qsTr("Write TakeOff Value")
            anchors.topMargin: 12
            placeholderTextColor: "#313339"
            anchors.leftMargin: 0
            colorOnFocus: "#e0e2e7"
            colorDefault: "#a1a6ae"
            validator: IntValidator {bottom: 1; top: 100}
        }

        CustomButton {
            id: takeOffBtn
            x: 162
            width: 96
            height: 35
            text: qsTr("takeOffActivate")
            anchors.left: takeOffField.right
            anchors.top: parent.top
            anchors.topMargin: 12
            anchors.leftMargin: 6
            colorDefault: "#4891d9"
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:800;width:1100}
}
##^##*/
