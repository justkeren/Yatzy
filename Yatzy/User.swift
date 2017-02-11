//
//  User.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/17/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

extension KwPack {
    
    class User {
    
        var pId: Int!;
        var isActive    = true;

        var uScoreKeeper = [0,0,0,0,0,0];       //player's scores for upper
        var lScoreKeeper = [0,0,0,0,0,0,0,0,0]; //players score for the lower section
    
        var lastScoreInput:     UIButton!;
        var playerButtons =     Array<UIButton>();
        var upperScoreButton:   UIButton!;
        var lowerScoreButton:   UIButton!;
        var bonusScoreButton:   UIButton!;
        var playerNameButton:   UIButton!;
        
//since we dont have the stackview until after the player object is created, this is how you create an empty variable that is waiting for a stack object
        var playerStack: UIStackView!
        var playerName: String!
        var nextEvent = "";
        var advanceToNextPlayer = false
        
        func setTurnComplete(_ active: Bool) {
            self.advanceToNextPlayer = active
           
        }
        
        func getTurnComplete() -> Bool {
            return self.advanceToNextPlayer
            
        }
        
        func setNextEvent(_ text: String) {
        //this just sets the variable nextEvent to the text it was given
            self.nextEvent          = text;
        }
        func getNextEvent() -> String {
            return self.nextEvent;
        }

        func setId(_ id: Int) -> Void {
            self.pId = id;
        }
        func getId(_: Void) -> Int {
            return self.pId;
        }
        func setIsActive(_ active: Bool) -> Void {
            self.isActive = active;
            if (active == true) {
                self.getStack().isHidden    = false;
            } else {
                self.getStack().isHidden    = true;
            }
        }
        func getIsActive() -> Bool {
            return self.isActive;
        }
        func setName(_ text: String) {
            self.playerName = text
            self.playerNameButton.setTitle(text, for: UIControlState.normal)
        }
        //return the name to whoever is asking. you dont need anything in the paranthesis because you already have all the info necessary to return the name.
        func getName() -> String {
            return self.playerName
        }
        func setStack(_ stackViewObj: UIStackView) -> Void {
            self.playerStack = stackViewObj;
        }
        func getStack() -> UIStackView {
            return self.playerStack;
        }
        func setButton(_ aButton: UIButton) {
            let rowId = KwPack.TagConvert().getRowIdFromButton(aButton);
            
            if (rowId == 7){
              self.upperScoreButton = aButton

            } else if (rowId == 6){
                self.bonusScoreButton = aButton
                
            } else if (rowId == 17) {
                self.lowerScoreButton = aButton
           
            } else if (rowId == 18 ) {
                self.playerNameButton = aButton
            } else {
                self.playerButtons.append(aButton);
   
            }
            
        }
        func getButtons() -> Array<UIButton> {
            return self.playerButtons;
        }
        func setLastButton(_ lastButton: UIButton) {
            self.lastScoreInput  = lastButton;
        }
        func getLastButton() -> UIButton {
           return self.lastScoreInput;
        }

        func getUpperScore() -> Int {
            return self.uScoreKeeper.reduce(0, +)
        }
        func updateUpperScore() -> Void {
            
             self.upperScoreButton.setTitle(String(self.getUpperScore()), for: UIControlState.normal);
            
        }
        func getBonusScore() -> Int {
            let upperTotal  = self.getUpperScore();
            if (upperTotal > 62) {
                return 50;
            } else {
                //no bonus
                return 0;
            }
            
        }
        func updateBonusScore() -> Void {
            
            let bonusScore  = self.getBonusScore();
           
            if (bonusScore == 0) {
               self.bonusScoreButton.setTitle("", for: UIControlState.normal);
            
            } else {
                self.bonusScoreButton.setTitle(String(bonusScore), for: UIControlState.normal);
            }
     
        }
        
        func getLowerScore() -> Int {
            return self.lScoreKeeper.reduce(0, +)
        }
        func getTotalScore() -> Int {
            return (self.getUpperScore() + self.getBonusScore() + self.getLowerScore());
        }
        func updateTotalScore() -> Void {
            
            self.lowerScoreButton.setTitle(String(self.getTotalScore()), for: UIControlState.normal)
        }

        func updateScore(_ upDown: String,_ index: Int, _ score: Int, _ label: String) -> Void {
        
            if (upDown == "up") {
                self.uScoreKeeper[index] = score;
            } else {
                self.lScoreKeeper[index] = score;
            }
            
            //update the button
            self.getLastButton().setTitle(label, for: UIControlState.normal);
          
            
            self.updateBonusScore();
            self.updateUpperScore();
            self.updateTotalScore();
            
              //  if (label == ""){
               //     self.setTurnComplete(false)
              //  } else {
                
                    self.setTurnComplete(true)
               // }
            
        }

