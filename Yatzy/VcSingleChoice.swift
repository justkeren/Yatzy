//
//  VcSingleChoice.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/18/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcSingleChoice: UIViewController {

    //must be set on segue prepare from the sending viewController
    var playerObj: KwPack.User!
    var parentVc: VcPrimary!;
    
    @IBOutlet weak var TextDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setText()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setText () {
        let playerName      = self.playerObj.getName() + ", ";
        let lastButton      = self.playerObj.getLastButton();
        let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
        var text            = ""
        
        if (rowId == 13) {
            text = " did you get the Small Straight?"
            
        } else if (rowId == 14) {
            text = " did you get the Large Straight?"
            
        } else if (rowId == 16) {
            text = " did you get Yatzy?"
        }
        
        //object that holds the text content
        let textObj         = NSMutableAttributedString(string:text)
        let mainColor       = KwPack.CustomYatzy().getNameColor()
        
        
        let changeObj = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 20), NSForegroundColorAttributeName : mainColor];
        let playerNameObj = NSMutableAttributedString(string:playerName, attributes: changeObj)
        
        playerNameObj.append(textObj)
        
        self.TextDescription.attributedText = playerNameObj

    }
    

    
    @IBAction func setScore(_ scoreCardButton: UIButton) {
        //scoreval is for the button on the scorecard so we know which one you tapped
        let scoreVal        = scoreCardButton.tag
        //rowid is the last button tapped on the primary view
        let lastButton      = self.playerObj.getLastButton();
        let rowId           = KwPack.TagConvert().getRowIdFromButton(lastButton);
        
        var rData   = "";
        if (rowId == 13) {
            rData = self.playerObj.setSmallStraight(scoreVal);
        } else if (rowId == 14) {
            rData = self.playerObj.setLargeStraight(scoreVal);
        } else if (rowId == 16) {
            rData = self.playerObj.setYatzy(scoreVal);
        } else {
            print("Row Id: \(rowId), does not belong in this view controller");
        }
        
        
        
        if (rData == "") {
            print("Just Set Score Input: \(scoreVal)");
            print("For Player: \(self.playerObj.getId())");
            print("In Row: \(rowId)");
            
            //success back to the main controller.
            self.exitScoreCard();
            
        } else {
            //there is a problem
            print(rData);
        }
    }
    
    func exitScoreCard()
    {
        self.dismiss(animated: true, completion: nil);
        self.parentVc.returnFromSegue()
    }
}
