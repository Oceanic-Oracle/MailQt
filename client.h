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

public slots:
    void connectToServer(const QString& ipAddress, quint16 port);
    void disconnectFromServer();

    void sendMessage(const QString &recipient, const QString &theme, const QString &message);
    void registration(const QString &username, const QString &password);
    void logIn(const QString &username, const QString &password);
    void refresh(const QString &refresh_action);
    void inputValidation(const QString &username, const QString &password, const QString &repPassword);

signals:
    void connectedChanged(bool connected);
    void serverConnect();
    void outgoingMessageReceived(const QString &sender, const QString &recipient, const QString &theme, const QString &message, const QString &data);
    void incomingMessageReceived(const QString &sender, const QString &recipient, const QString &theme, const QString &message, const QString &data);
    void loginSuccess();
    void loginError(const QString &errorMessage);
    void registrationSuccess();
    void enterRegistError(const QString &errorMessage);
    void registrationError(const QString &errorMessage);
    void errorSend();
    void confirmSend();

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
