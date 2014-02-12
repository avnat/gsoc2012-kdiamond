#include "board.h"
#include <QGraphicsObject>

// Defining the number of rows and columns in the grid
int ROWS =8;
int COLUMNS=8;
int BOARD_ITEMS =ROWS*COLUMNS;
int DIAMOND_COUNT = 5;
#define MIN_MATCHES 3
#define MAX_MATCHES 5

Board::Board(QObject *parent) :
    QObject(parent),
    iDifficultyLevel(Medium)
{
    // Empty the string lists
    iBoarditemList.clear();
    iBoarditemList_int.clear();

    changeTheme(3);

    // Initializing iBoarditemList with diamonds
    setDiamonds();
}

Board::~Board()
{
}

void Board::setDiamonds()
{
    /* Setting up the iBoarditemList, iBoarditemList_int such
       that no 3 similar diamonds are adjacent */

    // Keeping track of past 3 generated diamonds
    int random_number = -1;
    int last_random_number = -1;
    int pre_last_random_number = -1;

    QTime time = QTime::currentTime();
    qsrand((uint)time.msec());
    while(iBoarditemList_int.length()<BOARD_ITEMS)
    {
        // Generating random diamonds
        random_number = qrand()%DIAMOND_COUNT;

        // Conditions checking that no 3 similar diamonds should be adjacent
        // checking rows
        if(iBoarditemList_int.length()>1)
        {
            if(random_number == last_random_number && last_random_number == pre_last_random_number)
                continue;
        }
        // checking columns
        if(getRow(iBoarditemList_int.length())>1)
        {
            if(random_number == iBoarditemList_int[iBoarditemList_int.length()-COLUMNS] && random_number == iBoarditemList_int[iBoarditemList_int.length()-(2*COLUMNS)])
                continue;
        }

        // Appending image source to iBoarditemList according to the random_number generated
        iBoarditemList.append(diamondList.at(random_number));
        // Appending random number to iBoarditemList_int
        iBoarditemList_int.append(random_number);

        pre_last_random_number = last_random_number;
        last_random_number = random_number;
    }
}

QStringList Board::getModel()
{
    /* Returns list of image sources of diamonds */

    return iBoarditemList;
}

void Board::makeMove(int prev_diamond, int current_diamond)
{
    /* Swaping positions of 2 diamonds after user's move */

    iPreDiamond = prev_diamond;
    iCurrDiamond = current_diamond;
    iBoarditemList.swap(prev_diamond, current_diamond);
    iBoarditemList_int.swap(prev_diamond, current_diamond);
    //Updating gridView model
    updateModel(iBoarditemList);
}

void Board::check_move()
{
    /* Checking if it is row move or a column move */

    // Stores the row and column index of previous diamond and current diamond
    int pre_row, pre_col, curr_row, curr_col;

    pre_row = getRow(iPreDiamond);
    pre_col = getColumn(iPreDiamond);
    curr_row = getRow(iCurrDiamond);
    curr_col = getColumn(iCurrDiamond);

    // Stores 1 if similar diamonds were found during row or column move else 0
    int tmp1 = 0, tmp2 = 0, tmp3 = 0;

    // Row operation
    if (pre_row == curr_row)
    {
        tmp1=rowMove(pre_row);
        tmp2=colMove(pre_col);
        tmp3=colMove(curr_col);

        // Swap diamonds only if there are 3 similar diamonds adjacent
        if(tmp1==1 && tmp2==1 && tmp3==1)
        {
            iBoarditemList.swap(iCurrDiamond,iPreDiamond);
            iBoarditemList_int.swap(iCurrDiamond,iPreDiamond);
            //Updating gridView model
            updateModel(iBoarditemList);
        }
    }

    // Column operation
    else if (pre_col == curr_col)
    {
        tmp1=colMove(pre_col);
        tmp2=rowMove(curr_row);
        tmp3=rowMove(pre_row);

        // Swap diamonds only if there are similar diamonds adjacent
        if(tmp1==1 && tmp2==1 && tmp3==1)
        {
            iBoarditemList.swap(iCurrDiamond,iPreDiamond);
            iBoarditemList_int.swap(iCurrDiamond,iPreDiamond);
            //Updating gridView model
            updateModel(iBoarditemList);
        }
    }
}

