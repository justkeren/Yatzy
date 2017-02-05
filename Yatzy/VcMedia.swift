//
//  VcMedia.swift
//  Yatzy
//
//  Created by Keren Weinstein on 1/30/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

import AVFoundation

class VcMedia: UIViewController {
    var playerObj:
    KwPack.User!
    var parentVc:       VcPrimary!;
    var playerName:     String!
    var player:  AVAudioPlayer?

    @IBOutlet weak var ImageHolder: UIImageView!
    @IBOutlet weak var playerNameTextField: UITextField!
    
    var isLoading = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performMagic();
        self.isLoading  = false;
        DispatchQueue.main.async() {
            self.performMagic();
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func playSound(_ filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("url not found")
            return
        }
        
        
        do {
            /// this codes for making this app ready to takeover the device audio
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /// change fileTypeHint according to the type of your audio file (you can omit this)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)
            
            // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }

    
//    func textLayout(){
//        var txtField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00));
//        txtField.borderStyle = UITextBorderStyle.line
//        txtField.text = self.playerName
//        txtField.backgroundColor = UIColor.red
//        self.view.addSubview(txtField)
//        
//    }
    
    func performMagic() {

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
        if (self.isLoading == false) {
            self.playerObj.setNextEvent("");
            print("now exit");
            self.exitMedia();
        }
    }
    
    func gotYatzyMagic() {
        
        print("yatzy magic");
        if (self.isLoading == true) {
            print("doing setup")
            self.playerNameTextField.text = self.playerObj.getName();
            self.ImageHolder.image = UIImage(named: "Yatzy")
            
        } else {
            print("executing media")
            self.playSound("pianoSound")
            sleep(4)
        }
    }
    
    func noYatzy() {
        print("doing failed to get yatzy magic");
        
        if (self.isLoading == true) {
            self.playerNameTextField.text = self.playerObj.getName();
            self.ImageHolder.image = UIImage(named: "noYatzy")
            
        } else {
            self.playSound("noGood")
            sleep(4)
        }
    }


    
    func exitMedia() {
        print("leaving media");
        self.dismiss(animated: true, completion: nil);
        self.parentVc.returnFromSegue();
    }
}
