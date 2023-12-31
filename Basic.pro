QT += quick core qml svg  widgets xml

#CONFIG += c++1z

CONFIG += c++17

OBJECTIVE_SOURCES += start/pilorama-3.0.3/src/mac/utility.mm

QMAKE_INFO_PLIST = start/pilorama-3.0.3/src/mac/Info.plist

macx: {
    LIBS += -framework Foundation
    ICON = start/pilorama-3.0.3/src/assets/app_icons/icon.icns
}

win*: {
    RC_ICONS = start/pilorama-3.0.3/src/assets/app_icons/icon.ico
}
include(framelesshelper/qmake/core.pri)
include(framelesshelper/qmake/quick.pri)

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH += \
    $$PWD/StatusQ/Components \
    $$PWD/StatusQ/Animations \
    $$PWD/StatusQ/Controls \
    $$PWD/StatusQ/Controls/Validators \
    $$PWD/StatusQ/Core \
    $$PWD/StatusQ/Core/Backpressure \
    $$PWD/StatusQ/Theme \
    $$PWD/StatusQ/Utils \
    $$PWD/StatusQ/Layout \
    $$PWD/StatusQ/Platform \
    $$PWD/StatusQ/Popups \
    $$PWD/StatusQ/Popups/Dialog \
    $$PWD/StatusQ


SOURCES += \
        start/main.cpp \
        start/pilorama-3.0.3/src/piloramatimer.cpp \
        start/pilorama-3.0.3/src/trayimageprovider.cpp \
        start/src/AppInfo.cpp \
        start/src/Def.cpp \
        start/src/FluTextStyle.cpp \
        start/src/component/CircularReveal.cpp \
        start/src/component/FileWatcher.cpp \
        start/src/component/FpsItem.cpp \
        start/src/helper/SettingsHelper.cpp

RESOURCES += qml.qrc \
	    assets.qrc \
	    start/pilorama-3.0.3/src/pilorama.qrc \
	    statusq.qrc

HEADERS += \
	start/Version.h \
	start/pilorama-3.0.3/src/piloramatimer.h \
	start/pilorama-3.0.3/src/trayimageprovider.h \
	start/src/AppInfo.h \
	start/src/Def.h \
	start/src/FluTextStyle.h \
	start/src/component/CircularReveal.h \
	start/src/component/FileWatcher.h \
	start/src/component/FpsItem.h \
	start/src/helper/SettingsHelper.h \
	start/src/singleton.h \
	start/src/stdafx.h

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
