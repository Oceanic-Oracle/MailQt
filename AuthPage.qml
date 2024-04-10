import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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

            CustomTextField {
                id: fieldUsername

                borderfield.color: "lightblue"
                placeholderField: "Email"

                anchors.top: spaceItem2.bottom
                anchors.horizontalCenter: titleWelcome.horizontalCenter
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

            CustomTextField {
                id: fieldPassword

                borderfield.color: "#faacac"
                placeholderField: "Password"
                echo: TextInput.Password

                anchors.top: spaceItem3.bottom
                anchors.horizontalCenter: titleWelcome.horizontalCenter
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
                    if (fieldUsername.text !== "" && fieldPassword.text !== "")
                    {
                        client.logIn(fieldUsername.text, fieldPassword.text);
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
                    if (fieldUsername.text !== "")
                    {
                        if (fieldPassword.text === fieldPassword.text && fieldPassword.text !== "" &&
                                fieldPasswordRep.text !== "" && fieldPassword.text.length >= 6 &&
                                fieldPassword.text.length >= 6)
                        {
                            client.registration(fieldUsername.text, fieldPassword.text);
                        }

                        else if (fieldPassword.text === fieldPasswordRep.text && fieldPassword.text !== "" &&
                                 fieldPasswordRep.text !== "")
                        {
                            errorNotification.text = "Password must contain at least 6 characters";
                        }

                        else if (fieldPassword.text !== fieldPasswordRep.text && fieldPassword.text !== "" &&
                                 fieldPasswordRep.text !== "")
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

                    fieldPassword.text = "";
                    fieldPasswordRep.text = "";
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

            CustomTextField {
                id: fieldPasswordRep

                borderfield.color: "#faacac"
                placeholderField: "Repeat password"
                echo: TextInput.Password
                visible: false

                anchors.top: spaceItem9.bottom
                anchors.horizontalCenter: titleWelcome.horizontalCenter
            }
        }
    }
}
