import QtQuick 1.1

Rectangle{
    id: leftPanel
    width: 90
    height: parent.height

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#999999" }
        GradientStop { position: 0.5; color: "#666666" }
        GradientStop { position: 1.0; color: "#000000" }
    }
    anchors.left: parent.left

    // New game button
    Button{
        id: newGame_button
        width: parent.width-15
        height: buttonHeight
        radius: buttonRadius
        anchors.top: parent.top
        anchors.topMargin: margin
        anchors.horizontalCenter: parent.horizontalCenter

        text: "New Game"
        onClicked:{
            // Launching new game dialog box and hiding all the pop ups
            newgameDialog.showDialog = true
        }

    }

    // Separator
    Rectangle{
        id: line1
        width: parent.width
        height: 1
        color: "black"
        anchors.top: newGame_button.bottom
        anchors.topMargin: margin
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // Options button
    Button{
        id: options_button
        width: parent.width-15
        height: buttonHeight
        radius: buttonRadius
        anchors.top: line1.bottom
        anchors.topMargin: margin
        anchors.horizontalCenter: parent.horizontalCenter

        text: "Options"
        // Launching options dialog box and pausing the game
        onClicked:{
            themeDialog.showDialog = true
            // Pause the game
            MainWindow.pauseButton_clicked(true)
        }
    }

    // Separator
    Rectangle{
        id: line2
        width: parent.width
        height: 1
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: options_button.bottom
        anchors.topMargin: margin
    }

    // About button
    Button{
        id: about_button
        width: parent.width-15
        height: buttonHeight
        radius: buttonRadius
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: line2.bottom
        anchors.topMargin: margin

        text: "About"
        onClicked:{
            aboutDialog.showDialog= true
            // Pause the game
            MainWindow.pauseButton_clicked(true)
        }

    }

    // Separator
    Rectangle{
        id: line3
        width: parent.width
        height: 1
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: about_button.bottom
        anchors.topMargin: margin
    }

    // Quit button
    Button{
        id: quit_button
        width: parent.width-15
        height: buttonHeight
        radius: buttonRadius
        anchors.top: line3.bottom
        anchors.topMargin: margin
        anchors.horizontalCenter: parent.horizontalCenter

        text: "Quit"
        onClicked: {
            //  Launching quit dialog box
            quitDialog.showDialog = true

            // Pause game
            MainWindow.pauseButton_clicked(true)
        }
    }
}
