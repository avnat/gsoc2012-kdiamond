#include <KCmdLineArgs>
#include <KApplication>
#include <KAboutData>
#include <QApplication>
#include "mainwindow.h"

int main(int argc, char *argv[])
{
    
    KAboutData aboutData(
        "kdiamond",        // appName
        0,                 // catalogName
        ki18n("kdiamond"), // programName
        "0");              // version (set by initAboutData)

    KCmdLineArgs::init(argc, argv, &aboutData);
    KCmdLineOptions options;
    KCmdLineArgs::addCmdLineOptions(options);
    KCmdLineArgs::parsedArgs();
    KApplication app;

    MainWindow window;

    return app.exec();
}
