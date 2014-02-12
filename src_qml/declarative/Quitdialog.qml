import QtQuick 1.1

Rectangle{
    id: quitDialog
    width: parent.width
    height: parent.height
    color: "#80000000"

    property alias quitMessage: dialogDesc.text
    property alias yesButtonText: button_yes_text.text
    property alias noButtonText: button_no_text.text

    property alias showDialog: showDialog.running
    property alias hideDialog: hideDialog.running

    signal yes_clicked
    signal no_clicked

    MouseArea{
        anchors.fill: parent
        onClicked: {
            // Dismiss the dialog if clicked outside the dialog box
            hideDialog.running = true

            // Resume the game
            if(paused)
            MainWindow.pauseButton_clicked(false)
        }
    }

    Rectangle{
        id: dialog
        width: parent.width - 200
        height: parent.height/2
        anchors.centerIn: parent
        radius: 15
        border.width: 2
        border.color: "black"
        Text{
            id: title
            text: "Quit"
            font.pixelSize: 20
            font.bold: true
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle{
            id: dialogline
            width: parent.width
            height: 1
            color: "black"
            anchors.top: title.bottom
            anchors.topMargin: 5
        }

        // Quit dialog text
        Text{
            id: dialogDesc
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: dialogline.bottom
            anchors.topMargin: 10
            font.pixelSize: 14
        }

        /* Yes button */
        Button{
            id:yes_button
            width: 100
            height: 50
            color: "teal"
            anchors.top: dialogDesc.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 30

            Text {
                id: button_yes_text
                anchors.centerIn: parent
                font.pixelSize: 14
                font.bold: true
                color: "white"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    quitDialog.yes_clicked();
                }
            }
        }

        /* No button */
        Button{
            id:no_button
            width: 100
            height: 50
            color: "teal"
            anchors.left: yes_button.right
            anchors.leftMargin: 20
            anchors.top: dialogDesc.bottom
            anchors.topMargin: 20

            Text {
                id: button_no_text
                anchors.centerIn: parent
                font.pixelSize: 14
                font.bold: true
                color: "white"
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    quitDialog.no_clicked();
                }
            }
        }

    }

    // Animating the quit dialog
    PropertyAnimation { id: showDialog; target: quitDialog; property: "opacity"; to: 1; duration: 500; easing.type: Easing.InQuad   }
    PropertyAnimation { id: hideDialog; target: quitDialog; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuad}
}
