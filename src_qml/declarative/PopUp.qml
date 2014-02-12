import QtQuick 1.1

Rectangle{
    id: popUpContainer
    height: board.height
    width: board.width
    anchors.left: board.left
    anchors.leftMargin: margin
    anchors.top: parent.top
    color: "transparent"

    property int margin: 5

    MouseArea{
        id: gameArea
        anchors.fill: parent
        onClicked: {}
        enabled: false
    }

    property alias popUpMessage: popUpMessage.text
    property alias gameArea: gameArea.enabled
    property alias showPopUp: showPopUp.running
    property alias hidePopUp: hidePopUp.running

    Rectangle{
        id: popUp
        height: popUpMessage.height+10
        width: popUpMessage.width+20
        anchors.top: parent.top
        anchors.topMargin: margin
        opacity: 0
        radius: 5
        color: "#80000000"
        border.color: "gray"

        Text{
            id: popUpMessage
            parent: popUp
            anchors.top: parent.top
            anchors.topMargin: margin
            anchors.left: parent.left
            anchors.leftMargin: margin
            color: "white"
            font.pixelSize: 14
        }

        // Animating Pop up
        PropertyAnimation { id: showPopUp; target: popUp; property: "opacity"; to: 1; duration: 500; easing.type: Easing.Linear}
        PropertyAnimation { id: hidePopUp; target: popUp; property: "opacity"; to: 0; duration: 500; easing.type: Easing.Linear}
    }

}
