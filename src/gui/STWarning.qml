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

import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id     : warningRoot
    width  : 800
    height : 590
    color  : "#cccccc"
    
    signal proceedSignal()
    signal quitSignal()

    Text {
        id              : warningLabel
        objectName      : "warningLabelT"
        text            : "Warning:"
        color           : "red"
        font.pointSize  : 24
        font.bold       : true
        width           : parent.width - 40
        anchors.left    : parent.left
        anchors.top     : parent.top
        anchors.margins : 20
    }
    
    Text {
        id              : warningText
        objectName      : "warningTextT"
        color           : "red"
        text            : "<p><b>This game contains adult content including but not limited to swearing, profanity, nudity, sex and violence. Some of the content can be extremely distrubing. YOU MUST BE 18 OR OVER AND OF LEGAL AGE TO ACCESS THIS GAME. Otherwise press \"Quit\" now.</b></p><br><p><b>Trigger Warning:</b> This game is not suited for people who have suffered sexual traumata or violence related traumata. <b>People who believe that they may be vulnerable to <i>any</i> form of trauma trigger should click \"Quit\" now.</b></p><br><p>This game is set in a <b><i>fantasy</i></b> setting and caters to a variety of sexual fetishes including but not limited to dominance/submission, slavery, bondage, mind control, gender nonconformity, extreme body modification, rape, torture and snuff. It should be absolutely clear that most actions, items and other content within the game is impossible and/or highly immoral in the real world. <b>Anyone wishing to try this in the real world should seek psychological help.</b> To some degree, the content that will be displayed can be configured during the game but this is a convenience option, not an absolute protection, as classification errors may happen and classifications are ambiguous. The only content that is explicitly excluded from the game is content related to underage or appearing to be underage characters.</p><br><p>This program is distributed in the hope that it will be enjoyable, but WITHOUT ANY WARRANTY. The developers can not be held responsible for any negative psychological effect suffered because of this game and can not be held responsible for any content that is not part of the standard distribution or the official content repository.</p> "
        font.pointSize  : 12
        textFormat      : Text.StyledText
        wrapMode        : Text.WordWrap
        width           : parent.width - 40
        anchors.left    : parent.left
        anchors.top     : warningLabel.bottom
        anchors.margins : 20
    }
    
    Row {
        spacing                  : 20
        anchors.horizontalCenter : parent.horizontalCenter
        anchors.top              : warningText.bottom
        anchors.margins          : 40
    
        Button {
            text       : "Ok"
            objectName : "AcceptB"
            isDefault  : false
            tooltip    : "Ok - proceed into game."
            onClicked  : warningRoot.proceedSignal()
        }
        
        
        Button {
            text       : "Quit"
            objectName : "QuitB"
            isDefault  : true
            tooltip    : "Quit - do not start game."
            onClicked  : warningRoot.quitSignal()
        }
    
    }
    
 }