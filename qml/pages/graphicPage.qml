import QtQuick 2.11
import QtQuick.Controls 2.4
import QtCharts 2.0
import QtGraphicalEffects 1.0

Rectangle {
    visible: true
    color: "#1c1d20"
    radius: 0

    Rectangle{
        visible: true
        radius: 40
        anchors.fill: parent
        ChartView {
            title: "IMU"
            anchors.fill: parent
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            titleColor: "#181c20"
            backgroundColor: "#ffffff"
            antialiasing: true

            LineSeries {
                name: "accelerometer X"
                pointLabelsFont.styleName: "Bold"
                pointLabelsFont.bold: true
                XYPoint { x: 0; y: 0 }
                XYPoint { x: 1.1; y: 2.1 }
                XYPoint { x: 1.9; y: 3.3 }
                XYPoint { x: 2.1; y: 2.1 }
                XYPoint { x: 2.9; y: 4.9 }
                XYPoint { x: 3.4; y: 3.0 }
                XYPoint { x: 4.1; y: 3.3 }
            }
            LineSeries {
                name: "accelerometer Y"
                pointLabelsFont.styleName: "Bold"
                pointLabelsFont.bold: true
                XYPoint { x: 0; y: 0 }
                XYPoint { x: 2.1; y: 2.1 }
                XYPoint { x: 1.9; y: 4.3 }
                XYPoint { x: 3.1; y: 2.1 }
                XYPoint { x: 2.1; y: 4.9 }
                XYPoint { x: 3.3; y: 3.0 }
                XYPoint { x: 4.5; y: 3.3 }
            }
        }
    }

}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:800}
}
##^##*/
