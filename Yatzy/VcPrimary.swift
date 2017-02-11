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

    
    
    @IBOutlet var allScoreButtons: [UIButton]!
    @IBOutlet weak var testButton: UIButton!
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
        
//        self.setButtonTitle()
       // KwPack.CustomYatzy().formatScoreButtonsInStack(self.masterStack)
    
        
    }
    
    
    func returnFromSegue() {
        
        print("we have returned from the segue");
        //this gets triggered everytime we return from a segue.
        let hasEvent    = self.lastPlayer.getNextEvent()
        if (hasEvent != "") {
            performSegue(withIdentifier: "toVcMedia", sender: self.lastPlayer)
        }
        
        self.setPlayerTurnColors()
        
        
    }
    
//    func setButtonTitle() {
//        for aButton in self.allScoreButtons {
//            //aButton goes in the () because the methods needs one button. aButton is one button at a time (array).
//            let rowId = KwPack.TagConvert().getRowIdFromButton(aButton)
//            
//            if (rowId == 0){
//                aButton.setTitle("Ones", for: UIControlState.normal)
//                print("Ones")
//            }
//            
//        }
//        
//        print("set button title ran")
//       
//        
//    }
    
    
    func setPlayerTurnColors () -> Void {
        let currentPlayer   = self.getCurrentPlayer()
        //let current         = currentPlayer.getTurnComplete()
       
        for allPlayersObj in KwPack.PermStore.obj.userObjs {
            //if playerObj equal to currentPlayer they are the same. I can use either to color the stack.
            if (allPlayersObj.getId() == currentPlayer.getId()){
                //this is the current player
               KwPack.CustomYatzy().formatScoreButtonsInStack(currentPlayer.getStack())
            } else {
                //this is everyone that is not current
                
                KwPack.CustomYatzy().changebackStackColor(allPlayersObj.getStack())
            }
            
        }
  
    }
    
    func getCurrentPlayer() -> KwPack.User {
        //FUNCTION: RETURNS CURRENT PLAYER ONLY
        let activePlayerCheck   = self.lastPlayer.getTurnComplete()
        //this is a varaible that holds a single instance of a user
        var nextPlayerObj       = self.lastPlayer
        
        
        if (activePlayerCheck == true) {
            let lastPlayerTest = KwPack.PermStore.obj.userObjs.last
            
            if (lastPlayerTest?.getTurnComplete() == true) {
                nextPlayerObj = KwPack.PermStore.obj.userObjs.first
                
            } else {
                
                var foundYou = false
                
                for playerObj in KwPack.PermStore.obj.userObjs {
                    
                    let isItYou = playerObj.getTurnComplete()
                    if (isItYou == true) {
                        //here we know we want the next player
                        foundYou = true
                    } else if (foundYou == true) {
                        nextPlayerObj = playerObj
                        foundYou = false
                    }
                }
            }
            
            self.lastPlayer.setTurnComplete(false)
            
        }
        return nextPlayerObj!
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
