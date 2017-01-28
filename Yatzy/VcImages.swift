//
//  VcImages.swift
//  Yatzy
//
//  Created by Keren Weinstein on 1/26/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

class VcImages: UIViewController {

    @IBOutlet weak var imageHolder: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var image1: [UIImage] = [
        UIImage(named: "Sad_Face_Emoji")!,
        UIImage(named: "dice1")!
    ]
    
    


}
