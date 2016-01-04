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

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.0

Rectangle {
    id         : stMainWindow
    objectName : "stMainWindow"
    width      : 1024
    height     : 720
    color      : gui.getBgColour()
    
    signal newSignal()
    signal loadSignal()
    signal saveSignal()
    signal settingsSignal()
    signal infoSignal()
    signal charactersSignal()
    signal housesSignal()
    signal inventorySignal()
    signal planningSignal()
    signal incomeSignal()
    signal logSignal()
    signal startSignal()

    Rectangle {
        id                       : stMainRoot
        objectName               : "stMainRoot"
        width                    : 1024
        height                   : 720
        color                    : gui.getBgColour()
        anchors.top              : parent.top
        anchors.horizontalCenter : parent.horizontalCenter
        
        Rectangle {
            id           : topLeftCornerFiller
            anchors.top  : parent.top
            anchors.left : parent.left
            width        : 20
            height       : 20
            color        : gui.getControlsBgColour()
        }
        
        Rectangle {
            id            : topRightCornerFiller
            anchors.top   : parent.top
            anchors.right : parent.right
            width         : 20
            height        : 20
            color         : gui.getControlsBgColour()
        }
        
        Rectangle {
            id             : bottomLeftCornerFiller
            anchors.bottom : parent.bottom
            anchors.left   : parent.left
            width          : 20
            height         : 20
            color          : gui.getControlsBgColour()
            visible        : stMainWindow.height > stMainRoot.height ? false : true
        }
        
        Rectangle {
            id             : bottomRightCornerFiller
            anchors.bottom : parent.bottom
            anchors.right  : parent.right
            width          : 20
            height         : 20
            color          : gui.getControlsBgColour()
            visible        : stMainWindow.height > stMainRoot.height ? false : true
        }
    
        Rectangle {
            id           : toolBarTop
            objectName   : "stToolbarTop"
            anchors.top  : parent.top
            anchors.left : parent.left
            width        : parent.width
            height       : 60
            color        : gui.getControlsBgColour()
            radius       : 10
        
            Row {
                spacing: 20
                anchors.verticalCenter   : parent.verticalCenter
                anchors.horizontalCenter : parent.horizontalCenter
                anchors.margins: 2
                
                STButton {
                    id         : tbt_newButton
                    objectName : "tbt_newButton"
                    iconSource : "qrc:///icons/new.png"
                    tooltip    : "New - Start a new game"
                    onClicked  : stMainWindow.newSignal() 
                }
                
                STButton {
                    id         : tbt_saveButton
                    objectName : "tbt_saveButton"
                    iconSource : "qrc:///icons/save.png"
                    tooltip    : "Save - save the current game to disk"
                    onClicked  : stMainWindow.saveSignal() 
                }
                
                STButton {
                    id         : tbt_loadButton
                    objectName : "tbt_loadButton"
                    iconSource : "qrc:///icons/load.png"
                    tooltip    : "Load - load a saved game"
                    onClicked  : stMainWindow.loadSignal() 
                }
                
                STButton {
                    id         : tbt_settingsButton
                    objectName : "tbt_settingsButton"
                    iconSource : "qrc:///icons/settings.png"
                    tooltip    : "Settings - change the game settings"
                    onClicked  : stMainWindow.settingsSignal() 
                }
                
                STButton {
                    id         : tbt_infoButton
                    objectName : "tbt_infoButton"
                    iconSource : "qrc:///icons/info.png"
                    tooltip    : "Info - background info (help) and credits"
                    onClicked  : stMainWindow.infoSignal() 
                }
            }
        }
        
        Rectangle {
            id             : statusBar
            objectName     : "stStatusbar"
            anchors.bottom : parent.bottom
            anchors.left   : parent.left
            width          : parent.width
            height         : 56
            color          : gui.getControlsBgColour()
            radius         : 10
            
            Text {
                id                     : sb_playerNameValue
                anchors.verticalCenter : parent.verticalCenter
                anchors.left           : parent.left
                anchors.margins        : 2
                anchors.leftMargin     : 10
                font.pointSize         : 16
                font.weight            : Font.Bold
                color                  : gui.getFontColour()
                text                   : "Test"
                width                  : 250 
            }
            
            Text {
                id              : sb_healthLabel
                anchors.bottom  : parent.verticalCenter
                anchors.left    : sb_playerNameValue.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Health:"
                width           : 70
            }
            
            Text {
                id              : sb_healthValue
                anchors.top     : sb_healthLabel.top
                anchors.left    : sb_healthLabel.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Test 1"
                width           : 150
            }
            
            Text {
                id              : sb_staminaLabel
                anchors.top     : parent.verticalCenter
                anchors.left    : sb_playerNameValue.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Stamina:"
                width           : 70
            }
            
            Text {
                id              : sb_staminaValue
                anchors.top     : sb_staminaLabel.top
                anchors.left    : sb_staminaLabel.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Test 2"
                width           : 150
            }
            
            Text {
                id              : sb_experienceLabel
                anchors.top     : sb_healthValue.top
                anchors.left    : sb_healthValue.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Experience:"
                width           : 90
            }
            
            Text {
                id              : sb_experienceValue
                anchors.top     : sb_experienceLabel.top
                anchors.left    : sb_experienceLabel.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Test 3"
                width           : 150
            }
            
            Text {
                id              : sb_goldLabel
                anchors.top     : sb_staminaValue.top
                anchors.left    : sb_staminaValue.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Gold:"
                width           : 90
            }
            
            Text {
                id              : sb_goldValue
                anchors.top     : sb_goldLabel.top
                anchors.left    : sb_goldLabel.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Test 4"
                width           : 150
            }
            
            Text {
                id              : sb_dayLabel
                anchors.top     : sb_experienceValue.top
                anchors.left    : sb_experienceValue.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Day:"
                width           : 40
            }
            
            Text {
                id              : sb_dayValue
                anchors.top     : sb_dayLabel.top
                anchors.left    : sb_dayLabel.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Test 5"
                width           : 150
            }
            
            Text {
                id              : sb_yearLabel
                anchors.top     : sb_dayLabel.bottom
                anchors.left    : sb_goldValue.right
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Year:"
                width           : 40
            }
            
            Text {
                id              : sb_yearValue
                anchors.top     : sb_dayValue.bottom
                anchors.left    : sb_yearLabel.right  
                anchors.margins : 2
                font.weight     : Font.Bold
                color           : gui.getFontColour()
                text            : "Test 6"
                width           : 150
            }
        }
    
        Rectangle {
            id                   : toolBarLeft
            objectName           : "stToolbarLeft"
            anchors.top          : toolBarTop.bottom
            anchors.topMargin    : 3
            anchors.bottomMargin : 3
            anchors.left         : parent.left
            width                : 60
            height               : parent.height - toolBarTop.height - statusBar.height - 6
            color                : gui.getControlsBgColour()
            radius               : 10
        
            Column {
                spacing                  : 20
                anchors.horizontalCenter : parent.horizontalCenter
                anchors.verticalCenter   : parent.verticalCenter
                anchors.margins          : 2
                
                STButton {
                    id         : tbl_charactersButton
                    objectName : "tbl_charactersButton"
                    iconSource : "qrc:///icons/characters.png"
                    tooltip    : "Characters - view your characters (your hero, your servants, your slaves) and equip them"
                    onClicked  : stMainWindow.charactersSignal() 
                }
                
                STButton {
                    id         : tbl_housesButton
                    objectName : "tbl_housesButton"
                    iconSource : "qrc:///icons/houses.png"
                    tooltip    : "Houses - see the houses you own, allocate rooms and equip them"
                    onClicked  : stMainWindow.housesSignal()
                }
                
                STButton {
                    id         : tbl_inventoryButton
                    objectName : "tbl_inventoryButton"
                    iconSource : "qrc:///icons/inventory.png"
                    tooltip    : "Inventory - see the items you own and who's equipped with them"
                    onClicked  : stMainWindow.inventorySignal() 
                }
                
                STButton {
                    id         : tbl_planningButton
                    objectName : "tbl_planningButton"
                    iconSource : "qrc:///icons/planning.png"
                    tooltip    : "Planning - plan the day for all of your characters"
                    onClicked  : stMainWindow.planningSignal() 
                }
                
                STButton {
                    id         : tbl_incomeButton
                    objectName : "tbl_incomeButton"
                    iconSource : "qrc:///icons/income.png"
                    tooltip    : "Income - see your current balance sheet and expected expenditure / income"
                    onClicked  : stMainWindow.incomeSignal() 
                }
                
                STButton {
                    id         : tbl_logButton
                    objectName : "tbl_logButton"
                    iconSource : "qrc:///icons/log.png"
                    tooltip    : "Log - see the active and completed quests and your awards"
                    onClicked  : stMainWindow.logSignal() 
                }
                
                Rectangle {
                    width  : 10
                    height : parent.spacing
                    color  : toolBarLeft.color
                }
                
                STButton {
                    id         : tbl_startButton
                    objectName : "tbl_startButton"
                    iconSource : "qrc:///icons/start.png"
                    tooltip    : "Start the day's activities"
                    onClicked  : stMainWindow.startSignal() 
                }
            }
        }
        
        TabView {
            id                   : stTabview
            objectName           : "stTabview"
            anchors.top          : toolBarTop.bottom
            anchors.right        : parent.right
            anchors.topMargin    : 3
            anchors.bottomMargin : 3
            width                : 300
            height               : parent.height - toolBarTop.height - statusBar.height - 6
            style                : TabViewStyle {
                padding {
                    left:   0
                    right:  0
                    top:    0
                    bottom: 0
                }
                frame: Rectangle {
                    color          : gui.getControlsBgColour()
                    radius         : 10
                }
            }
        }
       
        Rectangle {
            id              : stCommunication
            objectName      : "stCommunication"
            anchors.bottom  : statusBar.top
            anchors.left    : toolBarLeft.right
            anchors.right   : stTabview.left
            anchors.margins : 3
            height          : 102
            color           : gui.getControlsBgColour()
            radius          : 10
            
            Rectangle { 
                anchors.horizontalCenter : parent.horizontalCenter
                anchors.verticalCenter   : parent.verticalCenter
                anchors.margins          : 3
                width                    : parent.width - 10
                height                   : parent.height - 10
                color                    : parent.color
                ScrollView {
                    id                        : communicationScrollView
                    anchors.fill              : parent
                    horizontalScrollBarPolicy : Qt.ScrollBarAlwaysOff
                    verticalScrollBarPolicy   : Qt.ScrollBarAlwaysOn
                   
                    Text {
                        width         : stCommunication.width - 30
                        wrapMode      : Text.WordWrap
                        text          : "Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla "
                    }
                }
            }
        }
        
        Rectangle {
            id              : stScene
            objectName      : "stScene"
            anchors.top     : toolBarTop.bottom
            anchors.left    : toolBarLeft.right
            anchors.right   : stTabview.left
            anchors.bottom  : stCommunication.top
            anchors.margins : 3
            radius          : 10
            border.color    : "#000000"
            border.width    : 1
            color           : "#00000000"
        }
    }
}
