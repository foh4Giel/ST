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

#ifndef GUI_GUI_H_
#define GUI_GUI_H_

#include "../common.h"
#include <QApplication>
#include <QGuiApplication>
#include <QObject>
#include <QString>
#include <QtQuick>

class GUI : public QObject {
	Q_OBJECT
public:
	static GUI& getInstance() {
		static GUI instance;
		return(instance);
	}

	void initGUI(STEngine * engPtr);

	void showContentWarning();

	void showMainGUI();
	Q_INVOKABLE QString getBgColour()         const { return(bgColour);         };
	Q_INVOKABLE QString getControlsBgColour() const { return(controlsBgColour); };
	Q_INVOKABLE QString getImageBgColour()    const { return(imageBgColour);    };
	Q_INVOKABLE QString getDepthColour()      const { return(depthColour);      };
	Q_INVOKABLE QString getFontColour()       const { return(fontColour);       };
	Q_INVOKABLE QString getControlsRadius()   const { return(controlsRadius);   };

private:
	GUI();

	/** Removed the default copy constructor for singleton pattern. Requires
	 *  C++11.
	 */
	GUI(GUI const&) = delete;

	void operator=(GUI const&) = delete;

private slots:
	void terminate();
	void proceedAfterWarning();
	void updateMainView();

	void widthChanged(int width);
	void heightChanged(int height);

	void newButtonClicked();
	void saveButtonClicked();
	void loadButtonClicked();
	void settingsButtonClicked();
	void infoButtonClicked();
	void charactersButtonClicked();
	void housesButtonClicked();
	void inventoryButtonClicked();
	void planningButtonClicked();
	void incomeButtonClicked();
	void logButtonClicked();
	void startButtonClicked();

private:
	void initDimensions(int width, int height, bool fixAtMinimum = false);

	QApplication* guiPtr;

	STEngine* enginePtr;

	QQuickView* warningPtr;
	QQuickView* mainPtr;

	struct MainObjects {
		QObject* stMainRoot;
		QObject* stToolbarTop;
		QObject* stToolbarLeft;
		QObject* stTabview;
		QObject* stStatusbar;
		QObject* stScene;
		QObject* stCommunication;
	} mainObjects;

	struct Dimensions {
		int wHeight;
		int wWidth;
		int sHeight;
		int sWidth;
		int cHeight;
	} dimensions;

	QString bgColour;
	QString controlsBgColour;
	QString imageBgColour;
	QString depthColour;
	QString fontColour;
	QString controlsRadius;


	SingletonStatus status = UNINITIALISED;
	int screenWidth;
	int screenHeight;
};

#endif /* GUI_GUI_H_ */