        //set upper scores
        func setOnes(_ scoreVal: Int) -> String {
            
            let index   = 0;
            if (scoreVal == 99) {
                self.updateScore("up", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                self.updateScore("up", index, scoreVal, String(scoreVal));
            }
            
            return "";
        }
        func setTwos(_ scoreVal: Int) -> String {
            
            let index   = 1;
            if (scoreVal == 99) {
                self.updateScore("up", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                let scoreVal    = (scoreVal * 2);
                self.updateScore("up", index, scoreVal, String(scoreVal));
            }
            
            return "";
        }
        func setThrees(_ scoreVal: Int) -> String {
            
            let index   = 2;
            if (scoreVal == 99) {
                self.updateScore("up", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                let scoreVal    = (scoreVal * 3);
                self.updateScore("up", index, scoreVal, String(scoreVal));
            }
            
            return "";
        }
        func setFours(_ scoreVal: Int) -> String {
            
            let index   = 3;
            if (scoreVal == 99) {
                self.updateScore("up", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                let scoreVal    = (scoreVal * 4);
                self.updateScore("up", index, scoreVal, String(scoreVal));
            }
            
            return "";
        }
        func setFives(_ scoreVal: Int) -> String {
            
            let index   = 4;
            if (scoreVal == 99) {
                self.updateScore("up", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                let scoreVal    = (scoreVal * 5);
                self.updateScore("up", index, scoreVal, String(scoreVal));
            }
            
            return "";
        }
        func setSixes(_ scoreVal: Int) -> String {
            
            let index   = 5;
            if (scoreVal == 99) {
                self.updateScore("up", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                let scoreVal    = (scoreVal * 6);
                self.updateScore("up", index, scoreVal, String(scoreVal));
            }
            
            return "";
        }
        
        
        //set lower scores
        func setOnePair(_ scoreVal: Int) -> String {
            
            let index   = 0;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                let scoreVal    = (scoreVal * 2);
                self.updateScore("down", index, scoreVal, String(scoreVal));
            }
            
            return "";
        }
        func setTwoPair(_ scoreVal: Int) -> String {
            
            let index   = 1;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
            } else if (scoreVal < 23 && scoreVal > 5 && scoreVal % 2 == 0) {
                self.updateScore("down", index, scoreVal, String(scoreVal));
            } else if (scoreVal == 0) {
                self.updateScore("down", index, scoreVal, String(scoreVal));
            } else {
                return "Invalid Score"
            }
            
            return "";
        }
        
        func setThreeKind(_ scoreVal: Int) -> String {
            
            let index   = 2;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                let scoreVal    = (scoreVal * 3);
                self.updateScore("down", index, scoreVal, String(scoreVal));
            }
            
            return "";
        }
        func setFourKind(_ scoreVal: Int) -> String {
            
            let index   = 3;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
            } else if (scoreVal < 0 || scoreVal > 6) {
                return "Invalid Score";
            } else {
                let scoreVal    = (scoreVal * 4);
                self.updateScore("down", index, scoreVal, String(scoreVal));
            }
            
            return "";
            
        }
        
        func setFullHouse(_ scoreVal: Int) -> String {
            
            let index   = 4;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
            } else if (scoreVal < 29 && scoreVal > 6 && scoreVal != 10 && scoreVal != 25) {
                self.updateScore("down", index, scoreVal, String(scoreVal));
            
            } else if (scoreVal == 0) {
                self.updateScore("down", index, scoreVal, String(scoreVal));
                
            } else {
                return "Invalid Score"
            }
            
            return "";
        }
        
        func setSmallStraight(_ scoreVal: Int) -> String {
            
            let index   = 5;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
            } else if (scoreVal != 1 && scoreVal != 0) {
                return "Invalid Score";
            } else if (scoreVal == 1){
                self.updateScore("down", index, 15, "15");
            } else if (scoreVal == 0) {
                self.updateScore("down", index, 0, "0");
            }
            
            return "";
        }
        
        func setLargeStraight(_ scoreVal: Int) -> String {
            
            let index   = 6;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
            } else if (scoreVal != 1 && scoreVal != 0) {
                return "Invalid Score";
            } else if (scoreVal == 1){
                self.updateScore("down", index, 20, "20");
            } else if (scoreVal == 0) {
                self.updateScore("down", index, 0, "0");
            }
            
            return "";
        }
        
        func setChance(_ scoreVal: Int) -> String {
            
            let index   = 7;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
      
            } else if (scoreVal < 31 && scoreVal > 4) {
                self.updateScore("down", index, scoreVal, String(scoreVal));
            } else {
                return "Invalid Score"
            }
            
            return "";
        }
        
        func setYatzy(_ scoreVal: Int) -> String {
            
            let index   = 8;
            if (scoreVal == 99) {
                self.updateScore("down", index, 0, "");
            } else if (scoreVal != 1 && scoreVal != 0) {
                return "Invalid Score";
            } else if (scoreVal == 1){
                self.updateScore("down", index, 50, "50");
                self.setNextEvent("gotYatzy");
            } else if (scoreVal == 0) {
                self.updateScore("down", index, 0, "0");
                self.setNextEvent("noYatzyForU");
            }
            
            return "";
        }
        
            }
}

