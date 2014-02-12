import QtQuick 1.1

Rectangle{
    id: rightPanel
    width: 90
    height: parent.height

    property alias pause_button: pause_button

    gradient: Gradient {
        GradientStop { position: 0.0; color: "#999999" }
        GradientStop { position: 0.5; color: "#666666" }
        GradientStop { position: 1.0; color: "#000000" }
    }
    anchors.right: parent.right

    /* Points Label*/
    Text{
        id: pointsLabel
        color: "white"
        font.pixelSize: 14
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: margin

        text: "Points"
    }
    Text{
        id: pointsText
        color: "white"
        font.pixelSize: 14
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: pointsLabel.bottom
        anchors.topMargin: 5

        text: points
    }

    // Separator
    Rectangle{
        id: line4
        width: parent.width
        height: 1
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: pointsText.bottom
        anchors.topMargin: margin
    }

    /* Time Left Label */
    Text{
        id: timeLabel
        color: "white"
        font.pixelSize: 14
        font.bold: true
        anchors.top: line4.bottom
        anchors.topMargin: margin
        anchors.horizontalCenter: parent.horizontalCenter

        text: "Time left"
    }
    Text{
        id: timeText
        color: "white"
        font.pixelSize: 14
        font.bold: true
        anchors.top: timeLabel.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter

        text: parseInt(minutesLeft) + ":" + secondsLeft
    }

    // Separator
    Rectangle{
        id: line5
        width: parent.width
        height: 1
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: timeText.bottom
        anchors.topMargin: margin
    }

    // Pause button
    Button{
        id: pause_button
        width: parent.width-15
        height: buttonHeight
        radius: buttonRadius
        anchors.top: line5.bottom
        anchors.topMargin: margin
        anchors.horizontalCenter: parent.horizontalCenter

        text: "Pause"
        onClicked: {
            MainWindow.pauseButton_clicked(paused)
            swapPauseState()
        }
    }

    /* Swaps the pause state & pause button's text, enables-disables game area, launches-hides pause pop up*/
    function swapPauseState()
    {
        if (paused==true)
        {
            paused = false
            pause_button.text = "Resume"
            pausedPopUp.showPopUp = true
            // Disabling game area when game is paused
            pausedPopUp.gameArea = true
        }
        else {
            paused = true
            pause_button.text = "Pause"
            pausedPopUp.hidePopUp = true
            // Enabling game area when resumed
            pausedPopUp.gameArea = false
        }
    }

    // Separator
    Rectangle{
        id: line6
        width: parent.width
        height: 1
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: pause_button.bottom
        anchors.topMargin: margin
    }

    // Difficulty level button
    Button{
        id: difficultyLevel_button
        width: parent.width-15
        height: buttonHeight
        radius: buttonRadius
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: line6.bottom
        anchors.topMargin: margin

        text: "Difficulty \nLevel"
        onClicked:{
            // Launching difficulty level dialog box and pausing the game
            difficultylevelDialog.showDialog = true
            MainWindow.pauseButton_clicked(true)
        }
    }

    // Separator
    Rectangle{
        id: line7
        width: parent.width
        height: 1
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: difficultyLevel_button.bottom
        anchors.topMargin: margin
    }
}
