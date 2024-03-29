import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: customToggleMenuBtn

    //CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg_images/menu_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272e"
    property color btnColorClicked: "#00a1f1"


    QtObject{
        id:internal

        //MOUSE OVER AND CLICK CHANGE
        property var dynamicColor: if(customToggleMenuBtn.down)
                                   {
                                       customToggleMenuBtn.down ? btnColorClicked : btnColorDefault
                                   }else
                                   {
                                        customToggleMenuBtn.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }

    implicitWidth: 70
    implicitHeight: 60

    background: Rectangle
    {
        id: bgBtn
        color: internal.dynamicColor

    }

    Image {
        id: iconBtn
        source: btnIconSource
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        height: 25
        width: 25
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    ColorOverlay
    {
        anchors.fill: iconBtn
        source: iconBtn
        color:"#ffffff"
        antialiasing: false
    }

}
