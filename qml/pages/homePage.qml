import QtQuick 2.0
import QtLocation 5.11
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import QtPositioning 5.12
import QtMultimedia 5.0
import "subpages"

Item {
    id: item1

    property bool cameraViewState: false
    property string imagePathTest: "../../images/svg_images/close_icon.svg"

    //Map Marker
    function addMarker(latitude, longitude)
    {
        var Component = Qt.createComponent("subpages/mapMarker.qml")
        var item = Component.createObject(item1, {
                                              coordinate: QtPositioning.coordinate(latitude, longitude)
                                          })
        map.addMapItem(item)
        console.log("Working")
    }

    //Waypoint Listesini tutan model

    ListModel
    {
        id: md
    }


    Rectangle {
        id: rectangle
        color: "#b8ffce"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        property var waypointStart: undefined

        Plugin {
            id: mapPlugin
            name: "osm"
            Component.onCompleted: {
                console.log("Plugin loaded")
            }
        }


        Map {
            id: map
            anchors.fill: parent
            plugin: mapPlugin
            zoomLevel: 16
            activeMapType: supportedMapTypes[4]
            center: QtPositioning.coordinate(39.92077, 32.85411)
            /*
            Component.onCompleted: {
                for( var i = 0; i < supportedMapTypes.length; i++) {
                    console.log(supportedMapTypes[i].name)
                }

                console.log("Map loaded")

                addMarker(59.14,14.15)
            }
            */

            Component.onCompleted:addMarker(39.92077,32.85411)


            //--------------------- MAP WAYPOINT CIZIMI --------------------------------


            MapItemView
            {
                model: md
                delegate: Marker{
                    text: title
                    coordinate: QtPositioning.coordinate(coords.latitude, coords.longitude)
                }
                Lines
                {
                    id: polyLineList
                }
            }



            MouseArea{
                id: drawMarkerLineMouseArea
                anchors.fill: parent
                z: 1
                onClicked: {
                    var point = Qt.point(mouse.x, mouse.y)
                    var coord = map.toCoordinate(point);
                    var text = md.count + 1;
                    md.append({"coords": coord, "title": text})
                    polyLineList.addCoordinate(coord)
                }
            }

            Image {
                id: image3
                width: 100
                height: 100
                source: "qrc:/qtquickplugin/images/template_image.png"
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                id: gyro
                x: 1044
                y: 18
                width: 140
                height: 140
                color: "#3f3f3f"
                radius: 70
                border.width: 0
                anchors.right: parent.right
                anchors.rightMargin: 15


                Image {
                    id: image2
                    anchors.fill: parent

                    source: "../../images/svg_images/gyro.svg"
                    fillMode: Image.PreserveAspectFit
                }




            }


            //--------------------------------------------------------------------


        }

        Rectangle {
            id: toolGroup
            y: 576
            height: 180
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 10

            Rectangle {
                id: infoPlace
                x: 413
                y: 125
                width: 373
                height: 45
                opacity: 0.9
                color: "#a1a6ae"
                radius: 12
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: altGroup
                    x: -100
                    y: 4
                    width: 60
                    height: 37
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.leftMargin: 7

                    Label {
                        id: altInfo
                        y: 438
                        height: 20
                        color: "#191919"
                        text: qsTr("Alt:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.verticalCenterOffset: 0
                        anchors.leftMargin: 0
                        font.pointSize: 12
                        font.bold: true
                    }

                    Label {
                        id: altVal
                        x: 137
                        y: 438
                        width: 31
                        height: 20
                        color: "#2ca509"
                        text: qsTr("000")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: altInfo.right
                        anchors.verticalCenterOffset: 0
                        anchors.leftMargin: 2
                        font.pointSize: 12
                        font.bold: true
                    }
                }

                Rectangle {
                    id: latGroup
                    y: 4
                    width: 60
                    height: 37
                    color: "#00000000"
                    anchors.left: altGroup.right
                    anchors.leftMargin: 10
                    Label {
                        id: latInfo
                        y: 438
                        height: 20
                        color: "#191919"
                        text: qsTr("Lat:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.pointSize: 12
                        anchors.verticalCenterOffset: 0
                        font.bold: true
                        anchors.leftMargin: 0
                    }

                    Label {
                        id: latVal
                        x: 137
                        y: 438
                        width: 31
                        height: 20
                        color: "#2d8c13"
                        text: qsTr("000")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: latInfo.right
                        font.pointSize: 12
                        anchors.verticalCenterOffset: 0
                        font.bold: true
                        anchors.leftMargin: 2
                    }
                }

                Rectangle {
                    id: lonGroup
                    y: 4
                    width: 60
                    height: 37
                    color: "#00000000"
                    anchors.left: latGroup.right
                    Label {
                        id: lonInfo
                        y: 438
                        height: 20
                        color: "#191919"
                        text: qsTr("Lon:")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.pointSize: 12
                        anchors.verticalCenterOffset: 0
                        font.bold: true
                        anchors.leftMargin: 0
                    }

                    Label {
                        id: lonVal
                        x: 137
                        y: 438
                        width: 31
                        height: 20
                        color: "#2d8c13"
                        text: qsTr("000")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: lonInfo.right
                        font.pointSize: 12
                        anchors.verticalCenterOffset: 0
                        font.bold: true
                        anchors.leftMargin: 2
                    }
                    anchors.leftMargin: 10
                }

                Rectangle {
                    id: bataryGroup
                    x: -96
                    y: 4
                    width: 75
                    height: 37
                    color: "#00000000"
                    anchors.left: lonGroup.right

                    Label {
                        id: batteryVal
                        x: 137
                        y: 438
                        width: 42
                        height: 20
                        color: "#223aa5"
                        text: qsTr("%00")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: batteryInfo.right
                        anchors.right: image.left
                        anchors.rightMargin: -70
                        font.pointSize: 12
                        anchors.verticalCenterOffset: 0
                        font.bold: true
                        anchors.leftMargin: 2
                    }

                    Image {
                        id: image
                        y: 5
                        width: 40
                        height: 28
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        source: "../../images/svg_images/battery.svg"
                        anchors.leftMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }
                    anchors.leftMargin: 27
                }
            }

            Rectangle {
                id: compass
                x: 1030
                y: 24
                height: 146
                color: "#00000000"
                anchors.left: infoPlace.right
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 244
                anchors.rightMargin: 20
                anchors.bottomMargin: 20

                Rectangle {
                    id: leftUp
                    y: 0
                    width: 75
                    height: 80
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                }

                Rectangle {
                    id: rightUp
                    x: 101
                    y: 0
                    width: 82
                    height: 80
                    color: "#303030"
                    radius: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }

                Rectangle {
                    id: leftDown
                    y: 90
                    width: 85
                    height: 75
                    color: "#303030"
                    radius: 10
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 65
                    anchors.bottomMargin: -2
                }

                Rectangle {
                    id: rightDown
                    x: 100
                    y: 90
                    width: 80
                    height: 85
                    color: "#303030"
                    radius: 10
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: -2
                    anchors.rightMargin: 0
                }

                Rectangle {
                    id: comPass
                    width: 141
                    height: 141
                    color: "#3f3f3f"
                    radius: 90
                    border.width: 0
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.rightMargin: 9

                    Image {
                        id: compassIcon
                        x: 33
                        y: 42
                        width: 40
                        height: 60
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: Image.AlignHCenter
                        source: "../../images/svg_images/compass_icon.svg"
                        sourceSize.height: 400
                        sourceSize.width: 400
                        anchors.horizontalCenter: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
                        rotation: 0
                    }

                    Rectangle {
                        id: north
                        x: 56
                        width: 25
                        height: 25
                        color: "#b5b5b5"
                        radius: 12.5
                        border.width: 2
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter

                        Text {
                            id: northText
                            text: qsTr("N")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }

                    Rectangle {
                        id: south
                        x: 56
                        width: 25
                        height: 25
                        color: "#b5b5b5"
                        radius: 12.5
                        border.width: 2
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        Text {
                            id: southText
                            text: qsTr("S")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.bold: true
                        }
                    }

                    Rectangle {
                        id: west
                        width: 25
                        height: 25
                        color: "#b5b5b5"
                        radius: 12.5
                        border.color: "#000000"
                        border.width: 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        Text {
                            id: westText
                            text: qsTr("W")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.bold: true
                        }
                    }

                    Rectangle {
                        id: east
                        width: 25
                        height: 25
                        color: "#b5b5b5"
                        radius: 12.5
                        border.width: 2
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        anchors.rightMargin: 5
                        Text {
                            id: eastText
                            text: qsTr("E")
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignHCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.bold: true
                        }
                    }

                    Rectangle {
                        id: droneRotation1
                        y: 69
                        width: 20
                        height: 3
                        color: "#ffffff"
                        anchors.left: west.left
                        anchors.right: compassIcon.right
                        anchors.rightMargin: 35
                        anchors.leftMargin: 30
                    }

                    Rectangle {
                        id: droneRotation2
                        y: 69
                        height: 3
                        color: "#ffffff"
                        anchors.left: compassIcon.right
                        anchors.right: east.left
                        anchors.leftMargin: -5
                        anchors.rightMargin: 5
                    }
                }
            }
            //------------------------------VIDEO PLAY -----------------------------
            Rectangle {
                id: switchScreen
                x: 860
                y: 24
                width: 250
                height: 141
                color: "#00000000"
                radius: 15
                anchors.left: compass.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: -420
                anchors.bottomMargin: 20

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(cameraViewState === false)
                        {
                            //video.stop()
                            cameraViewState = true
                            if(camera.availability == Camera.Available)
                            {
                                cameraPreview.visible = false
                                camera.start()
                                cameraSceen.visible = true
                            }
                            else
                            {
                                cameraPreview.visible = true
                            }
                        }
                        else
                        {
                            cameraViewState = false
                            //video.play()
                            cameraPreview.visible = true
                            camera.stop()
                            cameraSceen.visible = false
                        }
                    }
                }

                Image {
                    id: cameraPreview
                    x: -2
                    y: 0
                    width: 150
                    height: 146
                    anchors.fill: parent
                    source: "../../images/svg_images/noCamera.svg"
                    fillMode: Image.PreserveAspectFit
                }

                /*
                  //-----VİDEO ICIN
                Video {
                    id: video
                    width: 150
                    height: 146
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: "sample3.avi"
                    anchors.rightMargin: -2
                    anchors.leftMargin: 2
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    focus: true
                    Keys.onSpacePressed: video.paused = !video.paused
                    Keys.onLeftPressed: video.position -= 5000
                    Keys.onRightPressed: video.position += 5000


                }
                */
                Camera {
                    id: camera
                    imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
                    cameraState: Camera.LoadedState

                    exposure {
                        exposureCompensation: -1.0
                        exposureMode: Camera.ExposurePortrait
                    }

                    flash.mode: Camera.FlashRedEyeReduction

                    imageCapture {
                        onImageCaptured: {
                            photoPreview.source = preview  // Show the preview in an Image
                        }
                    }
                }

                VideoOutput {
                    id:cameraSceen
                    source: camera
                    anchors.fill: parent
                    focus : visible // to receive focus and capture key events when visible
                }

            }

            //------------------------------VIDEO PLAY -----------------------------
        }


    }

}





/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:800;width:1200}D{i:11}
}
##^##*/