void Board::fillGaps_rows(QList<int> aSameList)
{
    /* Fill gaps from top in rows */

    QList<int> empty_diamonds_List, zero_row_List;
    for (int i=0; i<aSameList.count(); i++)
    {
        if (getRow(aSameList.at(i)) != 0)
        {
            iBoarditemList_int[aSameList.at(i)] = iBoarditemList_int[aSameList.at(i)-COLUMNS];
            iBoarditemList[aSameList.at(i)] = iBoarditemList[aSameList.at(i)-COLUMNS];
            if (aSameList.at(i)-COLUMNS>=0)
            {
                empty_diamonds_List.append(aSameList.at(i)-COLUMNS);
            }
        }
        else if (getRow(aSameList.at(i)) == 0)
        {
            zero_row_List.append(aSameList.at(i));
        }
    }

    updateModel(iBoarditemList);

    if (empty_diamonds_List.length()>0)
    {
        fillGaps_rows(empty_diamonds_List);
    }
    // Generating new diamonds for the 0th row of the grid
    if (zero_row_List.length()>0)
    {
        generateDiamonds(zero_row_List);
    }

}


void Board::fillGaps_columns(QList<int> aSameList)
{
    /* Fill gaps from top in columns */

    QList<int> zero_row_List;
    for (int i=0; i<aSameList.count(); i++)
    {
        if (aSameList.at(i)-(COLUMNS*aSameList.length())>=0)
        {
            iBoarditemList_int[aSameList.at(i)] = iBoarditemList_int[aSameList.at(i)-(COLUMNS*aSameList.length())];
            iBoarditemList[aSameList.at(i)] = iBoarditemList[aSameList.at(i)-(COLUMNS*aSameList.length())];
            zero_row_List.append(aSameList.at(i)-(COLUMNS*aSameList.length()));
        }
        else
        {
            zero_row_List.append(aSameList.at(i));
        }
    }
    updateModel(iBoarditemList);
    // Generating new diamonds for the top most diamonds in columns
    if (zero_row_List.length()>0)
    {
        generateDiamonds(zero_row_List);
    }

}

int Board::rowMove(int row_index)
{
    /* Checking similar diamonds for row move */

    // Stores indices of similar diamonds
    QList<int> SameList;

    int count=0; int index =-1;
    for (int i =(row_index*COLUMNS)+1; i<(row_index+1)*COLUMNS; i++)
    {
        if (iBoarditemList_int.at(i-1)==iBoarditemList_int.at(i))
        {
            index = i;
            count++;
        }
        else{
            if (count>=MIN_MATCHES-1)
            {
                for (int i=0; count>-1; count--, i++)
                {
                    SameList.append(index-i);
                }
            }
            count =0;
        }
    }

    // for the last element in the row
    if (count>=MIN_MATCHES-1)
    {
        for (int i=0; count>-1; count--, i++)
        {
            SameList.append(index-i);
        }
    }


    if (SameList.count()>=MIN_MATCHES){
        // emit signal for adding score to gamestate in the parent
        emit addPoints(SameList.count());
    }
    else
    {
        // No 3 similar diamonds found adjacent return 1 else 0
        return 1;
    }

    fillGaps_rows(SameList);
    return 0;
}

