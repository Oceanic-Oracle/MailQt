#include <client.h>
#include <QHostAddress>
#include <QDataStream>
#include <QJsonObject>
#include <QJsonDocument>
#include <QQmlApplicationEngine>
#include <QQmlContext>

Client::Client(QObject *parent) : QObject(parent), m_socket(nullptr), m_connected(false){connectToServer("127.0.0.1", 1234); }

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

        QHostAddress address(ipAddress);
        m_socket->connectToHost(address, port);
    }
}

void Client::disconnectFromServer()
{
    if (m_socket) {
        m_socket->disconnectFromHost();
    }
}

void Client::sendMessage(const QString &sender, const QString &recipient, const QString &theme, const QString &message)
{
    QJsonObject json;
    json["0_action"] = "message";
    json["1_sender"] = sender;
    json["2_recipient"] = recipient;
    json["3_theme"] = theme;
    json["4_message"] = message;
    QJsonDocument document(json);

    m_socket->write(document.toJson(QJsonDocument::Compact));
    m_socket->flush();
}

void Client::registration(const QString &username, const QString &password)
{
    QJsonObject json;
    json["0_action"] = "registration";
    json["1_username"] = username;
    json["2_password"] = password;

    QJsonDocument document(json);

    m_socket->write(document.toJson(QJsonDocument::Compact));
    m_socket->flush();
}

void Client::logIn(const QString &username, const QString &password)
{
    login = username;

    QJsonObject json;
    json["0_action"] = "login";
    json["1_username"] = username;
    json["2_password"] = password;

    QJsonDocument document(json);

    m_socket->write(document.toJson(QJsonDocument::Compact));
    m_socket->flush();
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
    QByteArray data = m_socket->readAll();
    QJsonDocument jsonDoc = QJsonDocument::fromJson(data);
    QJsonObject jsonObj = jsonDoc.object();

    QString action = jsonObj["0_action"].toString();

    if (action == "login")
    {
        QString result = jsonObj["1_result"].toString();
        if (result == "success")
        {
            emit loginSuccess();
        }
        else
        {
            emit loginError(result);
        }
    }

    else if (action == "registration")
    {
        QString result = jsonObj["1_result"].toString();
        if (result == "success") {
            emit registrationSuccess();
        } else {
            emit registrationError(result);
        }
    }

    else if (action == "message")
    {
        QString sender = jsonObj["1_sender"].toString();
        QString recipient = jsonObj["2_recipient"].toString();
        QString theme = jsonObj["3_theme"].toString();
        QString message = jsonObj["4_message"].toString();
        QString data = jsonObj["5_data"].toString();

        if (login == sender)
        {
            emit outgoingMessageReceived(sender, recipient, theme, message, data);
        }
        else
        {            
            emit incomingMessageReceived(sender, recipient, theme, message, data);
        }
    }
}
