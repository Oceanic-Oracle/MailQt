import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: fieldUsername

    property alias text: textFieldUsername.text
    property alias borderfield: fieldUsername.border
    property alias placeholderField: textFieldUsername.placeholderText
    property alias echo: textFieldUsername.echoMode


    width: 250
    height: 30
    radius: 20

    color: "white"

    TextField {
        id: textFieldUsername

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
