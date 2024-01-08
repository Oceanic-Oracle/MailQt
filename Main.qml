import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root

    width: 640
    height: 480
    visible: true
    title: qsTr("mail")

    Rectangle {
        id: backgroundrec
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
                id: spaceItem
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
            }

            Text {
                id: titleWelcome
                text: "Sign in"
                font.bold: true

                font.pointSize: 20

                color: "lightblue"

                anchors.horizontalCenter: spaceItem.horizontalCenter
                anchors.top: spaceItem.bottom
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
                anchors.left: spaceItem6.right
                anchors.top: spaceItem4.bottom
                buttonText: "Reg"
                buttonColorText: "grey"
                buttonColorBord.color: "lightblue"
                onClicked: {
                    view.push()
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
                    view.push()
                }
            }
        }
    }
}
