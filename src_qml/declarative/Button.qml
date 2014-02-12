import QtQuick 1.1

Rectangle {
    id: container

    property alias text: buttonText.text
    property variant r: 15
    signal clicked

    height: buttonText.height + 10; width: buttonText.width + 20
    border.width: 0
    radius: r
    smooth: true

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked()
    }

    // Button caption
    Text {
        id: buttonText
        width: parent.width
        anchors.centerIn:parent
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 10
        color: "black"
        text: parent.text
    }
}
