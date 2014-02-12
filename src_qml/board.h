#ifndef Board_H
#define Board_H
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/qdeclarative.h>
#include <QDeclarativeView>
#include <kdeclarative.h>
#include <QStringList>
#include <QApplication>
#include <QtCore/QDebug>
#include <KDebug>


#include "../src_common/game-state.h"

enum DifficultyLevel
{
    Easy,
    Medium,
    Hard
};
static int boardSizes[] = {10,8,8};
static int diamondCount[] = {5,5,6};

class Board : public QObject
{
    Q_OBJECT
public:
    explicit Board(QObject *parent = 0);
    ~Board();
signals:
    void updateModel(QVariant); // Slot to update QML's gridView model
    void addPoints(int points);
public slots:
    QStringList getModel(); // Returns list of image sources of diamonds
    void makeMove(int prev_diamond, int current_diamond); // Swaps positions of two diamonds
    void check_move(); // Checking if it is row move or a column move

public:
    void setDiamonds(); // Setting up the iBoarditemList, iBoarditemList_int such that no 3 similar diamonds are adjacent
    int getRow(int); // Returns the row index of diamond
    int getColumn(int); // Returns the column index of diamond
    int rowMove(int row_index); // Checking similar diamonds for row move
    int colMove(int col_index); // Checking similar diamonds for column move
    void fillGaps_rows(QList<int> aSameList); // Fill gaps from top in rows
    void fillGaps_columns(QList<int> aSameList); // Fill gaps from top in columns
    void generateDiamonds(QList<int> aList); // Generating new diamonds at given list of indices
    void InitializeNewGame(); // New game started
    void ChangeDifficultlyLevel(int difficultyLevel); // Difficulty Level changed
    QString getBoardBg();
    void changeTheme(int theme); // Game theme changed

private:
    QStringList iBoarditemList; // List of image sources of diamonds in the gridView
    QList<int> iBoarditemList_int; // List of random numbers(0,1,2,3 or 4) associated with diamonds in iBoarditemList
    QStringList diamondList; // List of image paths of diamonds
    QDeclarativeContext *ctxt;
    QObject *rootObject;
    QDeclarativeView view;
    KDeclarative kdeclarative;
    int iPreDiamond, iCurrDiamond; // Stores the index of previous diamond and current diamond

    KDiamond::GameState* m_gameState;
    DifficultyLevel iDifficultyLevel;

    QString iBoardBg;
};

#endif // Board_H
