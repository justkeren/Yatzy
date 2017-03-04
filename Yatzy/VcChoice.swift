//
//  VcMultiChoice.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/18/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcChoice: UIViewController {

    
    //must be set on segue prepare from the sending viewController
    var playerObj: KwPack.User!
    var parentVc: VcPrimary!;
    var tempScore = ""
    
    @IBOutlet weak var enterB: UIButton!
    
    @IBOutlet weak var scoreScreen: UITextField!
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var masterScoreStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setText()
        
        
        self.enterB.layer.shadowOffset = CGSize(width: 5, height: 5)
        
       
        enterB.layer.shadowRadius = 5
        
        // change the color of the shadow (has to be CGColor)
        enterB.layer.shadowColor = UIColor.gray.cgColor
        
        // display the shadow
        enterB.layer.shadowOpacity = 1.0
       // KwPack.CustomYatzy().formatScoreButtonsInStack(self.masterScoreStack)
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setText () {
        let playerName      = self.playerObj.getName() + "'s";
        let lastButton      = self.playerObj.getLastButton();
        let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
        var text            = ""
        
        if (rowId == 9) {
            text = " Score for Two Pair"
            
        } else if (rowId == 15) {
            text = " Score for Chance"
            
        } else if (rowId == 12) {
            text = " Score for Full House"
        }
        //object that holds the text content
        let textObj         = NSMutableAttributedString(string:text)
        let nameColor       = KwPack.CustomYatzy().getNameColor()
        let changeObj = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 24), NSForegroundColorAttributeName : nameColor];
        
       
        let playerNameObj = NSMutableAttributedString(string:playerName, attributes: changeObj)
        
        playerNameObj.append(textObj)
        
        self.textDescription.attributedText = playerNameObj
        
    }

    
    @IBAction func setScore(_ scoreCardButton: UIButton) {
        
        //scoreval is for the button on the scorecard so we know which one you tapped
        let tagValue            = scoreCardButton.tag
        var scoreVal            = 0
        var completed           = false
        
        if (tagValue == 99){
            //this is clearing the scorecard (main) and closing the scorecard itself
            scoreVal = 99
            completed = true
            
        } else if (tagValue == 12){
            //this takes the two digit score and sets it to scoreVal
            if (self.tempScore != "") {
                scoreVal = Int(self.tempScore)!
                completed = true
            
            } else {
                completed = true
            }
            
        } else if (tagValue == 10){
            //to edit the score in the textfield (go back)
            if (self.tempScore != "") {
                self.tempScore.remove(at:  self.tempScore.index(before: self.tempScore.endIndex))
            }
            
        } else {
            //makes it possible to make two digit numbers by pressing 2 buttons
            self.tempScore.append(String(tagValue))
        }
        
        self.scoreScreen.text = self.tempScore

        
        if (completed == true) {
            
            
            //rowid is the last button tapped on the primary view
            let lastButton      = self.playerObj.getLastButton();
            let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
            var rData           = "";
            
            
            if (rowId == 9) {
                rData = self.playerObj.setTwoPair(scoreVal);
            } else if (rowId == 12) {
                rData = self.playerObj.setFullHouse(scoreVal);
            } else if (rowId == 15) {
                rData = self.playerObj.setChance(scoreVal);
            } else {
                print("Row Id: \(rowId), does not belong in this view controller");
            }
            
            
            
            if (rData == "") {
                print("Just Set Score Input: \(scoreVal)");
                print("For Player: \(self.playerObj.getId())");
                print("In Row: \(rowId)");
                
                //success back to the main controller
                self.exitScoreCard();
                
            } else {
                //there is a problem
                print(rData);
                
                self.tempScore = ""
                self.scoreScreen.text = rData
                
            }
        }
    }
    
    func exitScoreCard()
    {
        self.dismiss(animated: true, completion: nil);
        self.parentVc.returnFromSegue()
    }
}
