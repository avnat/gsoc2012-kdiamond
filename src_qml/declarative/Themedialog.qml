import QtQuick 1.1

Rectangle{
    id: themeDialog
    width: parent.width
    height: parent.height
    color: "#80000000"

    property alias showDialog: showDialog.running
    property alias hideDialog: hideDialog.running

    MouseArea{
        anchors.fill: parent
        onClicked: {
            // Dismiss theme dialog if clicked outside dialog box
            hideDialog.running = true

            if(paused)
                MainWindow.pauseButton_clicked(false)
            else
                MainWindow.pauseButton_clicked(true)
        }
    }

    /* Theme dialog */
    Rectangle{
        id: dialog
        width: parent.width - 100
        height: parent.height - 10
        anchors.centerIn: parent
        radius: 15
        border.width: 2
        border.color: "black"

        // Model for themeDialog
        ListModel {
            id: themeModel
            ListElement {
                icon: "images/egyptian_preview.png"
                name: "Egyptian"
                description: "Egyptian style theme."
                author: "by Sean Wilson"
            }
            ListElement {
                icon: "images/funny_zoo.png"
                name: "Funny Zoo"
                description: "It is a fun time in the jungle!"
                author: "by Eugene Trounev, Sean Wilson"
            }
            ListElement {
                icon: "images/diamonds.png"
                name: "Diamonds"
                description: "A theme based on real looking diamonds."
                author: "by Eugene Trounev"
            }
        }

        ListView{
            id: dialoglist
            width: parent.width
            spacing: margin
            height:225
            interactive: false
            anchors.top: dialogline.bottom
            anchors.topMargin: margin - 5
            model: themeModel

            // Delegate for themeDialog
            delegate: Rectangle{
                id: listitem
                width: parent.width-10
                height: 70
                anchors.horizontalCenter: parent.horizontalCenter

                //Theme icon
                Image {
                    id: themePreviewImage
                    width:70
                    height: width
                    source: icon
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }

                // Theme name
                Text {
                    id: theme_title
                    text: name
                    font.pixelSize: 14
                    font.bold: true
                    anchors.left: themePreviewImage.right
                    anchors.leftMargin: 10
                }

                // Theme description
                Text {
                    id: theme_description
                    text: description
                    font.pixelSize: 12
                    anchors.top: theme_title.bottom
                    anchors.left: themePreviewImage.right
                    anchors.leftMargin: 10
                }

                // Theme author
                Text {
                    id: theme_author
                    text: author
                    font.pixelSize: 12
                    font.italic: true
                    anchors.top: theme_description.bottom
                    anchors.left: themePreviewImage.right
                    anchors.leftMargin: 10
                }

                // Separator
                Rectangle{
                    id: line
                    width: parent.width
                    height: 1
                    color: "black"
                    anchors.top: themePreviewImage.bottom
                    anchors.topMargin: 5
                }

                MouseArea{
                    id: delegateMouseArea
                    anchors.fill: parent
                    onClicked: {
                        /* New game started */

                        // Change the diamond blocks and background of the board
                        MainWindow.changeTheme(index+1);
                        board.source = MainWindow.getBoardBg();

                        // Dismiss the dialog
                        hideDialog.running = true

                        // Hide pop ups if any
                        hidePopup()

                        // Resume game
                        rightPanel.pause_button.text = "Pause"
                        MainWindow.pauseButton_clicked(false)
                    }
                }
            }
        }

        // Theme dialog title
        Text {
            id: dialogtitle
            font.pixelSize: 20
            font.bold: true
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Select Theme"
        }
        Rectangle{
            id: dialogline
            width: parent.width
            height: 1
            color: "black"
            anchors.top: dialogtitle.bottom
            anchors.topMargin: 5
        }
    }
    PropertyAnimation { id: showDialog; target: themeDialog; property: "opacity"; to: 1; duration: 500; easing.type: Easing.InQuad   }
    PropertyAnimation { id: hideDialog; target: themeDialog; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuad}
}

