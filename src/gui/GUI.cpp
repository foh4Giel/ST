/* Copyright (C) foh4Giel 2016
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include "GUI.h"
#include "../engine/STEngine.h"
#include <iostream>
#include <math.h>
#include <time.h>
#include <QFontDatabase>
#include <QScreen>
#include <QSize>

void GUI::initGUI(STEngine * engPtr)
{
	if (INITIALISED != this->status) {
		ERR_PRINT("GUI Singleton hasn't been initialised yet. GUI::status = %d. FATAL", this->status)
		exit(-1);
		/** @todo Throw proper exception.
		 *
		 */
	}

	/* QGuiApplication expects to get argc and argv. We explicitly do not
	 * provide these at the moment to avoid having to deal with non-default Qt
	 * behaviour. Instead we use fake argc, argv.
	 */
	int argc      = 1, i, j;
	char * argv[] = { (char*)"ignoreThis" };
	enginePtr     = engPtr;
	guiPtr        = new QApplication(argc, argv);
	QFontDatabase database;
	database.addApplicationFont(":/fonts/MedievalSharp.ttf");
	guiPtr->setFont(database.font("Medieval Sharp", "Book", 12));

	QList<QScreen *> screens = guiPtr->screens();
	int selectedScreen       = 0;
	int selectedWidth        = 0;
	int selectedHeight       = 0;
	double maxDiagonalOfGeom = 0;
	for (i = 0; i < screens.length(); i++) {
		QSize screenSize      = screens.at(i)->size();
		QRect screenGeom      = screens.at(i)->availableGeometry();
		bool isLandscape      = screens.at(i)->isLandscape(screens.at(i)->orientation());
		bool isPortrait       = screens.at(i)->isPortrait(screens.at(i)->orientation());
		QString name          = screens.at(i)->name();
		double diagonalOfGeom = sqrt((screenGeom.width() * screenGeom.width()) +  (screenGeom.height()*screenGeom.height()));
		if (0 == maxDiagonalOfGeom) {
			if (isLandscape) {
				selectedScreen    = i;
				maxDiagonalOfGeom = diagonalOfGeom;
			}
		} else {
			if (isLandscape && (diagonalOfGeom > maxDiagonalOfGeom)) {
				selectedScreen    = i;
				maxDiagonalOfGeom = diagonalOfGeom;
			}
		}
	}
	selectedWidth  = screens.at(selectedScreen)->availableGeometry().width();
	selectedHeight = screens.at(selectedScreen)->availableGeometry().height();
	if(debug) {
		this->initDimensions(selectedWidth, selectedHeight, true);
	} else {
		this->initDimensions(selectedWidth, selectedHeight);
	}

	QObject::connect(guiPtr, SIGNAL(aboutToQuit()), this,  SLOT(terminate()));
}

