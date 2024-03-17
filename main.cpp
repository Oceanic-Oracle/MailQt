#include <client.h>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/mailQt/Main.qml"_qs);

    Client client;
    qmlRegisterType<Client>("com.mail", 1, 0, "Client");
    engine.rootContext()->setContextProperty("client", &client);
    engine.rootContext()->setContextProperty("enter", client.get_enter());
    engine.rootContext()->setContextProperty("registr", client.get_registr());
    engine.rootContext()->setContextProperty("status", client.get_connectStatus());

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
