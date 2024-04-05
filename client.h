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
    void disconnectFromServer();

    void sendMessage(const QString &sender, const QString &recipient, const QString &theme, const QString &message);
    void registration(const QString &username, const QString &password);
    void logIn(const QString &username, const QString &password);   

signals:
    void connectedChanged(bool connected);
    void outgoingMessageReceived(const QString &sender, const QString &recipient, const QString &theme, const QString &message, const QString &data);
    void incomingMessageReceived(const QString &sender, const QString &recipient, const QString &theme, const QString &message, const QString &data);
    void loginSuccess();
    void loginError(const QString &errorMessage);
    void registrationSuccess();
    void registrationError(const QString &errorMessage);

private slots:
    void onSocketConnected();
    void onSocketDisconnected();
    void onSocketReadyRead();

private:
    QTcpSocket* m_socket;
    bool m_connected;
    QString enter = "Connection error";
    QString registr = "Connection error";
    QString login;
};

#endif
