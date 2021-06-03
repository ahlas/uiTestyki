import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "controls"
import QtGraphicalEffects 1.15

Window {
    id: mainWindow
    width: 1400
    height: 800
    visible: true
    minimumWidth: 1200
    minimumHeight: 500
    color: "#00000000"
    title: qsTr("Yer Kontrol İstasyonu")

    //Remove Title Bar
    flags: Qt.Window | Qt.FramelessWindowHint

    //Properties
    property int windowStatus: 0
    property int windowMargin: 10

    //Internal Functions

    QtObject{
        id: internal

        function resetResizeBorders(value)
        {
            //Resize visibility
            resizeLeft.visible=value
            resizeRight.visible=value
            resizeBottom.visible=value
            resizeWindow.visible=value
        }

        //Büyütme Butonu Fonksiyonu
        function maximizeRestore()
        {
            if(windowStatus == 0)
            {
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0
                //Resize visibility
                resetResizeBorders(false)
                btnMaximizeRestore.btnIconSource = "../images/svg_images/restore_icon.svg"
            }
            else
            {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                //Resize visibility
                resetResizeBorders(true)
                btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }

        //Orta alandan ekranı normal boyuta getirme fonksiyonu
        function ifMaximizedWindowRestore()
        {
            if(windowStatus == 1)
            {
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10
                //Resize visibility
                resetResizeBorders(true)
                btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
            }
        }
        //Boslukları ayarlama fonksiyonu
        function restoreMargins()
        {
            windowStatus = 0
            windowMargin = 10
            //Resize visibility
            resetResizeBorders(true)
            btnMaximizeRestore.btnIconSource = "../images/svg_images/maximize_icon.svg"
        }
    }


    Rectangle {
        id: bg
        width: 1000
        height: 580
        color: "#2c313c"
        radius: 0
        anchors.fill: parent
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: appContainer
            color: "#00000000"
            radius: 0
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#00000000"
                radius: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                CustomToggleMenuBtn
                {
                    onClicked: animationLeftMenu.running = true
                }

                Rectangle {
                    id: topBarDescription
                    x: 70
                    y: 0
                    height: 35
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: topBarEmpty.top
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 70

                    DragHandler //Ekran hareket ettirme
                    {
                        onActiveChanged: if(active){
                                            mainWindow.startSystemMove()
                                             internal.ifMaximizedWindowRestore()
                                         }
                    }

                    Image {
                        id: iconApp
                        width: 28
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg_images/icon_app_top.svg"
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 5
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: label
                        width: 650
                        color: "#c3cbdd"
                        text: qsTr("MyApp")
                        anchors.left: iconApp.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        font.pointSize: 12
                        anchors.rightMargin: 131
                        anchors.leftMargin: 5
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }
                }

                Rectangle {
                    id: topBarEmpty
                    y: 31
                    height: 25
                    visible: true
                    color: "#1c1d20"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                }

                Row {
                    id: row
                    x: 853
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.topMargin: 0

                    CustomTopBarBtn
                    {
                        id: btnMinimize
                        width: 35
                        onClicked:
                        {
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }

                    }

                    CustomTopBarBtn {
                        id: btnMaximizeRestore
                        width: 35
                        btnIconSource: "../images/svg_images/maximize_icon.svg"
                        onClicked: internal.maximizeRestore()
                    }

                    CustomTopBarBtn {
                        id: btnClose
                        width: 35
                        btnIconSource: "../images/svg_images/close_icon.svg"
                        onClicked: mainWindow.close()
                    }
                }

            }

            Rectangle {
                id: content
                color: "#00000000"
                radius: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 70
                    color: "#1c1d20"
                    clip:true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0

                    PropertyAnimation
                    {
                        id:animationLeftMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == 70) return 200;else return 70
                        duration:500
                        easing.type: Easing.InOutQuint
                    }

                    Column {
                        id: columnMenus
                        width: 150
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 85
                        anchors.topMargin: 0

                        CustomLeftMenuBtn
                        {
                            id: btnHome
                            width: leftMenu.width
                            text: "Home"
                            isActiveMenu: true
                            onClicked:{
                                btnHome.isActiveMenu = true
                                btnGraphic.isActiveMenu = false
                                btnTest.isActiveMenu = false
                                btnAdmin.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/homePage.qml"))
                            }
                        }

                        CustomLeftMenuBtn {
                            id: btnGraphic
                            width: leftMenu.width
                            text: "Graphic"
                            isActiveMenu: false
                            btnIconSource: "../images/svg_images/analysis.svg"
                            onClicked:{
                                btnHome.isActiveMenu = false
                                btnGraphic.isActiveMenu = true
                                btnTest.isActiveMenu = false
                                btnAdmin.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/graphicPage.qml"))
                            }
                        }

                        CustomLeftMenuBtn {
                            id: btnTest
                            width: leftMenu.width
                            text: "Temp2"
                            isActiveMenu: false
                            btnIconSource: "../images/svg_images/save_icon.svg"
                            onClicked:{
                                btnHome.isActiveMenu = false
                                btnGraphic.isActiveMenu = false
                                btnTest.isActiveMenu = true
                                btnAdmin.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/testPage.qml"))
                            }
                        }
                    }

                    CustomLeftMenuBtn {
                        id: btnAdmin
                        width: leftMenu.width
                        text: "Settings"
                        anchors.bottom: parent.bottom
                        isActiveMenu: false
                        btnIconSource: "../images/svg_images/settings_icon.svg"
                        anchors.bottomMargin: 25
                        onClicked:{
                            btnHome.isActiveMenu = false
                            btnGraphic.isActiveMenu = false
                            btnTest.isActiveMenu = false
                            btnAdmin.isActiveMenu = true
                            stackView.push(Qt.resolvedUrl("pages/adminPage.qml"))
                        }

                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#1c1d20"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        anchors.rightMargin: 5
                        initialItem: Qt.resolvedUrl("pages/homePage.qml")
                    }
                }

                Rectangle {
                    id: rectangle
                    color: "#1c1d20"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    MouseArea {
                        id: resizeWindow
                        x: 875
                        y: 0
                        width: 33
                        height: 25
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        Image {
                            id: image
                            opacity: 0.5
                            anchors.fill: parent
                            source: "../images/svg_images/resize_icon.svg"
                            anchors.leftMargin: 10
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }

                        DragHandler
                        {
                            target: null
                            onActiveChanged: if(active)
                                             {
                                                 mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }

                    }
                }


            }
        }
    }

    DropShadow
    {
        anchors.fill:bg
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color:"#80000000"
        source:bg
        z:0
    }

    //Ekranın size'nı ayarlamaya yarayan cursorlar olusturma
    MouseArea {
        id: resizeLeft
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler
        {
            target:null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.LeftEdge) }
        }
    }

    //Ekranın size'nı ayarlamaya yarayan cursorlar olusturma
    MouseArea {
        id: resizeRight
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler
        {
            target:null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.RightEdge) }
        }
    }

    //Ekranın size'nı ayarlamaya yarayan cursorlar olusturma
    MouseArea {
        id: resizeBottom
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler
        {
            target:null
            onActiveChanged: if(active){ mainWindow.startSystemResize(Qt.BottomEdge) }
        }
    }

}



/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
