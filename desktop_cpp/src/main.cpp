#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QIcon>
#include "ui_controller.h"
#include "win_event_filter.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    app.setOrganizationName("ViOrg");
    app.setOrganizationDomain("vi.local");
    app.setApplicationName("ViDesktop");
    app.setApplicationVersion("0.6.0");

    UIController controller;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("controller", &controller);

    const QUrl url(QStringLiteral("qrc:/ui/qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url, &engine](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);

            if (obj && url == objUrl) {
                QQuickWindow *window = qobject_cast<QQuickWindow *>(obj);
                if (window) {
#ifdef Q_OS_WIN
                    WinEventFilter *filter = new WinEventFilter(window);
                    app.installNativeEventFilter(filter);
#endif
                }
            }
        },
        Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
