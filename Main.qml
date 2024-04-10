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

    AuthPage {
        id: authWin
    }

    RefPage {
        id: refWin
    }

    MessPage {
        id: mainPage
    }
}
