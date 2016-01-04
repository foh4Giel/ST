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
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0
import QtQuick.Controls.Styles 1.1


            
Rectangle {

    property string iconSource : icon.source 
    property string tooltip 
    
    signal clicked

    border.width : 2
    border.color : "#ffd700"
    radius       : 6
    width        : icon.width  + 6
    height       : icon.height + 6
    color        : gui.getControlsBgColour()
                
    Image {
        id                       : icon
        source                   : iconSource
        anchors.horizontalCenter : parent.horizontalCenter
        anchors.verticalCenter   : parent.verticalCenter
    }
    
    MouseArea {
        id           : mouseArea
        anchors.fill : parent
        hoverEnabled : true
        onPressed    : {
            parent.border.width = 4
        }
        onReleased   : {
            parent.border.width = 2
        }
        onClicked    : {
            parent.clicked()
        }
        onEntered    : {
            parent.color = "#cccccc"
        } 
        onExited : {
            parent.color        = gui.getControlsBgColour()
            parent.border.width = 2
        }

        Timer {
            interval: 1000
            running: mouseArea.containsMouse && !mouseArea.pressed && tooltip.length
            onTriggered: Tooltip.showText(mouseArea, Qt.point(mouseArea.mouseX, mouseArea.mouseY), tooltip)
        }
    }
}