#include "mainwindow.h"
#include <QGraphicsObject>

MainWindow::MainWindow(QObject *parent) :
    QObject(parent),
    m_gameState(new KDiamond::GameState)
{
    m_gameState->startNewGame();
    m_gameState->setMode(KDiamond::NormalGame);
    board = new Board(this);

    kdeclarative.setDeclarativeEngine(view.engine());
    kdeclarative.initialize();
    kdeclarative.setupBindings();

    // Exposing MainWindow class to QML
    ctxt = view.rootContext();
    ctxt->setContextProperty("MainWindow", this);

    // Setting QML source file
    view.setSource(QUrl("qrc:///declarative/main.qml"));

    // Conecting signal from Qt to QML
    rootObject = dynamic_cast<QObject*>(view.rootObject());
    QObject::connect(board, SIGNAL(updateModel(QVariant)), rootObject, SLOT(updateModel(QVariant)));
    QObject::connect(board, SIGNAL(addPoints(int)), m_gameState, SLOT(addPoints(int)));

    QObject::connect(m_gameState, SIGNAL(pointsChanged(QVariant)), rootObject, SIGNAL(updatePoints(QVariant)));
    QObject::connect(m_gameState, SIGNAL(leftTimeChanged(QVariant)), rootObject, SIGNAL(updateRemainingTime(QVariant)));

    QObject::connect(view.engine(), SIGNAL(quit()), QCoreApplication::instance(), SLOT(quit()));

    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    view.show();
}

MainWindow::~MainWindow()
{
    delete m_gameState;
}


void MainWindow::newGameButton_clicked(int mode)
{
    m_gameState->startNewGame();
    m_gameState->setMode((KDiamond::Mode)mode);
    board->InitializeNewGame();
}

void MainWindow::pauseButton_clicked(bool paused)
{
    m_gameState->setState(paused ? KDiamond::Paused : KDiamond::Playing);
}

void MainWindow::currentLevelChanged(int difficultyLevel)
{
    m_gameState->startNewGame();
    board->ChangeDifficultlyLevel(difficultyLevel);
}

QStringList MainWindow::getModel()
{
    return board->getModel();
}

void MainWindow::makeMove(int prev_diamond, int current_diamond)
{
    board->makeMove(prev_diamond ,current_diamond);
}

void MainWindow::check_move()
{
    board->check_move();
}

QString MainWindow::getBoardBg()
{
    return board->getBoardBg();
}

void MainWindow::changeTheme(int theme)
{
    board->changeTheme(theme);
    newGameButton_clicked(m_gameState->mode());
}
