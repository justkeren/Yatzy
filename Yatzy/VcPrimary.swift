//
//  ViewController.swift
//  Yatzy
//
//  Created by Keren Weinstein on 1/8/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcPrimary: UIViewController {

    //this holds the buttons: upperscore total, bonus and lowerscore total for all players (array)
    @IBOutlet var allButtons: [UIButton]!;

    @IBOutlet weak var masterStack: UIStackView!
    
    var playerNames: UIStackView!
    var lastPlayer : KwPack.User!;
    
    @IBOutlet weak var goBackView: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    
        //init new game with X users, this needs to move to a function that is
        //called once a game is restarted
        let playerCount = self.countPlayers()
        self.initGame(playerCount);
    }
    //dont need anything in () because it has access to what it needs in the Class (playerNames).
    func countPlayers() -> Int {
        var playerCount = 0
        //When the array is in a for loop, then you dont need to specify the index of the array like [1]
        
        let onlyUITextFields = self.playerNames.arrangedSubviews.filter{ $0 is UITextField }
        for textFieldObj in onlyUITextFields {
            
            let textObj         = textFieldObj as! UITextField;
            //have to do .text because the textobj is an object.
            if (textObj.text != ""){
                playerCount += 1
            }
            
        }
        
        print(playerCount)
        return playerCount
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initGame(_ count: Int) -> Void {
        
        //PLAYERS CREATED
        for i in (1...count) {
            //we create a new player oject
            let pObj    = KwPack.User();
            //we set the player object Id to 1 (store the player 1, and then 2, then 3, etc)
            pObj.setId(i);
            //playerstackview is an array of objects, "stack" is just the single instance of one of the stacks. So stack for player 1 is in "stack"  once there are no more stacks, it is done.
            
            let stackObj = self.masterStack.arrangedSubviews[i];
            pObj.setStack(stackObj as! UIStackView)
            
            pObj.setIsActive(true);
            KwPack.PermStore.obj.userObjs.append(pObj);
        }
        // ASSIGN EACH BUTTON TO THE CORRECT PLAYER
        for aButton in self.allButtons {
            let playerId       = KwPack.TagConvert().getPlayerIdFromButton(aButton);
            
            if (playerId <= count) {
                let playerObj       = KwPack.TagConvert().getPlayerFromButton(aButton);
                playerObj.setButton(aButton);
                
            }
            //print("Tag: \(aButton.tag) belongs to player: \(playerObj.getId()) in row: \(rowId)");
        }
        
        //loop through each player that we created. //Assign player names from VsStart to each player.
        for playerObj in KwPack.PermStore.obj.userObjs {
            let playerId        = playerObj.getId()
            let textFieldObj    = self.playerNames.arrangedSubviews[(playerId - 1)];
            let textObj         = textFieldObj as! UITextField;
            
            playerObj.setName(textObj.text!)
            
            
            //print("Added: \(count) users to a new game");
        }
    }
    
    func returnFromSegue() {
        
        print("we have returned from the segue");
        //this gets triggered everytime we return from a segue.
        let hasEvent    = self.lastPlayer.getNextEvent()
        if (hasEvent != "") {
            performSegue(withIdentifier: "toVcMedia", sender: self.lastPlayer)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepared to segue to other view controller");
        //this function is triggered after every segue
        //before switching view down cast the sender as a User Obj
        let userObj     = sender as! KwPack.User;
        self.lastPlayer = userObj;
        
        let vcName = NSStringFromClass(segue.destination.classForCoder)
        print(vcName);
        
        //set the player obj in the controller we are about to show
        if (vcName == "Yatzy.VcDice") {
            let nextCtrl = segue.destination as! VcDice;
            nextCtrl.playerObj   = userObj;
            nextCtrl.parentVc    = self;
        } else if (vcName == "Yatzy.VcUpper") {
            let nextCtrl = segue.destination as! VcUpper;
            nextCtrl.playerObj   = userObj;
             nextCtrl.parentVc   = self;
        } else if (vcName == "Yatzy.VcSingleChoice") {
            let nextCtrl = segue.destination as! VcSingleChoice;
            nextCtrl.playerObj   = userObj;
            nextCtrl.parentVc    = self;
        } else if (vcName == "Yatzy.VcChoice") {
            let nextCtrl = segue.destination as! VcChoice;
            nextCtrl.playerObj   = userObj;
            nextCtrl.parentVc    = self;
        }else if (vcName == "Yatzy.VcMedia") {
            let nextCtrl = segue.destination as! VcMedia;
            nextCtrl.playerObj   = userObj;
            nextCtrl.parentVc    = self;
        } else {
            print("Failed to match segue to a controller");
        }
    }
    
    @IBAction func newGame(_ newGameButton: UIButton) {
        goBackView.isHidden = false
        
        if (newGameButton.tag == 0){
            //performSegue(withIdentifier: "toVcStart", sender: "")
            print("so close")
            KwPack.PermStore.obj.userObjs.removeAll();
            self.dismiss(animated: true, completion: nil);
        } else if (newGameButton.tag == 1) {
            goBackView.isHidden = true
        }
    }
    
    @IBAction func scoreInput(_ scoreButton: UIButton) {
        // this fuction is responsible for which scorecard you will see
        
        let rowId           = KwPack.TagConvert().getRowIdFromButton(scoreButton);
        let playerObj       = KwPack.TagConvert().getPlayerFromButton(scoreButton);
        playerObj.setLastButton(scoreButton);
        
        print("Row: \(rowId), pressed")

// we know segue to the correct scorecard controller, the first thing a segue does is trigger the prepare function in this class.
        if (rowId < 6) {
            
            print("jumping to UpperView");
            performSegue(withIdentifier: "toUpperView", sender: playerObj)
            
        } else if (rowId == 8 || rowId == 10 || rowId == 11){
            
            
            print("jumping to DiceView");
            performSegue(withIdentifier: "toDiceView", sender: playerObj)
            
        } else if (rowId == 13 || rowId == 14 || rowId == 16){
            
            print("single choice scorecard:\(rowId)")
            performSegue(withIdentifier: "toSingleView", sender: playerObj)
            
        } else if (rowId == 9 || rowId == 12 || rowId == 15){
            
            print ("mutlichoice scorecard:\(rowId)")
            performSegue(withIdentifier: "toChoiceView", sender: playerObj)

            
        }
    }
}
