#ifndef MainWindow_H
#define MainWindow_H
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
#include "board.h"

class MainWindow : public QObject
{
    Q_OBJECT
public:
    explicit MainWindow(QObject *parent = 0);
    ~MainWindow();
signals:
    void updateModel(QVariant); // Slot to update QML's gridView model

public slots:
    // Exposing code to QML
    Q_INVOKABLE QStringList getModel(); // Returns list of image sources of diamonds - via Board
    Q_INVOKABLE void makeMove(int prev_diamond, int current_diamond); // Swaps positions of two diamonds - via Board
    Q_INVOKABLE void check_move(); // Checking if it is row move or a column move - via Board

    Q_INVOKABLE void newGameButton_clicked(int mode); // New game started
    Q_INVOKABLE void pauseButton_clicked(bool paused); // Pause button clicked
    Q_INVOKABLE void currentLevelChanged(int difficultyLevel); // Difficulty Level changed

    Q_INVOKABLE QString getBoardBg();
    Q_INVOKABLE void changeTheme(int theme);

private:
    QDeclarativeContext *ctxt;
    QObject *rootObject;
    QDeclarativeView view;
    KDeclarative kdeclarative;

    // Game state class
    KDiamond::GameState* m_gameState;

    // Board for the game
    Board* board;
};

#endif // MainWindow_H
