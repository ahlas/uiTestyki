import QtQuick 2.0
import QtLocation 5.12


MapQuickItem{
    id: marker
    anchorPoint.x: marker.width / 4
    anchorPoint.y: marker.height
    sourceItem: Image{
        id: icon
        source: "../../../images/svg_images/droneMapMarker.svg"
        sourceSize.width: 50
        sourceSize.height: 50
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.66;height:40;width:40}
}
##^##*/
