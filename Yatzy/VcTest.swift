//
//  VcTest.swift
//  Yatzy
//
//  Created by Keren Weinstein on 1/22/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcTest: UIViewController {

  
    
    @IBOutlet weak var masterStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func kerenTest (){
        let firstView = self.masterStack.arrangedSubviews[0]
        
        if(firstView.isHidden == false){
           firstView.isHidden = true
        } else {
            firstView.isHidden = false
            
        }
        
        
    
    }

    @IBAction func buttonTest(_ sender: UIButton) {
        self.kerenTest()
    }

}
