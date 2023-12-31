import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.wangwenx190.FramelessHelper 1.0
import AkshUI 1.0
import example 1.0

import QtQuick.Window 2.14
import QtGraphicalEffects 1.13
import Qt.labs.settings 1.0
import QtQml.Models 2.14

import StatusQ.Core 0.1
import StatusQ.Core.Theme 0.1
import StatusQ.Controls 0.1
import StatusQ.Components 0.1
import StatusQ.Layout 0.1
import StatusQ.Platform 0.1

MainWindow {
    title:"Standard"
    fixSize: false

    id: rootWindow
    width: Qt.platform.os == "ios" || Qt.platform.os == "android" ? Screen.width
                                                                  :  1224
    height: Qt.platform.os == "ios" || Qt.platform.os == "android" ? Screen.height
                                                                   :840
    minimumHeight: 840
    minimumWidth: 1224
    visible: true
    property ThemePalette lightTheme: StatusLightTheme {}
    property ThemePalette darkTheme: StatusDarkTheme {}

    readonly property real maxFactor: 2.0
    readonly property real minFactor: 0.5

    property real factor: 1.0

    QtObject {
        id: appSectionType
        readonly property int chat: 0
        readonly property int community: 1
        readonly property int wallet: 2
        readonly property int browser: 3
        readonly property int nodeManagement: 4
        readonly property int profileSettings: 5
        readonly property int apiDocumentation: 100
        readonly property int examples: 101
        readonly property int demoApp: 102
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: timeLabel.text = Qt.formatTime(new Date(), "hh:mm:ss")
    }

    Label {
        id: timeLabel
        anchors.centerIn: parent
        font {
            pointSize: 70
            bold: true
        }
        color: palette.base
    }

    Connections{
        target: FramelessUtils
        function onSystemThemeChanged(){
        }
    }

    Action {
        shortcut: "CTRL+="
        onTriggered: {
            if (rootWindow.factor < 2.0)
                rootWindow.factor += 0.2
        }
    }

    Action {
        shortcut: "CTRL+-"
        onTriggered: {
            if (rootWindow.factor > 0.5)
                rootWindow.factor -= 0.2
        }
    }

    Action {
        shortcut: "CTRL+0"
        onTriggered: {
            rootWindow.factor = 1.0
        }
    }


    Settings {
        id: storeSettings
        property string selected: ""
        property string selectedExample: ""
        property bool lightTheme: true
        property bool fillPage: false
    }
}


