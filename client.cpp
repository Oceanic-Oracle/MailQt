#include <client.h>
#include <QHostAddress>
#include <QDataStream>
#include <QJsonObject>
#include <QJsonDocument>

Client::Client(QObject *parent) : QObject(parent), m_socket(nullptr), m_connected(false){}

QString Client::get_enter()
{
    return enter;
}

QString Client::get_registr()
{
    return registr;
}

bool Client::get_connectStatus()
{
    return m_connected;
}

void Client::connectToServer(const QString& ipAddress, quint16 port)
{
    if (!m_socket) {
        m_socket = new QTcpSocket(this);
        connect(m_socket, &QTcpSocket::connected, this, &Client::onSocketConnected);
        connect(m_socket, &QTcpSocket::disconnected, this, &Client::onSocketDisconnected);
        connect(m_socket, &QTcpSocket::readyRead, this, &Client::onSocketReadyRead);
        //TODO: connects

        QHostAddress address(ipAddress);
        m_socket->connectToHost(address, port);
    }
}

void Client::onNetworkReplyLog()
{
    //TODO
}

void Client::onNetworkReplyReg()
{
    //TODO
}

void Client::sendMessage(const QString &sender, const QString &recipient, const QString theme, const QString &message)
{
    QJsonObject json;
    json["action"] = "message";
    json["sender"] = sender;
    json["recipient"] = recipient;
    json["theme"] = theme;
    json["message"] = message;
    QJsonDocument document(json);

    m_socket->write(document.toJson(QJsonDocument::Compact));
    m_socket->flush();
}

void Client::registration(const QString &username, const QString &password)
{
    QJsonObject json;
    json["action"] = "registration";
    json["regUsername"] = username;
    json["regPassword"] = password;

    QJsonDocument document(json);

    m_socket->write(document.toJson(QJsonDocument::Compact));
    m_socket->flush();
}

void Client::logIn(const QString &username, const QString &password)
{
    QJsonObject json;
    json["action"] = "login";
    json["username"] = username;
    json["password"] = password;

    QJsonDocument document(json);

    m_socket->write(document.toJson(QJsonDocument::Compact));
    m_socket->flush();
}

void Client::disconnectFromServer()
{
    if (m_socket) {
        m_socket->disconnectFromHost();
    }
}

void Client::onSocketConnected()
{
    m_connected = true;
    emit connectedChanged(true);
}

void Client::onSocketDisconnected()
{
    m_connected = false;
    emit connectedChanged(false);
}

void Client::onSocketReadyRead()
{
    QString message = QString::fromUtf8(m_socket->readAll());
    emit messageReceived(message);
}
