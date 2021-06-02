import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    property string getText: textArea.text
    property string setText: ""
    property color backgroundColor : "#a1a6ae"
    property color textAreaFontColor : "#000000"
    property color selectionTextColor: "#1c1d20"

    Rectangle {
        id: rectangle
        color:backgroundColor          //"#2c313c"
        anchors.fill: parent
        radius: 20

        Flickable {
            id: flickable
            anchors.fill: parent
            clip: true

            TextArea.flickable: TextArea{
                id: textArea
                padding: 10
                wrapMode: Text.WordWrap
                placeholderTextColor: "#f6fbff"
                textFormat: Text.AutoText
                selectByMouse: true
                selectedTextColor: "#ffffff"
                selectionColor: selectionTextColor
                color: textAreaFontColor
                font.pointSize: 12
                text: setText
            }

            ScrollBar.vertical: ScrollBar{}
        }


    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:119;width:216}
}
##^##*/
