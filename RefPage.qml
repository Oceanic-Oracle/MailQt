import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
