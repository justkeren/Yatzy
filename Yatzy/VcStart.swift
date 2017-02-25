//
//  VcTest.swift
//  Yatzy
//
//  Created by Keren Weinstein on 1/22/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcStart: UIViewController {


    @IBOutlet weak var playerNameStack: UIStackView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
   

    }
    
        // Do any additional setup after loading the view.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func startGame (_ startGameButton: UIButton) {
        performSegue(withIdentifier: "toVcPrimary", sender: "")
    }
    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepared to segue to other view controller");
        
        let vcName = NSStringFromClass(segue.destination.classForCoder)
        print(vcName);
        
        //set the playerName obj in the controller we are about to show
        if (vcName == "Yatzy.VcPrimary") {
            let nextCtrl = segue.destination as! VcPrimary;
            nextCtrl.playerNames = self.playerNameStack;
        } else {
            print("Failed to match segue to primary controller");
        }
    }
}
