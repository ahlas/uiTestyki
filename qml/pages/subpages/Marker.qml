import QtQuick 2.0
import QtLocation 5.11

MapQuickItem {
    id: marker
    property alias text: txt.text
    property var count:0
    property var leftMarginValue:12

    sourceItem: Rectangle {
        width: 36
        height: 65
        color: "transparent"
        Image {
            id:imgNavigation
            width: 36
            height: 65
            anchors.fill: parent
            anchors.bottom: parent
            anchors.bottomMargin: 20
            source: "../../../images/svg_images/navigationIcon.svg"
            sourceSize: Qt.size(parent.width, parent.height)           
        }
        Text {
            id: txt
            anchors.fill: parent
            anchors.topMargin: 5
            anchors.leftMargin: leftMarginValue
            width: 42
            height: 25
            color: "#181c20"
            font.bold: true
            font.pointSize: 13
        }
        Component.onCompleted:
        {
            if(count ===1)
                imgNavigation.visible=false
            else
                imgNavigation.visible=true
            if(count >10)
                leftMarginValue=8
            else
                leftMarginValue=12

        }
    }
    opacity: 1.0
    anchorPoint: Qt.point(sourceItem.width/2, sourceItem.height/2)
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
