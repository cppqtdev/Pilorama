#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QQuickWindow>
#include <QNetworkProxy>
#include <QSslConfiguration>
#include <QProcess>
#include <QtQml/qqmlextensionplugin.h>
#include <QLoggingCategory>

#include <QtQml>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQuickItem>
#include <QTimer>
#include <QUuid>
#include <QFontDatabase>
#include <QClipboard>
#include <FramelessHelper/Quick/framelessquickmodule.h>
#include <FramelessHelper/Core/private/framelessconfig_p.h>


#include <QSystemTrayIcon>
#include <QPixmap>
#include <QApplication>


#include "src/Def.h"
#include "src/AppInfo.h"
#include "src/FluTextStyle.h"
#include "src/component/CircularReveal.h"
#include "src/component/FileWatcher.h"
#include "src/component/FpsItem.h"
#include "src/helper/SettingsHelper.h"

#include "pilorama-3.0.3/src/piloramatimer.h"
#include "pilorama-3.0.3/src/trayimageprovider.h"



void mac_disable_app_nap();
using namespace wangwenx190::FramelessHelper;

int main(int argc, char *argv[])
{

#ifdef __APPLE__
#if TARGET_OS_MAC
    mac_disable_app_nap();
#endif /* TARGET_OS_MAC */
#endif /* __APPLE__ */
    FramelessHelper::Quick::initialize();
    FramelessConfig::instance()->set(Global::Option::DisableLazyInitializationForMicaMaterial);
    FramelessConfig::instance()->set(Global::Option::CenterWindowBeforeShow);
    FramelessConfig::instance()->set(Global::Option::ForceNonNativeBackgroundBlur);
    FramelessConfig::instance()->set(Global::Option::EnableBlurBehindWindow);
#ifdef Q_OS_WIN
    FramelessConfig::instance()->set(Global::Option::EnableBlurBehindWindow,false);
#endif
#ifdef Q_OS_MACOS
    FramelessConfig::instance()->set(Global::Option::ForceNonNativeBackgroundBlur,false);
#endif

    QNetworkProxy::setApplicationProxy(QNetworkProxy::NoProxy);
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
#if (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
#endif
#endif
    qputenv("QT_QUICK_CONTROLS_STYLE","Basic");
    QGuiApplication::setOrganizationName("TechCoderHub");
    QGuiApplication::setOrganizationDomain("https://divyadesh.github.io");
    QGuiApplication::setApplicationName("QT UI");
    QGuiApplication::setApplicationVersion("1.2.2");

    qmlRegisterUncreatableMetaObject(Fluent_Awesome::staticMetaObject, "AkshUI",1,0,"FluentIcons", "Access to enums & flags only");

    SettingsHelper::getInstance()->init(argv);
    if(SettingsHelper::getInstance()->getRender()=="software"){
#if (QT_VERSION >= QT_VERSION_CHECK(6, 0, 0))
        QQuickWindow::setGraphicsApi(QSGRendererInterface::Software);
#elif (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
        QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);
#endif
    }

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon("qrc:/assets/img/icons.png"));
    QQmlApplicationEngine engine;
    FluTextStyle* textStyle = FluTextStyle::getInstance();
    engine.rootContext()->setContextProperty("FluTextStyle",textStyle);

    AppInfo::getInstance()->init(&engine);
    engine.rootContext()->setContextProperty("AppInfo",AppInfo::getInstance());
    engine.rootContext()->setContextProperty("SettingsHelper",SettingsHelper::getInstance());

    engine.addImageProvider("tray_icon_provider", new TrayImageProvider());

    qmlRegisterType<PiloramaTimer>("Pilorama", 1, 0, "Timer");

    qmlRegisterType<CircularReveal>("example", 1, 0, "CircularReveal");
    qmlRegisterType<FileWatcher>("example", 1, 0, "FileWatcher");
    qmlRegisterType<FpsItem>("example", 1, 0, "FpsItem");

    FramelessHelper::Quick::registerTypes(&engine);
    engine.addImportPath("qrc:/");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    const int exec = QGuiApplication::exec();
    if (exec == 931) {
        QProcess::startDetached(qApp->applicationFilePath(), QStringList());
    }
    return exec;
}
