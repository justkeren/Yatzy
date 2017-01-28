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
    
        var lastScoreInput: UIButton!;
        var playerButtons = Array<UIButton>();
//since we dont have the stackview until after the player object is created, this is how you create an empty variable that is waiting for a stack object
        var playerStack: UIStackView!
        var playerName: String!
        
        var eventIsPending = false;
        var nextEvent: String!;
        
        func setNextEvent(_ image: String) {
            
            self.eventIsPending     = true;
            self.nextEvent          = image;
        }
        func getEventIsPending() -> Bool {
            return self.eventIsPending;
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
            var rowId   = 0;
            for aButton in self.getButtons() {
                
                rowId = KwPack.TagConvert().getRowIdFromButton(aButton);
                if (rowId == 18) {
                    //this is the player name being set in the button title
                    aButton.setTitle(text, for: UIControlState.normal);
                    break;
                }
            }
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
            self.playerButtons.append(aButton);
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
            
            var rowId   = 0;
            for aButton in self.getButtons() {
                
                rowId = KwPack.TagConvert().getRowIdFromButton(aButton);
                if (rowId == 7) {
                    //this is the upper total
                    aButton.setTitle(String(self.getUpperScore()), for: UIControlState.normal);
                    break;
                }
            }
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
            
            var rowId   = 0;
            for aButton in self.getButtons() {
                rowId = KwPack.TagConvert().getRowIdFromButton(aButton);
                if (rowId == 6) {
                    let bonusScore  = self.getBonusScore();
                    if (bonusScore == 0) {
                        aButton.setTitle("", for: UIControlState.normal);
                    } else {
                        aButton.setTitle(String(bonusScore), for: UIControlState.normal);
                    }
                    
                    break;
                }
            }
        }
        
        func getLowerScore() -> Int {
            return self.lScoreKeeper.reduce(0, +)
        }
        func getTotalScore() -> Int {
            return (self.getUpperScore() + self.getBonusScore() + self.getLowerScore());
        }
        func updateTotalScore() -> Void {
            
            var rowId   = 0;
            for aButton in self.getButtons() {
               
                rowId = KwPack.TagConvert().getRowIdFromButton(aButton);
                if (rowId == 17) {
                    //this is the total score
                    aButton.setTitle(String(self.getTotalScore()), for: UIControlState.normal);
                    break;
                }
            }
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
                
                self.setNextEvent("mariaClapping");
                
            } else if (scoreVal == 0) {
                self.updateScore("down", index, 0, "0");
            }
            
            return "";
        }
        
            }
}

