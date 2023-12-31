import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import Qt.labs.settings 1.0
import QtQuick.Layouts 1.15
import org.wangwenx190.FramelessHelper 1.0
import AkshUI 1.0
import example 1.0

import QtGraphicalEffects 1.13
import QtQml.Models 2.14

import "Components"
import "Components/Sequence"

import "start"


MainWindow {
    title:"Pilorama"
    fixSize: false

    id: window
    width: Qt.platform.os == "ios" || Qt.platform.os == "android" ? Screen.width
                                                                  :  420
    height: Qt.platform.os == "ios" || Qt.platform.os == "android" ? Screen.height
                                                                   :550

    minimumHeight: timerLayout.height + padding * 2 + 50
    minimumWidth: timerLayout.width + padding * 2
    visible: true

    readonly property real maxFactor: 2.0
    readonly property real minFactor: 0.5

    property real factor: 1.0

//    Shortcut {
//        sequence: "Ctrl+P"
//        onActivated: {
//            var win = Qt.createComponent("qrc:/main.qml")
//            if(win){
//                var rootWindow = win.createObject(window)
//                rootWindow.show()
//            }
//        }
//    }

    Connections{
        target: FramelessUtils
        function onSystemThemeChanged(){
            appSettings.darkMode = !appSettings.darkMode
        }
    }

    Action {
        shortcut: "CTRL+="
        onTriggered: {
            if (window.factor < 2.0)
                window.factor += 0.2
        }
    }

    Action {
        shortcut: "CTRL+-"
        onTriggered: {
            if (window.factor > 0.5)
                window.factor -= 0.2
        }
    }

    Action {
        shortcut: "CTRL+0"
        onTriggered: {
            window.factor = 1.0
        }
    }


    Settings {
        id: storeSettings
        property string selected: ""
        property string selectedExample: ""
        property bool lightTheme: true
        property bool fillPage: false
    }

    maximumWidth: width

    color: colors.getColor("bg")

    Behavior on color { ColorAnimation { duration: 200 } }

    property real padding: 16
    property bool expanded: true

    property bool alwaysOnTop: false
    property bool quitOnClose: true

    property string clockMode: "start"

    SystemPalette{
        id: systemPalette

        property color lightColor: '#ffffff'
        property bool sysemDarkMode: base !== lightColor
        property alias follow: appSettings.followSystemTheme

        onSysemDarkModeChanged: setSystemColors()
        onFollowChanged: setSystemColors()
        Component.onCompleted: setSystemColors()


        function setSystemColors(){
            if(appSettings.followSystemTheme){
                appSettings.darkMode = sysemDarkMode
            }
        }
    }

    onClosing: {
        if(!quitOnClose) {
            close.accepted = false;
            if (Qt.platform.os == "osx") {
                window.hide();
            }
            else {
                window.visibility = ApplicationWindow.Minimized;
            }
        }
    }

    onAlwaysOnTopChanged: {
        alwaysOnTop ? flags = Qt.WindowStaysOnTopHint | Qt.Window : flags = Qt.Window
        requestActivate()
    }

    onClockModeChanged: { canvas.requestPaint() }
    onExpandedChanged: {
        if(expanded === true){
            height = padding * 2 + timerLayout.height + sequence.height
        } else {
            height = padding * 2 + timerLayout.height
        }
    }


    function checkClockMode (){

        if (pomodoroQueue.infiniteMode && globalTimer.running){
            clockMode = "pomodoro"
        } else if (!pomodoroQueue.infiniteMode){
            clockMode = "timer"
        } else {
            clockMode = "start"
        }
    }

    Settings {
        id: appSettings

        property bool darkMode: false
        property bool followSystemTheme: false

        property alias soundMuted: notifications.soundMuted
        property alias splitToSequence: preferences.splitToSequence

        property alias windowX: window.x
        property alias windowY: window.y

        property alias windowHeight: window.height

        property alias alwaysOnTop: window.alwaysOnTop
        property alias quitOnClose: window.quitOnClose
        property alias showQueue: sequence.showQueue

        onDarkModeChanged: { canvas.requestPaint(); }
        onSplitToSequenceChanged: { canvas.requestPaint(); }
    }

    Settings {
        id: durationSettings

        property real timer: 0

        property real pomodoro: 25 * 60
        property real pause: 10 * 60
        property real breakTime: 15 * 60
        property int repeatBeforeBreak: 2

        property alias data: masterModel.data
        property alias title: masterModel.title

        onDataChanged: console.log("Settings data:" + data)

    }

    Colors {
        id: colors
    }

    FontLoader {
        id: localFont;
        source: "./assets/font/Inter.otf"
    }


    MasterModel {
        id: masterModel
        data: data
        title: title
    }

    ModelBurner {
        id: pomodoroQueue
        durationSettings: durationSettings
    }

    TrayIcon {
        id: tray
    }

    NotificationSystem {
        id: notifications
    }

    PiloramaTimer {
        id: globalTimer
    }

    Clock {
        id: clock
    }

    FileDialogue {
        id: fileDialogue
    }

    QtObject {
        id: time
        property real hours: 0
        property real minutes: 0
        property real seconds: 0

        function updateTime() {
            var currentDate = new Date()
            hours = currentDate.getHours()
            minutes = currentDate.getMinutes()
            seconds = currentDate.getSeconds()
        }
    }

    StackView {
        id: stack
        anchors.bottomMargin: 3
        anchors.rightMargin: window.padding
        anchors.leftMargin: window.padding
        //        anchors.bottomMargin: window.padding
        anchors.topMargin: window.padding
        anchors.fill: parent

        initialItem: content

        Item {
            id: content

            Item {
                id: timerLayout
                width: parent.width
                height: width
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top

                Dials {
                    id: canvas

                }

                MouseTracker {
                    id: mouseArea
                }

                StartScreen {
                    id: startControls
                }

                TimerScreen {
                    id: digitalClock
                }

                SoundButton {
                    id: soundButton
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                }

                PreferencesButton {
                    id: preferencesButton
                }

                ExternalDrop {
                    id: externalDrop
                }

            }

            Sequence {
                id: sequence
                anchors.top: timerLayout.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.topMargin: 18
            }
        }

        Preferences {
            id: preferences
        }
    }

}


