import QtQuick 2.15
import QtQuick.Controls 2.15
import QtMultimedia 5.0

Item {
    Rectangle {
        id: rectangle
        color: "#282c34"
        anchors.fill: parent

        Label {
            id: label
            x: 342
            y: 219
            width: 116
            height: 43
            color: "#ffffff"
            text: qsTr("Admin Page")
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: false
            font.pointSize: 16
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}
}
##^##*/
