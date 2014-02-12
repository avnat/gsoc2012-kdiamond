Porting KDiamond (game) to Qt Quick - Google Summer of Code, April - August 2012

Student name: Avnee Nathani

Description
------------
I was working with KDE organization for GSoC - 2012. My project was to port one of their existing games, KDiamond, to a different technology i.e. QML. The original version of KDiamond game is written completely in Qt (C++). QML is a recent amazing declarative language which gives capability to create great user interfaces and also offers smooth transitions and interactions, specially for mobile devices. Hence, to make the game more interactive and fun to play - both on desktop and mobile devices, I ported it to QML. Some code has been reused from the original version, but the UI of the game has been completely redone in QML. During this porting excercise, my project also included making reusable QML components. Thus, I worked on some of the components that I used in the QML UI of the game, to make them reusable.


Code Repository Link
---------------------
http://quickgit.kde.org/index.php?p=scratch%2Fnathani%2Fgsoc2012-kdiamond.git

clone url: git://anongit.kde.org/scratch/nathani/gsoc2012-kdiamond.git

Compiling and building KDiamond (QML)
----------------------------------------
This section describes how to clone KDiamond (QML) repository and compile and build using Qt Creator

* To build KDiamond (QML) you will need libkdegames

* Now, clone KDiamond (QML) into kdegames

	git clone git://anongit.kde.org/scratch/nathani/gsoc2012-kdiamond.git

* Import kdegames's CMakeLists.txt to QtCreator

	Select File > Open File or Project.
	Select the CMakeLists.txt file from your kdegame's folder.
	Choose a build directory and Run Cmake
	Once done, press Finish

* Run KDiamond application

	Press the run button to run the application.

QML Reusable Components
-----------------------
I was working on some reusable components during the port of KDiamond.

* Components
- ListDialog
- Popup
- QuitDialog

You can find these components in KDiamond(QML) repo: http://quickgit.kde.org/index.php?p=scratch%2Fnathani%2Fgsoc2012-kdiamond.git

Techbase article: http://techbase.kde.org/Reusable_QML_components

Blog URL
---------
http://avnee.wordpress.com/