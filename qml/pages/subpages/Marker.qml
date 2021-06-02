import QtQuick 2.0
import QtLocation 5.11

MapQuickItem {
    id: marker
    property alias text: txt.text
    sourceItem: Rectangle {
        width: 36
        height: 65
        color: "transparent"
        Image {
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
