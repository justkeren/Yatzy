//
//  VcMedia.swift
//  Yatzy
//
//  Created by Keren Weinstein on 1/30/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcMedia: UIViewController {
    
    var playerObj: KwPack.User!
    var parentVc: VcPrimary!;

    @IBOutlet weak var ImageHolder: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.performMagic();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func performMagic()
    {
        //get the event name
        let eventName   = self.playerObj.getNextEvent();
        let eName       = eventName.lowercased()
        //perform something based on the eventName
        //that way we can keep the logic of each event seperate
        if (eName == "gotyatzy") {
            self.gotYatzyMagic();
        } else if (eName == "noyatzyforu") {
            self.noYatzy();
        } else {
            //this event does not have any action yet
        }

        //reset the player event so we do not cause a loop
        self.playerObj.setNextEvent("");
        //completed 
        self.exitMedia();
    }
    
    func gotYatzyMagic()
    {
        print("doing got yatzy magic");
        //get the player name
        let playerName   = self.playerObj.getName();
        let pName        = playerName.lowercased();
        
        //now execute something based on the player name
        if (pName == "maria") {
            //do something
        }
    }
    
    func noYatzy()
    {
        print("doing failed to get yatzy magic");
        //get the player name
        let playerName   = self.playerObj.getName();
        let pName        = playerName.lowercased();
        
        //now execute something based on the player name
        if (pName == "martin") {
            //do something
        }
    }

    func exitMedia()
    {
        print("leaving media");
       
        
        self.dismiss(animated: true, completion: nil);
        self.parentVc.returnFromSegue();
        print("out of media");
    }
}
