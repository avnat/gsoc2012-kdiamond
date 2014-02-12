import QtQuick 1.1

Image {
    id: board
    width: 320
    height: 320

    property int current_diamond: -1 // stores index of current diamond
    property int pre_diamond: -1 // stores index of previous diamond
    property int clickedBool: -1 // stores index of clicked diamond
    property int pressedBool: -1 // stores index of pressed diamond
    property int releasedBool: -1 // stores index of released diamond
    property int rows: 8
    property int columns: 8
    property int flag: 0

    property alias gridView: gridView
    source: MainWindow.getBoardBg();

    // gridView delegate
    Component{
        id: boardItemDelegate
        // diamond image
        Image{
            id: boardItem
            width: gridView.width/columns
            height: width
            source: modelData

            MouseArea{
                id: boardItemMouseArea
                anchors.fill: parent
                hoverEnabled: true
                enabled: true
                onClicked: {
                    clickedBool = 1
                }
                onReleased: {
                    pre_diamond = current_diamond
                    current_diamond = index
                    releasedBool = 1
                }
                onPressed: {
                    pressedBool  = 1
                }
                onEntered: {
                    // Checking whether the diamond is dragged or not
                    if (pressedBool==1 && releasedBool==1 && clickedBool==0){
                        pre_diamond = current_diamond
                        current_diamond = index
                        pressedBool = 0
                        releasedBool =0

                        // Checking if the diamonds are ajacent
                        if (current_diamond - pre_diamond == -1 ||
                                current_diamond - pre_diamond == 1 ||
                                current_diamond - pre_diamond == -columns ||
                                current_diamond - pre_diamond == columns)
                        {
                            flag =1

                        }

                    }
                    clickedBool = 0
                }
            }
        }
    }


    // Grid of diamonds
    GridView {
        id: gridView
        width: parent.width
        height: parent.height
        interactive: false
        model: MainWindow.getModel();
        anchors.fill: parent
        cellWidth: width/columns;
        cellHeight: height/rows

        delegate: boardItemDelegate

        Timer {
            interval: 100; running: true; repeat: true
            onTriggered: {
                if (flag ===1)
                {
                    // Swapping the diamonds' positions
                    MainWindow.makeMove(pre_diamond, current_diamond)

                    // Checking similar adjacent diamonds after move
                    MainWindow.check_move()
                    flag =0
                }
            }
        }
    }
}
