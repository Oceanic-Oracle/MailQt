import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    id: mainPage

    visible: false

    Rectangle {
        id: mainBack
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightblue" }
            GradientStop { position: 1.0; color: "#faacac" }
        }

        Item {
            width: parent.width * 0.8
            height: parent.height * 0.8

            anchors.centerIn: parent

            Rectangle {
                id: slideMess
                color: "white"
                width: parent.width * 0.3
                clip: true

                radius: 20
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }

                Rectangle {
                    id: headerSlide
                    border.color: "lightgrey"
                    radius: 20
                    z: 1
                    height: 40

                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }
                    GridLayout {
                        columns: 2
                        anchors {
                            left: parent.left
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                        }
                        CustomButton {
                            id: incomingMess

                            buttonText: "Incoming"
                            buttonColorText: "grey"
                            buttonColorBord.color: "lightblue"
                            Layout.alignment: Qt.AlignHCenter

                            onClicked: {
                                outgoinglistMessage.visible = false
                                incominglistMessage.visible = true

                                incominglistModel.clear()

                                client.refresh("incoming")
                            }
                        }

                        CustomButton {
                            id: outgoingMess

                            buttonText: "Outgoing"
                            buttonColorText: "grey"
                            buttonColorBord.color: "#faacac"
                            Layout.alignment: Qt.AlignHCenter

                            onClicked: {
                                incominglistMessage.visible = false
                                outgoinglistMessage.visible = true

                                outgoinglistModel.clear()

                                client.refresh("outgoing")
                            }
                        }
                    }
                }

                ListView {
                    id: incominglistMessage

                    visible: true

                    anchors.fill: parent
                    topMargin: 40

                    model: incominglistModel

                    delegate: Button {
                        background: null
                        height: 100
                        width: parent.width
                        clip: true

                        MouseArea {
                            anchors.fill: parent

                            Text {
                                id: incomingusernameText
                                text: model.incomingusername

                                anchors {
                                    topMargin: 10
                                    leftMargin: 15
                                    left: parent.left
                                    top: parent.top
                                }
                            }

                            Text {
                                id: incomingthemeText
                                text: model.incomingtheme
                                color: "grey"

                                anchors {
                                    topMargin: 10
                                    left: incomingusernameText.left
                                    top: incomingusernameText.bottom
                                }
                            }

                            Text {
                                id: incomingmessageText
                                text: model.incomingmessage
                                color: "grey"

                                anchors {
                                    topMargin: 10
                                    left: incomingthemeText.left
                                    top: incomingthemeText.bottom
                                }
                            }

                            Text {
                                id: incomingdataText
                                text: model.incomingdata
                                color: "grey"

                                anchors {
                                    rightMargin: 15
                                    right: parent.right
                                    verticalCenter: parent.verticalCenter
                                }
                            }

                            Rectangle {
                                color: "lightgrey"
                                width: parent.width - 0.1 * parent.width
                                height: 1
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: incomingmessageText.bottom
                                anchors.topMargin: 10
                            }

                            onClicked: {
                                writeMess.visible = false
                                winMessage.visible = true
                                textFrom.text = incomingusernameText.text
                                textTheme.text = incomingthemeText.text
                                textMessage.text = incomingmessageText.text
                                textDate.text = incomingdataText.text

                                fromRead.text = "From: "
                            }
                        }
                    }
                }

                ListModel {
                    id: incominglistModel
                }

                Connections {
                    target: client

                    onIncomingMessageReceived: {
                        incominglistModel.append({
                                                     incomingusername: sender,
                                                     incomingtheme: theme,
                                                     incomingmessage: message,
                                                     incomingdata: data
                                                 });
                    }
                }

                ListView {
                    id: outgoinglistMessage

                    visible: false

                    anchors.fill: parent
                    topMargin: 40
                    ScrollBar.vertical: ScrollBar {}

                    model: outgoinglistModel

                    delegate: Button {
                        background: null
                        height: 100
                        width: parent.width
                        clip: true

                        MouseArea {
                            anchors.fill: parent

                            Text {
                                id: outgoingusernameText
                                text: model.outgoingusername

                                anchors {
                                    topMargin: 10
                                    leftMargin: 15
                                    left: parent.left
                                    top: parent.top
                                }
                            }

                            Text {
                                id: outgoingthemeText
                                text: model.outgoingtheme
                                color: "grey"

                                anchors {
                                    topMargin: 10
                                    left: outgoingusernameText.left
                                    top: outgoingusernameText.bottom
                                }
                            }

                            Text {
                                id: outgoingmessageText
                                text: model.outgoingmessage
                                color: "grey"

                                anchors {
                                    topMargin: 10
                                    left: outgoingthemeText.left
                                    top: outgoingthemeText.bottom
                                }
                            }

                            Text {
                                id: outgoingdataText
                                text: model.outgoingdata
                                color: "grey"

                                anchors {
                                    rightMargin: 15
                                    right: parent.right
                                    verticalCenter: parent.verticalCenter
                                }
                            }

                            Rectangle {
                                color: "lightgrey"
                                width: parent.width - 0.1 * parent.width
                                height: 1
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: outgoingmessageText.bottom
                                anchors.topMargin: 10
                            }

                            onClicked: {
                                writeMess.visible = false
                                winMessage.visible = true
                                textFrom.text = outgoingusernameText.text
                                textTheme.text = outgoingthemeText.text
                                textMessage.text = outgoingmessageText.text
                                textDate.text = outgoingdataText.text

                                fromRead.text = "To: "
                            }
                        }
                    }
                }

                ListModel {
                    id: outgoinglistModel

                    ListElement {
                        outgoingusername: "Me"
                        outgoingtheme: "fgbfgb"
                        outgoingmessage: "Hello, dfgbgbdf"
                        outgoingdata: "22.07.12 20:21"
                    }
                }

                Connections {
                    target: client

                    onOutgoingMessageReceived: {
                        outgoinglistModel.append({
                                                     outgoingusername: recipient,
                                                     outgoingtheme: theme,
                                                     outgoingmessage: message,
                                                     outgoingdata: data
                                                 });
                    }
                }
            }

            Rectangle {
                id: readMess
                color: "white"
                radius: 20
                anchors {
                    left: slideMess.right
                    right: parent.right
                    top: parent.top
                    bottom: buttFot.top
                    leftMargin: 2
                    bottomMargin: 2
                }

                Item {
                    id: winMessage
                    visible: false
                    anchors.fill: parent

                    Text {
                        id: fromRead
                        text: "From: "

                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.leftMargin: 20
                    }

                    Text {
                        id: textFrom
                        color: "grey"
                        text: ""
                        anchors.left: fromRead.right
                        anchors.top: fromRead.top
                    }

                    Text {
                        id: themeRead
                        text: "Theme: "

                        anchors.top: fromRead.bottom
                        anchors.left: fromRead.left
                        anchors.topMargin: 10
                    }

                    Text {
                        id: textTheme
                        color: "grey"
                        text: ""
                        anchors.left: themeRead.right
                        anchors.top: themeRead.top
                    }

                    Text {
                        id: textDate
                        color: "grey"
                        text: ""
                        anchors.right: parent.right
                        anchors.top: fromRead.top
                        anchors.rightMargin: 20
                    }

                    Rectangle {
                        id: lineRead
                        color: "lightgrey"
                        width: parent.width - 0.1 * parent.width
                        height: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: themeRead.bottom
                        anchors.topMargin: 15
                    }

                    Text {
                        id: textMessage
                        color: "grey"
                        anchors.top: lineRead.bottom
                        anchors.left: fromRead.left
                        anchors.topMargin: 10
                    }
                }

                Item {
                    id: writeMess
                    visible: false
                    anchors.fill: parent

                    Text {
                        id: toWrite

                        text: "To: "
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.topMargin: 20
                    }

                    TextField {
                        id: toWriteText

                        anchors.left: toWrite.right
                        anchors.top: toWrite.top
                        anchors.leftMargin: 10
                    }

                    Text {
                        id: themeWrite

                        text: "Theme: "
                        anchors.top: toWrite.bottom
                        anchors.left: toWrite.left
                        anchors.topMargin: 20
                    }

                    TextField {
                        id: themeWriteText

                        anchors.left: themeWrite.right
                        anchors.top: themeWrite.top
                        anchors.leftMargin: 2
                    }

                    Rectangle {
                        id: lineWrite

                        color: "lightgrey"
                        width: parent.width - 0.1 * parent.width
                        height: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: themeWrite.bottom
                        anchors.topMargin: 15
                    }

                    TextField {
                        id: messWriteText

                        anchors.top: lineWrite.bottom
                        anchors.left: themeWrite.left
                        anchors.right: writeMess.right
                        anchors.bottom: sendButt.top
                        anchors.topMargin: 10
                        anchors.rightMargin: 20
                        anchors.bottomMargin: 20

                        inputMethodHints: Qt.ImhMultiLine
                        wrapMode: Text.WrapAnywhere
                    }

                    CustomButton {
                        id: sendButt
                        buttonText: "Send"
                        buttonColorBord.color: "lightblue"
                        buttonColorText: "grey"

                        anchors.bottom: writeMess.bottom
                        anchors.right: writeMess.right
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 10

                        onClicked: {
                            if (toWriteText.text !== "" && themeWriteText.text !== "" && messWriteText.text !== "")
                            {
                                client.sendMessage(toWriteText.text, themeWriteText.text, messWriteText.text);
                            }
                            else
                            {
                                errorWrite.visible = true;
                            }
                        }
                    }

                    Text {
                        id: errorWrite

                        visible: false

                        text: "Fill in all the fields"

                        color: "#faacac"

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: messWriteText.bottom
                        anchors.topMargin: 12

                        font.pointSize: 13
                        font.bold: true
                    }

                    Connections {
                        target: client

                        onErrorSend:    {
                            errorWrite.visible = true
                            errorWrite.text = "User does not exist"
                        }
                        onConfirmSend:
                        {
                            errorWrite.visible = false;
                            toWriteText.clear();
                            themeWriteText.clear();
                            messWriteText.clear();
                        }
                    }
                }
            }

            Rectangle {
                id: buttFot
                color: "white"
                radius: 20
                height: parent.height * 0.1
                anchors {
                    left: slideMess.right
                    bottom: parent.bottom
                    right: parent.right
                    leftMargin: 2
                }

                GridLayout {
                    columns: 3
                    anchors {
                        left: parent.left
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    CustomButton {
                        buttonText: "Exit"
                        buttonColorBord.color: "#faacac"
                        buttonColorText: "grey"
                        Layout.alignment: Qt.AlignHCenter

                        onClicked: {
                            view.pop();

                            outgoinglistModel.clear()
                            incominglistModel.clear()

                            winMessage.visible = false
                            writeMess.visible  = false
                            errorWrite.visible = false

                            toWriteText.text     = ""
                            themeWriteText.text  = ""
                            messWriteText.text   = ""
                        }
                    }

                    CustomButton {
                        buttonText: "Reply"
                        buttonColorBord.color: "lightblue"
                        buttonColorText: "grey"
                        Layout.alignment: Qt.AlignHCenter

                        onClicked: {
                            toWriteText.text = textFrom.text
                            themeWriteText.text = textTheme.text

                            winMessage.visible = false
                            writeMess.visible = true
                        }
                    }

                    CustomButton {
                        buttonText: "Write"
                        buttonColorBord.color: "lightblue"
                        buttonColorText: "grey"
                        Layout.alignment: Qt.AlignHCenter

                        onClicked: {
                            winMessage.visible = false
                            writeMess.visible = true
                        }
                    }
                }
            }
        }
    }
}
