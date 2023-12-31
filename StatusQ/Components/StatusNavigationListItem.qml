import QtQuick 2.13
import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Components 0.1

StatusListItem {
    id: statusNavigationListItem

    property bool selected: false
    property alias badge: statusBadge

    implicitWidth: 286
    implicitHeight: 48

    asset.bgWidth: 20
    asset.bgHeight: 20
    asset.bgColor: "transparent"

    statusListItemIcon.anchors.topMargin: 14

    color: {
        if (selected) {
            return Theme.palette.statusNavigationListItem.selectedBackgroundColor
        }
        return sensor.containsMouse ? 
          Theme.palette.statusNavigationListItem.hoverBackgroundColor :
          Theme.palette.baseColor4
    }

    MouseArea {
        id: sensor
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor 
        hoverEnabled: true
        onClicked: statusNavigationListItem.clicked(statusNavigationListItem.itemId, mouse)
    }

    components: [
        StatusBadge {
            id: statusBadge
            visible: value > 0
        }
    ]
}
