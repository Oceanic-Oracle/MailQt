import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle {
    id: root
    property alias buttonText: button.text
    property alias buttonColorText: button.color
    property alias buttonColorBord: root.border
    property alias buttonWidth: root.width
    property alias buttonHeight: root.height
    signal clicked()

    width: 60
    height: 30
    radius: 20
    color: "white"

    Rectangle {
        id: backgroundRect
        color: "White"
        radius: parent.radius
        border.color: parent.border.color

        anchors.fill: parent

        Text {
            id: button
            anchors.centerIn: parent
        }
    }

    Button {
        anchors.fill: parent
        opacity: 0
        text: parent.buttonText
        Rectangle {
            color: "transparent"
            anchors.fill: parent
        }

        onClicked: {
            parent.clicked()
        }
    }
}
