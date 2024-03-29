import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root

    minimumHeight: 550
    minimumWidth: 1000
    visible: true
    title: qsTr("mail")

    StackView {
        id: view
        anchors.fill: parent
        initialItem: authWin

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }

        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
    }

    Page {
        id: authWin

        Rectangle {
            id: backgroundAuth
            anchors.fill: parent

            gradient: Gradient {
                GradientStop { position: 0.0; color: "lightblue" }
                GradientStop { position: 1.0; color: "#faacac" }
            }

            Rectangle {
                id: logWin

                height: 300
                width: 400
                radius: 20

                anchors.centerIn: parent

                Item {
                    id: spaceItem1
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 30
                }

                Text {
                    id: titleWelcome
                    text: "Sign in"
                    font.bold: true

                    font.pointSize: 20

                    color: "lightblue"

                    anchors.horizontalCenter: spaceItem1.horizontalCenter
                    anchors.top: spaceItem1.bottom
                }

                Item {
                    id: spaceItem2
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: titleWelcome.bottom
                    height: 40
                }

                Rectangle {
                    id: fieldUsername

                    width: 250
                    height: 30
                    radius: 20

                    anchors.top: spaceItem2.bottom
                    anchors.horizontalCenter: titleWelcome.horizontalCenter

                    border.color: "lightblue"
                    color: "white"

                    TextField {
                        id: textFieldUsername

                        placeholderText: "Email"

                        anchors {
                            fill: parent
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                            leftMargin: 5
                        }

                        width: parent.width
                        height: parent.height

                        selectByMouse: true

                        verticalAlignment: Text.AlignVCenter

                        background: Rectangle {
                            color: "transparent"
                            radius: 20
                        }
                    }
                }

                Item {
                    id: spaceItem3
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: fieldUsername.bottom
                    height: 10
                }

                Rectangle {
                    id: lineRec

                    visible: false

                    anchors.top: spaceItem3.bottom
                    anchors.horizontalCenter: spaceItem3.horizontalCenter
                    height: 1
                    width: 180
                    color: "lightgrey"
                }

                Item {
                    id: spaceItemLine
                    anchors.horizontalCenter: lineRec.horizontalCenter
                    anchors.top: lineRec.bottom
                    height: 11
                }

                Rectangle {
                    id: fieldPassword
                    width: 250
                    height: 30
                    radius: 20

                    anchors.top: spaceItem3.bottom
                    anchors.horizontalCenter: titleWelcome.horizontalCenter

                    border.color: "#faacac"
                    color: "white"

                    TextField {
                        id: textFieldPassword

                        placeholderText: "Password"

                        anchors {
                            fill: parent
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                            leftMargin: 5
                        }

                        width: parent.width
                        height: parent.height

                        selectByMouse: true

                        verticalAlignment: Text.AlignVCenter

                        background: Rectangle {
                            color: "transparent"
                            radius: 20
                        }

                        echoMode: TextInput.Password
                    }
                }

                Item {
                    id: spaceItem4
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: fieldPassword.bottom
                    height: 15
                }

                Item {
                    id: spaceItem5
                    anchors.right: fieldPassword.right
                    anchors.top: spaceItem4.bottom
                    height: 15
                    width: 40
                }

                CustomButton {
                    id: customEnter

                    visible: true

                    anchors.right: spaceItem5.left
                    anchors.top: spaceItem4.bottom
                    buttonText: "Log in"
                    buttonColorText: "grey"
                    buttonColorBord.color: "lightblue"
                    onClicked: {
                        if (textFieldUsername.text !== "" && textFieldPassword.text !== "")
                        {
                            if (status)
                            {
                                client.logIn(textFieldUsername.text, textFieldPassword.text);
                            }
                            else
                            {
                                errorEnter.visible = true;
                                errorEnter.text = "Connection error";
                            }
                        }
                        else
                        {
                            errorEnter.visible = true;
                            errorEnter.text = "Enter login and password";
                        }
                    }
                }

                Text {
                    id: errorEnter

                    font.pointSize: 10
                    font.bold: true
                    color: "#faacac"
                    visible: false

                    anchors.top: customEnter.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 10
                }

                Connections {
                    target: client
                    onLoginSuccess: {
                        view.push(mainPage);
                        errorEnter.visible = false;
                    }
                    onLoginError: {
                        errorEnter.visible = true;
                        errorEnter.text = enter;
                    }
                }

                Item {
                    id: spaceItem6
                    anchors.left: fieldPassword.left
                    anchors.top: spaceItem4.bottom
                    height: 15
                    width: 40
                }

                CustomButton {
                    id: customReg

                    visible: true

                    anchors.left: spaceItem6.right
                    anchors.top: spaceItem4.bottom
                    buttonText: "Reg"
                    buttonColorText: "grey"
                    buttonColorBord.color: "lightblue"

                    onClicked: {
                        logWin.height += 20;

                        customReg.visible = false;
                        customEnter.visible = false;
                        customRef.visible = false;

                        customCont.visible = true;
                        backRefw.visible = true;
                        fieldPasswordRep.visible = true;
                        lineRec.visible = true;
                        errorNotification.visible = true;

                        spaceItem3.height = 11;
                        fieldPassword.anchors.top = spaceItemLine.bottom;
                        titleWelcome.text = "Sign up";

                        errorEnter.visible = false;
                    }
                }

                Item {
                    id: spaceItem7
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    height: 10
                    width: 10
                }

                CustomButton {
                    id: customRef
                    anchors.left: spaceItem7.right
                    anchors.bottom: spaceItem7.top
                    buttonText: "Ref"
                    buttonColorText: "grey"
                    buttonColorBord.color: "#faacac"
                    onClicked: {
                        view.push(refWin)
                    }
                }

                Item {
                    id: spaceItem9
                    anchors.horizontalCenter: fieldPassword.horizontalCenter
                    anchors.top: fieldPassword.bottom
                    height: 10
                    width: 10
                }

                Item {
                    id: spaceItem11
                    anchors.horizontalCenter: fieldPasswordRep.horizontalCenter
                    anchors.top: fieldPasswordRep.bottom
                    height: 20
                    width: 10
                }

                CustomButton {
                    id: customCont

                    visible: false

                    anchors.top: spaceItem11.bottom
                    anchors.horizontalCenter: spaceItem11.horizontalCenter
                    buttonText: "Continue"
                    buttonColorText: "grey"
                    buttonColorBord.color: "lightblue"

                    onClicked: {
                        if (client.get_connectStatus())
                        {
                            if (textFieldUsername.text !== "")
                            {
                                if (textFieldPassword.text === textFieldPasswordRep.text && textFieldPassword.text !== "" &&
                                        textFieldPasswordRep.text !== "" && textFieldPassword.text.length >= 6 &&
                                        textFieldPassword.text.length >= 6)
                                {
                                    client.registration(textFieldUsername.text, textFieldPassword.text);
                                }

                                else if (textFieldPassword.text === textFieldPasswordRep.text && textFieldPassword.text !== "" &&
                                         textFieldPasswordRep.text !== "")
                                {
                                    errorNotification.text = "Password must contain at least 6 characters";
                                }

                                else if (textFieldPassword.text !== textFieldPasswordRep.text && textFieldPassword.text !== "" &&
                                         textFieldPasswordRep.text !== "")
                                {
                                    errorNotification.text = "Password mismatch";
                                }

                                else
                                {
                                    errorNotification.text = "Enter password";
                                }
                            }
                            else
                            {
                                errorNotification.text = "Enter username";
                            }
                        }
                        else
                        {
                            errorNotification.text = "";
                        }
                    }
                }

                Connections {
                    target: client
                    onRegistrationSuccess: {
                        logWin.height -= 20;

                        customReg.visible = true;
                        customEnter.visible = true;
                        customRef.visible = true;

                        customCont.visible = false;
                        backRefw.visible = false;
                        fieldPasswordRep.visible = false;
                        lineRec.visible = false;
                        errorNotification.visible = false;

                        spaceItem3.height = 10;
                        fieldPassword.anchors.top = spaceItem3.bottom;
                        titleWelcome.text = "Sign in";

                        textFieldPassword.text = "";
                        textFieldPasswordRep.text = "";
                        errorNotification.text = "";
                        errorNotification.visible = false;
                    }
                    onRegistrationError: {
                        errorNotification.visible = true;
                        errorNotification.text = registr;
                    }
                }

                Item {
                    id: spaceIte12

                    anchors.horizontalCenter: customCont.horizontalCenter
                    anchors.top: customCont.bottom

                    width: 5
                    height: 5
                }

                Text {
                    id: errorNotification

                    visible: false

                    text: ""
                    font.bold: true

                    font.pointSize: 10

                    color: "#faacac"

                    anchors.horizontalCenter: spaceIte12.horizontalCenter
                    anchors.top: spaceIte12.bottom
                }

                Item {
                    id: spaceItem10

                    width: 5
                    height: 5
                }

                Button {
                    id: backRefw
                    anchors.left: spaceItem10.right
                    anchors.top: spaceItem10.bottom
                    background: null
                    width: 35
                    height: 35

                    visible: false

                    MouseArea {
                        anchors.fill: parent

                        Text {
                            id: backR
                            anchors.centerIn: parent
                            font.pointSize: 20
                            text: "<"
                            color: "grey"
                        }

                        onClicked: {
                            logWin.height -= 20

                            customReg.visible = true
                            customEnter.visible = true
                            customRef.visible = true
                            errorNotification.visible = false

                            customCont.visible = false
                            backRefw.visible = false
                            fieldPasswordRep.visible = false
                            lineRec.visible = false

                            spaceItem3.height = 10
                            fieldPassword.anchors.top = spaceItem3.bottom
                            titleWelcome.text = "Sign in"

                            errorNotification.text = ""
                        }
                    }
                }

                Rectangle {
                    id: fieldPasswordRep

                    visible: false

                    width: 250
                    height: 30
                    radius: 20

                    anchors.top: spaceItem9.bottom
                    anchors.horizontalCenter: titleWelcome.horizontalCenter

                    border.color: "#faacac"
                    color: "white"

                    TextField {
                        id: textFieldPasswordRep

                        placeholderText: "Repeat password"

                        anchors {
                            fill: parent
                            left: parent.left
                            verticalCenter: parent.verticalCenter
                            leftMargin: 5
                        }

                        width: parent.width
                        height: parent.height

                        selectByMouse: true

                        verticalAlignment: Text.AlignVCenter

                        background: Rectangle {
                            color: "transparent"
                            radius: 20
                        }

                        echoMode: TextInput.Password
                    }
                }
            }
        }
    }

    Page {
        id: refWin

        visible: false

        Rectangle {
            id: refBack
            anchors.fill: parent

            gradient: Gradient {
                GradientStop { position: 0.0; color: "lightblue" }
                GradientStop { position: 1.0; color: "#faacac" }
            }

            Rectangle {
                id: refWinback

                height: 300
                width: 400
                radius: 20
                color: "white"

                anchors.centerIn: parent

                Text {
                    id: waterM
                    anchors.centerIn: parent

                    text: "Приложение сделано Хабибуллиным Русланом"

                    color: "grey"
                }

                Item {
                    id: spaceItem8

                    width: 5
                    height: 5
                }

                Button {
                    anchors.left: spaceItem8.right
                    anchors.top: spaceItem8.bottom
                    background: null
                    width: 35
                    height: 35

                    MouseArea {
                        anchors.fill: parent

                        Text {
                            id: backW
                            anchors.centerIn: parent
                            font.pointSize: 20
                            text: "<"
                            color: "grey"
                        }

                        onClicked: {
                            view.pop()
                        }
                    }
                }

                Button {
                    anchors.horizontalCenter: waterM.horizontalCenter
                    anchors.top: waterM.bottom
                    background: null
                    width: pathW.width

                    MouseArea {
                        anchors.fill: parent

                        Text {
                            id: pathW
                            anchors.centerIn: parent
                            text: "https://github.com/Oceanic-Oracle"
                            color: "lightblue"
                        }

                        onClicked: {
                            Qt.openUrlExternally("https://github.com/Oceanic-Oracle")
                        }
                    }
                }
            }
        }
    }

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
                                }
                            }
                        }
                    }

                    ListView {
                        id: incominglistMessage

                        visible: true

                        anchors.fill: parent
                        topMargin: 40
                        ScrollBar.vertical: ScrollBar {}

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
                                }
                            }
                        }
                    }

                    ListModel {
                        id: incominglistModel

                        ListElement {
                            incomingusername: "User1"
                            incomingtheme: "fgbfgb"
                            incomingmessage: "Hello, bfg"
                            incomingdata: "22.07.12 20:21"
                        }
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
                                    client.sendMessage(textFieldUsername.text, toWriteText.text, themeWriteText.text, messWriteText.text);
                                    errorWrite.visible = false;
                                    toWriteText.clear();
                                    themeWriteText.clear();
                                    messWriteText.clear();
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
                            }
                        }

                        CustomButton {
                            buttonText: "Reply"
                            buttonColorBord.color: "lightblue"
                            buttonColorText: "grey"
                            Layout.alignment: Qt.AlignHCenter
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
}
