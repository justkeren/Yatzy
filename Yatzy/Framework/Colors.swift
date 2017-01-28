//
//  User.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/17/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

extension KwPack {
    
    
    class Colors {
     
        
        func getColorFromRGB(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
           
            let redColor    = CGFloat(Float(red)/255)
            let greenColor  = CGFloat(Float(green)/255)
            let blueColor   = CGFloat(Float(blue)/255)
            let colorObj    = UIColor(red:redColor, green:greenColor, blue:blueColor, alpha:1.0)
            
            
            
            return colorObj
        }
        
        func getColorFromHex(_ hexColor: String ) -> UIColor {
            
            //make string all uppercase
            let hexColor            = hexColor.uppercased();

            //the first 2 chars are for the red color
            let redStartIndex       = hexColor.index(hexColor.startIndex, offsetBy: 0);
            let redEndIndex         = hexColor.index(hexColor.startIndex, offsetBy: 1);
            let partRed             = hexColor[redStartIndex...redEndIndex];
            
            //chars 3 and 4 are for green
            let greenStartIndex     = hexColor.index(hexColor.startIndex, offsetBy: 2);
            let greenEndIndex       = hexColor.index(hexColor.startIndex, offsetBy: 3);
            let partGreen           = hexColor[greenStartIndex...greenEndIndex];
            
            //chars 5 and 6 are for blue
            let blueStartIndex      = hexColor.index(hexColor.startIndex, offsetBy: 4);
            let blueEndIndex        = hexColor.index(hexColor.startIndex, offsetBy: 5);
            let partBlue            = hexColor[blueStartIndex...blueEndIndex];

            //change the hex decimal values to decimal. i.e. "FF" is 255, "09" is 9 etc
            let redColor            = Int(partRed, radix: 16);
            let greenColor          = Int(partGreen, radix: 16);
            let blueColor           = Int(partBlue, radix: 16);
            
            //use the RGB color function to generate the color obj that we can return to the caller
            let colorObj            = self.getColorFromRGB(redColor!, greenColor!, blueColor!);
            
            //return the object
            return colorObj
            
        }
    }
}

