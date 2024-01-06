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
        initialItem: pageUser
    }

    Rectangle {
        id: backgroundrec
        anchors.fill: parent
        rotation: 45

        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightblue" }
            GradientStop { position: 1.0; color: "red" }
        }

        CustomPage {
            anchors.centerIn: root
            ColumnLayout {
                anchors.fill: root

                Text {
                    id: labelSignin

                    text: "Sign in"
                }

                Item {
                    id: logIn

                    anchors.top: labelSignin.bottom
                    anchors.fill: mainWin
                    Text {
                        id: labelLog
                        text: "Login"
                    }

                    TextField {
                        anchors.left: labelLog.right
                        placeholderText: "Enter ur log"
                    }
                }

                Item {
                    anchors.top: logIn.bottom
                    Text {
                        text: "Password"
                    }

                    TextField {
                        placeholderText: "Enter ur password"
                    }
                }
            }
        }
    }
}
