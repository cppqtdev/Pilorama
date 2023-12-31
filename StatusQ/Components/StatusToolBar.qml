import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.13

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1

ToolBar {
    id: root

    property string backButtonName: ""
    property int notificationCount: 0
    property Item headerContent
    property alias notificationButton: notificationButton

    signal backButtonClicked()
    signal notificationButtonClicked()

    implicitWidth: visible ? 518 : 0
    implicitHeight: visible ? 60 : 0
    padding: 8
    background: null

    RowLayout {
        anchors.fill: parent
        spacing: 0
        StatusFlatButton {
            icon.name: "arrow-left"
            icon.width: 20
            icon.height: 20
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.leftMargin: 12
            visible: !!root.backButtonName
            text: root.backButtonName
            size: StatusBaseButton.Size.Large
            onClicked: { root.backButtonClicked(); }
        }

        Control {
            id: headerContentItem
            Layout.fillWidth: !!headerContent
            Layout.fillHeight: !!headerContent
            background: null
            contentItem: (!!headerContent) ? headerContent : null
        }

        Item {
            Layout.fillWidth: !headerContent
        }

        StatusActivityCenterButton {
            id: notificationButton
            unreadNotificationsCount: root.notificationCount
            onClicked: root.notificationButtonClicked()
        }
    }
}