void GUI::showContentWarning()
{
	if (INITIALISED != this->status) {
		ERR_PRINT("GUI Singleton hasn't been initialised yet. GUI::status = %d. FATAL", this->status)
		exit(-1);
		/** @todo Throw proper exception.
		 *
		 */
	}

    QQuickView mainView;
    mainView.rootContext()->setContextProperty("gui", this);
    mainView.setSource( QStringLiteral( "src/gui/ST.qml" ) );
    mainView.setTitle(longGameName);
    mainView.setX(20);
    mainView.setY(60);
    mainView.setResizeMode(QQuickView::SizeViewToRootObject);
    QObject *mainWindow = mainView.rootObject();

    PRINT("mainView resizeMode = %d", "   ", mainView.resizeMode());

	QObject::connect(&mainView, SIGNAL(heightChanged(int)), this,  SLOT(heightChanged(int)));
	QObject::connect(&mainView, SIGNAL(widthChanged(int)), this,  SLOT(widthChanged(int)));

	QObject::connect(mainWindow, SIGNAL(newSignal()), this, SLOT(newButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(saveSignal()), this, SLOT(saveButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(loadSignal()), this, SLOT(loadButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(settingsSignal()), this, SLOT(settingsButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(infoSignal()), this, SLOT(infoButtonClicked()));

	QObject::connect(mainWindow, SIGNAL(charactersSignal()), this, SLOT(charactersButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(housesSignal()), this, SLOT(housesButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(inventorySignal()), this, SLOT(inventoryButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(planningSignal()), this, SLOT(planningButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(incomeSignal()), this, SLOT(incomeButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(logSignal()), this, SLOT(logButtonClicked()));
	QObject::connect(mainWindow, SIGNAL(startSignal()), this, SLOT(startButtonClicked()));


	this->mainObjects.stMainRoot      = mainWindow->findChild<QObject*>("stMainRoot");
	this->mainObjects.stToolbarTop    = mainWindow->findChild<QObject*>("stToolbarTop");
	this->mainObjects.stToolbarLeft   = mainWindow->findChild<QObject*>("stToolbarLeft");
	this->mainObjects.stTabview       = mainWindow->findChild<QObject*>("stTabview");
	this->mainObjects.stStatusbar     = mainWindow->findChild<QObject*>("stStatusbar");
	this->mainObjects.stScene         = mainWindow->findChild<QObject*>("stScene");
	this->mainObjects.stCommunication = mainWindow->findChild<QObject*>("stCommunication");

    mainView.show();
    mainView.setVisibility(QWindow::Hidden);

    mainPtr = &mainView;

	QQuickView warningView;
    warningView.rootContext()->setContextProperty("gui", this);
    warningView.setSource( QStringLiteral( "src/gui/STWarning.qml" ) );
	warningView.setTitle(longGameName + ": Content and Trigger Warning");
    warningView.setX(20);
    warningView.setY(80);
    QObject *warningRoot = warningView.rootObject();
	QObject::connect(warningRoot, SIGNAL(quitSignal()), this,  SLOT(terminate()));
	QObject::connect(warningRoot, SIGNAL(proceedSignal()), this,  SLOT(proceedAfterWarning()));
    warningView.show();
	warningPtr = &warningView;

    int retVal = guiPtr->exec();
    if (0 != retVal) {
    	ERR_PRINT("Non-zero return value from QGuiApplication::exec(). Return value = %d", retVal);
    	this->terminate();
    }
    return;
}

void GUI::showMainGUI()
{
	PRINT("Show main GUI", "");
	PRINT("Length of window list before main window creation = %d", "   ", guiPtr->allWindows().length());
	PRINT("Length of top-level window list before main window creation = %d", "   ", guiPtr->topLevelWindows().length());

	if (guiPtr->hasPendingEvents()) {
		PRINT("guiPtr has pending events", "   ")
	} else {
		PRINT("guiPtr has NO pending events", "   ")
	}

    QObject *mainWindow = mainPtr->rootObject();

    PRINT("Setting window properties: width = %d, height = %d", "   ", this->dimensions.wWidth, this->dimensions.wHeight);
	mainWindow->setProperty("width", this->dimensions.wWidth);
	mainWindow->setProperty("height", this->dimensions.wHeight);
	this->mainObjects.stMainRoot->setProperty("width", this->dimensions.wWidth);
	this->mainObjects.stMainRoot->setProperty("height", this->dimensions.wHeight);

	PRINT("stScene: width = %d, height = %d", "   ", mainObjects.stScene->property("width").toInt(), mainObjects.stScene->property("height").toInt());
	mainPtr->setVisibility(QWindow::Windowed);

	if (guiPtr->hasPendingEvents()) {
		PRINT("guiPtr has pending events", "   ")
	} else {
		PRINT("guiPtr has NO pending events", "   ")
	}
    guiPtr->processEvents();
	if (guiPtr->hasPendingEvents()) {
		PRINT("guiPtr has pending events", "   ")
	} else {
		PRINT("guiPtr has NO pending events", "   ")
	}
}

void GUI::updateMainView()
{
	PRINT("Update signal received", "");
	mainPtr->update();
	PRINT("Update signal processed", "");
}

void GUI::widthChanged(int width)
{
	PRINT("Maximum width changed, new width = %d", "   ", width);
	QObject *mainWindow = mainPtr->rootObject();
	mainWindow->setProperty("width", width);
	mainPtr->update();
}

void GUI::heightChanged(int height)
{
	PRINT("Maximum height changed, new height = %d", "   ", height);
	QObject *mainWindow = mainPtr->rootObject();
	mainWindow->setProperty("height", height);
	mainPtr->update();
}

void GUI::newButtonClicked()
{
	PRINT("NEW button clicked", "      ")
}

void GUI::saveButtonClicked()
{
	PRINT("SAVE button clicked", "      ")
}

void GUI::loadButtonClicked()
{
	PRINT("LOAD button clicked", "      ")
}

void GUI::settingsButtonClicked()
{
	PRINT("SETTINGS button clicked", "      ")
}

void GUI::infoButtonClicked()
{
	PRINT("INFO button clicked", "      ")
}

void GUI::charactersButtonClicked()
{
	PRINT("CHARACTERS button clicked", "      ")
}

void GUI::housesButtonClicked()
{
	PRINT("HOUSES button clicked", "      ")
}

void GUI::inventoryButtonClicked()
{
	PRINT("INVENTORY button clicked", "      ")
}

void GUI::planningButtonClicked()
{
	PRINT("PLANNING button clicked", "      ")
}

void GUI::incomeButtonClicked()
{
	PRINT("INCOME button clicked", "      ")
}

void GUI::logButtonClicked()
{
	PRINT("LOG button clicked", "      ")
}

void GUI::startButtonClicked()
{
	PRINT("START button clicked", "      ")
}



GUI::GUI() {
	// TODO Auto-generated constructor stub
	if (UNINITIALISED == this->status) {
		this->status       = INITIALISING;
		this->guiPtr           = 0;
		this->enginePtr        = 0;
		this->screenWidth      = 0;
		this->screenHeight     = 0;
		this->bgColour         = "#5f021f";
		this->controlsBgColour = "#666666";
		this->imageBgColour    = "#ffffff";
		this->depthColour      = "#000000";
		this->fontColour       = "#ffd700";
		this->controlsRadius   = "15";
		this->status           = INITIALISED;
	}
}

void GUI::terminate()
{
	if (TERMINATING <= this->status) {
		return;
	}
	this->status = TERMINATING;
	/** @todo Place code for GUI termination here if it is to be executed before
	 *        engine termination.
	 */



	if (guiPtr->hasPendingEvents()) {
		PRINT("guiPtr has pending events", "   ");

	} else {
		PRINT("guiPtr has NO pending events", "   ")
	}

	if (0 != guiPtr) {
		guiPtr->quit();
		guiPtr = 0;
	}

	this->status = TERMINATED;

	if (0 != enginePtr) {
		// Terminate engine
		enginePtr->terminate();
	} else {
		ERR_PRINT("Pointer to STEnigne has been lost. FATAL");
		exit(-1);
	}
}

void GUI::proceedAfterWarning()
{
	const int numExpectedWindows = 2;

	if (INITIALISED != this->status) {
		ERR_PRINT("GUI Singleton hasn't been initialised yet. GUI::status = %d. FATAL", this->status)
		exit(-1);
		/** @todo Throw proper exception.
		 *
		 */
	}

	QWindowList currentWindows = guiPtr->allWindows();
	if (numExpectedWindows == currentWindows.length()) {
		warningPtr->close();
		if (guiPtr->hasPendingEvents()) {
			PRINT("guiPtr has pending events", "   ")
		} else {
			PRINT("guiPtr has NO pending events", "   ")
		}
	} else {
		ERR_PRINT("Unexpected number of windows open! Expected number of windows = %d, actual number of windows = %d", numExpectedWindows, currentWindows.length())
		this->terminate();
	}

	if (0 != enginePtr) {
		enginePtr->loadGame();
	} else {
		this->terminate();
	}
}

void GUI::initDimensions(int width, int height, bool fixAtMinimum)
{
	if ((width > 1850) && (height > 1390) && !(fixAtMinimum) ) {
		this->dimensions.wHeight = 1390;
		this->dimensions.wWidth  = 1850;
		this->dimensions.sHeight = 1113;
		this->dimensions.sWidth  = 1484;
		this->dimensions.cHeight =  152;
	} else if ((width > 1370) && (height > 1030) && !(fixAtMinimum)) {
		this->dimensions.wHeight = 1030;
		this->dimensions.wWidth  = 1370;
		this->dimensions.sHeight =  753;
		this->dimensions.sWidth  = 1004;
		this->dimensions.cHeight =  152;
	} else {
		this->dimensions.wHeight =  720;
		this->dimensions.wWidth  = 1024;
		this->dimensions.sHeight =  493;
		this->dimensions.sWidth  =  658;
		this->dimensions.cHeight =  102;
	}
}
