import QtQuick 1.0

Rectangle{
    id: mainwindow
    width: 500
    height: 320

    property int margin: 20
    property int buttonRadius: 10
    property int  buttonHeight:40
    property int points: 0
    property int listitem_height: 40
    property variant minutesLeft: 0
    property variant secondsLeft: 0
    property bool paused: true // If paused=false then game state = "Paused" and if paused = true then game state = "Playing"
    property bool finishedGame: false
    property variant gridView

    /* Slot for updating the model */
    function updateModel(newModel){
        board.gridView.model = newModel
    }

    /* Slot for updating Points */
    function updatePoints(newPoints){
        points = newPoints
    }

    /* Slot for updating Time Left */
    function updateRemainingTime(newTime){
        minutesLeft = newTime/60
        secondsLeft = newTime%60
        if(secondsLeft<10){
            secondsLeft = "0" + secondsLeft.toString()
        }

        // Time up, show finished game pop up
        if(newTime==0)
        {
            // Launch the finished game pop up
            finishedGame = true
            finishedGamePopUp.showPopUp = true
            // Disable the game area
            finishedGamePopUp.gameArea = true

            // Disable pause button for finished game state
            rightPanel.pause_button.enabled = false
        }
    }

    /* Slot for hiding pop ups when a new game is started */
    function hidePopup()
    {
        // Resume game if paused before selecting new game
        if(!paused)
        {
            rightPanel.pause_button.text = "Pause"
            pausedPopUp.hidePopUp = true
            pausedPopUp.gameArea = false
            paused = false
            MainWindow.pauseButton_clicked(paused)
        }

        // If previous game finished and new game was started then enable the pause button and the game area for play
        if(finishedGame)
        {
            rightPanel.pause_button.enabled = true
            finishedGamePopUp.hidePopUp = true
            finishedGamePopUp.gameArea = false
            finishedGame=false
        }
    }

    // Left Panel
    LeftPanel{
        id : leftPanel
    }

    // Right Panel
    RightPanel{
        id: rightPanel
    }

    // Board
    Board{
        id: board
        width: mainwindow.width - leftPanel.width - rightPanel.width
        height: parent.height
        anchors.left: leftPanel.right
        anchors.centerIn: parent
    }

    // Pause game pop up
    PopUp{
        id: pausedPopUp
        popUpMessage: "Game paused!"
    }

    // Finished game pop up
    PopUp{
        id: finishedGamePopUp
        popUpMessage: "Game finished!"
    }

    // Model for new game dialog
    ListModel{
        id: newgameModel
        ListElement{
            name: "Timed game"
        }
        ListElement{
            name: "Untimed game"
        }
    }

    // New game dialog
    Listdialog{
        id: newgameDialog
        dialogtitle: "New Game"
        dialogModel: newgameModel
        opacity: 0
        onClicked: {
            /* New game started */

            MainWindow.newGameButton_clicked(index);

            // Dismiss new game dialog
            newgameDialog.hideDialog= true;

            // Hide pop ups if any
            hidePopup()
        }
    }

    // Model for difficulty level dialog
    ListModel{
        id: difficultylevelModel
        ListElement{
            name: "Easy"
        }
        ListElement{
            name: "Medium"
        }
        ListElement{
            name: "Hard"
        }
    }

    // Difficulty level dialog
    Listdialog{
        id: difficultylevelDialog
        dialogtitle: "Difficulty Level"
        dialogModel: difficultylevelModel
        opacity: 0
        onClicked: {
            /* New game started */

            // Hide pop ups if any
            hidePopup()

            if(index == 0)
            {
                board.rows=10;
                board.columns=10;
            }
            else if(index == 1)
            {
                board.rows=8;
                board.columns=8;
            }
            else if(index == 2)
            {
                board.rows=8;
                board.columns=8;
            }
            MainWindow.currentLevelChanged(index)
            difficultylevelDialog.hideDialog = true
        }
    }

    // Quit dialog
    Quitdialog{
        id: quitDialog
        width: parent.width
        height: parent.height
        quitMessage: "Are you sure you want to exit KDiamond?"
        yesButtonText: "Yes"
        noButtonText: "No"
        onYes_clicked: Qt.quit();
        onNo_clicked: {
            // Dismiss the quit dialog
            hideDialog= true;

            // Resume the game
            MainWindow.pauseButton_clicked(false);
        }

        opacity: 0
    }

    // Theme dialog
    Themedialog{
        id: themeDialog
        width: parent.width
        height: parent.height
        opacity: 0
    }

    // About dialog
    AboutDialog{
        id: aboutDialog
        width: parent.width
        height: parent.height
        opacity: 0
    }
}
