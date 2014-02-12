import QtQuick 1.1

Rectangle{
    id: aboutDialog
    width: parent.width
    height: parent.height
    color: "#80000000"


    property alias showDialog: showDialog.running
    property alias hideDialog: hideDialog.running


    MouseArea{
        anchors.fill: parent
        onClicked: {

            // Hide the dialog box if clicked outside
            hideDialog.running = true

            // Resume the game as soon as Dialog is hidden
            if(paused)
                MainWindow.pauseButton_clicked(false)
        }
    }

    Rectangle{
        id: dialog
        width: parent.width - 200
        height: parent.height- 50
        anchors.centerIn: parent
        radius: 15
        border.width: 2
        border.color: "black"
        MouseArea{
            anchors.fill: parent
        }


        Text {
            id: aboutText
            text: qsTr("KDiamond, a three-in-a-row game.")
            font.pixelSize: 14
            font.bold: true
            anchors.top: dialogline.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // KDiamond version information
        Text {
            id: version
            text: qsTr("Version 1.0 (QML Version)")
            font.pixelSize: 14
            font.italic: true
            anchors.top: aboutText.bottom
            anchors.left: parent.left
            anchors.leftMargin: 40
        }

        Text {
            id: authorsTitle
            text: qsTr("Authors:")
            font.pixelSize: 12
            font.bold: true
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.top: version.bottom
            anchors.topMargin: 10
        }

        // KDiamond authors
        Text{
            id: authors
            text: qsTr("Stefan Majewsky (Original author) \nPaul Bunbury (Gameplay refinement) \nAvnee Nathani (QML author)")
            font.pixelSize: 12
            anchors.top: authorsTitle.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text{
            id: thanksToTitle
            text: qsTr("Thanks to:")
            font.pixelSize: 12
            font.bold: true
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.top: authors.bottom
            anchors.topMargin: 10
        }

        // Thanks to...
        Text{
            id: thanksTo
            text: qsTr("Ian Wadham (GSoC mentor) \nDavid Edmundson (GSoC mentor) \nEugene Trounev (Diamonds theme) \nFelix Lemke (Classic theme) \nJeffery Kelling (Technical consultant)")
            font.pixelSize: 12
            anchors.top: thanksToTitle.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: dialogtitle
            font.pixelSize: 20
            font.bold: true
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            text: "About KDiamond"
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

    // Animating about dialog
    PropertyAnimation { id: showDialog; target: aboutDialog; property: "opacity"; to: 1; duration: 500; easing.type: Easing.InQuad   }
    PropertyAnimation { id: hideDialog; target: aboutDialog; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuad}
}

