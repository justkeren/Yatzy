//
//  MultiChoiceVC.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/17/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcUpper: UIViewController {

    //must be set on segue prepare from the sending viewController
    var playerObj: KwPack.User!
    @IBOutlet weak var upperRowDesc: UITextField!
    @IBOutlet weak var scoreButtonStack: UIStackView!
    @IBOutlet weak var scoreCardStackView: UIStackView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //put this here because there is no action to set the text. This is the caller
        self.setText()
        self.changeTextOnButton()
       // KwPack.CustomYatzy().formatScoreButtonsInStack(self.scoreButtonStack)
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //this func exists the scorecard controller
    @IBAction func exitController(_ goBackButton: UIButton) {
        print ("after IBaction")
        self.dismiss(animated: true, completion: nil);
        print ("after dismiss")
    }
    
    func changeTextOnButton() {
        let diceStackView   = self.scoreCardStackView.arrangedSubviews[1]
        let aStackViewObj   = diceStackView as! UIStackView;
        let lastButton      = self.playerObj.getLastButton();
        let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
        var multiplier = 0
        if (rowId == 0) {
            multiplier = 1
        } else if (rowId == 1) {
            multiplier = 2
        } else if (rowId == 2){
            multiplier = 3
        } else if (rowId == 3){
            multiplier = 4
        } else if (rowId == 4){
            multiplier = 5
        } else if (rowId == 5){
            multiplier = 6
        }
        
        //now you get a button to iterate over
        for subStack in aStackViewObj.arrangedSubviews {
            let aButtonObj  = subStack as! UIButton;
            let diceVal     = multiplier * aButtonObj.tag
            
            aButtonObj.setTitle(String(diceVal), for: UIControlState.normal);
            
        }
        
    }
    
        
    //() are empty here because we have the data available within this function.
    func setText() {
        let playerName      = self.playerObj.getName() + ":";
        let lastButton      = self.playerObj.getLastButton();
        let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
        var text            = ""
      
       
        
        if (rowId == 0) {
            text = " Score for 1s"
            
            
        } else if (rowId == 1) {
            text = " Score for 2s"
           
            
        } else if (rowId == 2) {
            text = " Score for 3s"
           
            
        } else if (rowId == 3) {
            text = " Score for 4s"
            
            
        } else if (rowId == 4) {
            text = " Score for 5s"
            
            
        } else if (rowId == 5) {
            text = " Score for 6s"
           
            
        }
        
        //object that holds the text content
        let textObj         = NSMutableAttributedString(string:text)
        let mainColor       = KwPack.CustomYatzy().getMainColor()

        
        
        //here is an object array that will change the font color and make it bold
        let changeObj = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 24), NSForegroundColorAttributeName : mainColor];

        //object that holds the playerName, this is the one we want to make different
        //add the changeObjs
        let playerNameObj = NSMutableAttributedString(string:playerName, attributes: changeObj)

        //playerNameObj = takes the boldName and textObj together, so now playerNameObj always holds the append below. http://stackoverflow.com/questions/28496093/making-text-bold-using-attributed-string-in-swift we would set this as a variable on the lect with = something if we were expecting a return from the method.
        
        playerNameObj.append(textObj)
        
        self.upperRowDesc.attributedText = playerNameObj
        
    }
    
    @IBAction func setScore(_ scoreCardButton: UIButton) {
       print ("setscore?")
        //scoreval is for the button on the scorecard so we know which one you tapped
        let scoreVal        = scoreCardButton.tag
        //rowid is the last button tapped on the primary view
        let lastButton      = self.playerObj.getLastButton();
        let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
       
        
        var rData   = "";
        if (rowId == 0) {
            rData = self.playerObj.setOnes(scoreVal) 
        }   else if (rowId == 1) {
            rData = self.playerObj.setTwos(scoreVal);
        } else if (rowId == 2) {
            rData = self.playerObj.setThrees(scoreVal);
           //below is how you can get use getstack function to hide it when you select 3s this is a learning tool only
            // self.playerObj.getStack().isHidden = true
        } else if (rowId == 3) {
            print("setfours")
            rData = self.playerObj.setFours(scoreVal);
            print("after")
        } else if (rowId == 4) {
            rData = self.playerObj.setFives(scoreVal);
        } else if (rowId == 5) {
            rData = self.playerObj.setSixes(scoreVal);
        } else {
            print("Row Id: \(rowId), does not belong in this view controller");
        }
        
        
        
        if (rData == "") {
            print("Just Set Score Input: \(scoreVal)");
            print("For Player: \(self.playerObj.getId())");
            print("In Row: \(rowId)");
            
                        
            //success back to the main controller
            self.exitController(scoreCardButton)
            
            //self.dismiss(animated: true, completion: nil);
            
        } else {
            //there is a problem
            print(rData);
        }
    }

}
