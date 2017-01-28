//
//  SecondViewController.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/17/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcDice: UIViewController {

    //must be set on segue prepare from the sending viewController
    var playerObj: KwPack.User!
    
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var scoreCardStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setText()
        self.changeTextOnButton()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func changeTextOnButton() {
        let diceStackView   = self.scoreCardStackView.arrangedSubviews[1]
        let aStackViewObj   = diceStackView as! UIStackView;
        let lastButton      = self.playerObj.getLastButton();
        let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
        var multiplier = 0
        if (rowId == 8) {
            multiplier = 2
        } else if (rowId == 10){
            multiplier = 3
        } else if (rowId == 11){
            multiplier = 4
        }
        
        
        //now you get a button to iterate over
        for subStack in aStackViewObj.arrangedSubviews{
            let aButtonObj  = subStack as! UIButton;
            let diceVal     = multiplier * aButtonObj.tag
            
            aButtonObj.setTitle(String(diceVal), for: UIControlState.normal);
            aButtonObj.setImage(nil, for: UIControlState.normal)
          
        }
       
    }
    
    func setText () {
        let lastButton      = self.playerObj.getLastButton();
        let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
        var text            = ""
        
        if (rowId == 8) {
            text = "One Pair in?"
            
        } else if (rowId == 10) {
            text = "Three of a kind in?"
            
        } else if (rowId == 11) {
            text = "Four of a kind in?"
        }
        
        self.textDescription.text = text
        
    }
    
    @IBAction func setScore(_ scoreCardButton: UIButton) {
        
        let scoreVal        = scoreCardButton.tag
        let rowId           = KwPack.TagConvert().getRowIdFromButton(playerObj.getLastButton());

        var rData   = "";
        if (rowId == 8) {
            rData = self.playerObj.setOnePair(scoreVal);
        } else if (rowId == 10) {
            rData = self.playerObj.setThreeKind(scoreVal);
        } else if (rowId == 11) {
            rData = self.playerObj.setFourKind(scoreVal);
        } else {
             print("Row Id: \(rowId), does not belong in this view controller");
        }
        
        if (rData == "") {
            print("Just Set Score Input: \(scoreVal)");
            print("For Player: \(self.playerObj.getId())");
            print("In Row: \(rowId)");
            
            //success back to the main controller
            self.dismiss(animated: true, completion: nil);
            
        } else {
            //there is a problem
            print(rData);
        }
    }
}
