import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root

    width: 640
    height: 480
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
                        view.push()                        
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
                        logWin.height += 20

                        customReg.visible = false
                        customEnter.visible = false
                        customRef.visible = false

                        customCont.visible = true
                        backRefw.visible = true
                        fieldPasswordRep.visible = true
                        lineRec.visible = true
                        errorNotification.visible = true

                        spaceItem3.height = 11
                        fieldPassword.anchors.top = spaceItemLine.bottom
                        titleWelcome.text = "Sign up"
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
                        if (textFieldUsername.text !== "") {
                            if (textFieldPassword.text === textFieldPasswordRep.text && textFieldPassword.text !== "" &&
                                    textFieldPasswordRep.text !== "" && textFieldPassword.text.length >= 6 &&
                                    textFieldPassword.text.length >= 6) {

                                logWin.height -= 20

                                customReg.visible = true
                                customEnter.visible = true
                                customRef.visible = true

                                customCont.visible = false
                                backRefw.visible = false
                                fieldPasswordRep.visible = false
                                lineRec.visible = false
                                errorNotification.visible = false

                                spaceItem3.height = 10
                                fieldPassword.anchors.top = spaceItem3.bottom
                                titleWelcome.text = "Sign in"

                                textFieldPassword.text = ""
                                textFieldPasswordRep.text = ""
                                errorNotification.text = ""
                            }

                            else if (textFieldPassword.text === textFieldPasswordRep.text && textFieldPassword.text !== "" &&
                                     textFieldPasswordRep.text !== "") {
                                errorNotification.text = "Password must contain at least 6 characters"
                            }

                            else if (textFieldPassword.text !== textFieldPasswordRep.text && textFieldPassword.text !== "" &&
                                     textFieldPasswordRep.text !== "") {
                                errorNotification.text = "Password mismatch"
                            }

                            else {
                                errorNotification.text = "Enter password"
                            }
                        }
                        else {
                            errorNotification.text = "Enter username"
                        }
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
}
