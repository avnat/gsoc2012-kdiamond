import QtQuick 1.1

Rectangle{
    id: listdialog
    width: parent.width
    height: parent.height
    color: "#80000000"

    property alias dialogModel: dialoglist.model
    property alias dialogtitle: dialogtitle.text
    signal clicked (string item_string, int index)
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
        height: dialoglist.height + dialoglist.anchors.topMargin + dialogtitle.height + dialogline.height+ dialogtitle.anchors.topMargin  + dialogline.anchors.topMargin //parent.height - 100
        anchors.centerIn: parent
        radius: 15
        border.width: 2
        border.color: "black"
        MouseArea{
            anchors.fill: parent
        }


        ListView{
            id: dialoglist
            width: parent.width
            spacing: margin
            height:model.count*(listitem_height+spacing)
            interactive: false
            anchors.top: dialogline.bottom
            anchors.topMargin: margin
            model: mymodel
            onModelChanged: {
                dialoglist.height = dialoglist.model.count*(listitem_height+spacing)
            }

            delegate: Rectangle{
                id: listitem
                width: parent.width - 50
                height: listitem_height
                radius: 10
                anchors.horizontalCenter: parent.horizontalCenter
                color: "teal"

                Text {
                    id: listitemText
                    text: name
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "white"
                }

                MouseArea{
                    id: delegateMouseArea
                    anchors.fill: parent
                    onClicked: {
                        listdialog.clicked(name, index)
                    }
                }
            }

        }
        Text {
            id: dialogtitle
            font.pixelSize: 20
            font.bold: true
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
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

    // Animating list dialog
    PropertyAnimation { id: showDialog; target: listdialog; property: "opacity"; to: 1; duration: 500; easing.type: Easing.InQuad   }
    PropertyAnimation { id: hideDialog; target: listdialog; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuad}
}