int Board::colMove(int col_index)
{
    /* Checking similar diamonds for column move */

    // Stores indices of similar diamonds
    QList<int> SameList;

    int count=0; int index =-1;
    for (int i = col_index+COLUMNS; i<=col_index+COLUMNS*(COLUMNS-1); i=i+COLUMNS)
    {
        if (iBoarditemList_int.at(i-COLUMNS)==iBoarditemList_int.at(i))
        {
            index = i;
            count++;
        }
        else{
            if (count>=MIN_MATCHES-1)
            {
                for (int i=0; count>-1; count--, i=i+COLUMNS)
                {
                    SameList.append(index-i);
                }
            }
            count =0;
        }
    }

    // for the last element in the row
    if (count>=MIN_MATCHES-1)
    {
        for (int i=0; count>-1; count--, i=i+COLUMNS)
        {
            SameList.append(index-i);
        }
    }

    if (SameList.count()>=MIN_MATCHES){
        // Emit signal for adding score to gamestate in the parent
        emit addPoints(SameList.count());
    }
    else
    {
        // No 3 similar diamonds found adjacent return 1 else 0
        return 1;
    }

    fillGaps_columns(SameList);
    return 0;
}

void Board::generateDiamonds(QList<int> aList)
{
    /* Generating new diamonds at given list of indices */

    int last_random_number = -1;
    int random_number = -1;
    int i =0;
    QTime time = QTime::currentTime();
    qsrand((uint)time.msec());
    while(i<aList.length())
    {
        last_random_number = random_number;
        random_number = qrand()%DIAMOND_COUNT;
        if (random_number != last_random_number)
        {
            iBoarditemList[aList.at(i)] = diamondList.at(random_number);
            iBoarditemList_int[aList.at(i)] = random_number;
            i++;
        }
    }
    updateModel(iBoarditemList);

    // Rechecking rows for similar diamonds after generation
    for (int i=ROWS-1; i>=0; i--)
    {
        rowMove(i);
    }

    // Rechecking columns for similar diamonds after generation
    for(int i=COLUMNS-1;i>=0;i--)
    {
        colMove(i);
    }
}

int Board::getRow(int diamondIndex)
{
    /* Returns row number of diamond */
    return diamondIndex/COLUMNS;
}

int Board::getColumn(int diamondIndex)
{
    /* Returns column number of diamond */
    return diamondIndex%COLUMNS;
}


void Board::InitializeNewGame()
{
    /* Initializes a new game, clear all the previous lists and variables*/

    iBoarditemList.clear();
    iBoarditemList_int.clear();
    iPreDiamond = -1;
    iCurrDiamond = -1;
    setDiamonds();
    updateModel(iBoarditemList);
}


void Board::ChangeDifficultlyLevel(int difficultyLevel)
{
    /* Change the difficulty level of the game*/

    iDifficultyLevel = DifficultyLevel(difficultyLevel);
    ROWS = boardSizes[difficultyLevel];
    COLUMNS = boardSizes[difficultyLevel];
    BOARD_ITEMS = ROWS * COLUMNS;
    DIAMOND_COUNT = diamondCount[difficultyLevel];
    InitializeNewGame();
}

QString Board::getBoardBg()
{
    /* Return the background of the theme */
    return iBoardBg;
}

void Board::changeTheme(int theme)
{
    /* Change Theme */

    diamondList.clear();

    // Theme - Egyptian
    if (theme==1)
    {
        diamondList<<"images/egyptian/1.png"
                  <<"images/egyptian/2.png"
                 <<"images/egyptian/3.png"
                <<"images/egyptian/4.png"
               <<"images/egyptian/5.png"
              <<"images/egyptian/6.png";

        iBoardBg = "images/egyptian/egyptian_bg.png";

    }

    // Theme - Funny zoo
    else if (theme==2)
    {
        diamondList<<"images/zoo/1.png"
                  <<"images/zoo/2.png"
                 <<"images/zoo/3.png"
                <<"images/zoo/4.png"
               <<"images/zoo/5.png"
              <<"images/zoo/6.png";

        iBoardBg = "images/zoo/zoo_bg.png";
    }

    // Theme - Diamonds
    else{
        diamondList<<"images/diamonds/1.png"
                  <<"images/diamonds/2.png"
                 <<"images/diamonds/3.png"
                <<"images/diamonds/4.png"
               <<"images/diamonds/5.png"
              <<"images/diamonds/6.png";

        iBoardBg = "images/diamonds/diamond_bg.png";
    }
}
