#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QNetworkReply>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = nullptr);

    QString get_enter();
    QString get_registr();
    bool get_connectStatus();

public slots:
    void connectToServer(const QString& ipAddress, quint16 port);

    void onNetworkReplyLog();
    void onNetworkReplyReg();

    void sendMessage(const QString &sender, const QString &recipient, const QString theme, const QString &message);
    void registration(const QString &username, const QString &password);
    void logIn(const QString &username, const QString &password);

    void disconnectFromServer();

signals:
    void connectedChanged(bool connected);
    void messageReceived(const QString& message);

private slots:
    void onSocketConnected();
    void onSocketDisconnected();
    void onSocketReadyRead();

private:
    QTcpSocket* m_socket;
    bool m_connected;
    QString enter = "Connection error";
    QString registr = "Connection error";
};

#endif
