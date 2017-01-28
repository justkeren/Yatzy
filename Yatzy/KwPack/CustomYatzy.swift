//
//  User.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/17/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

extension KwPack {
    
    
    class CustomYatzy {
        
        func getMainColor() -> UIColor {
            let mainColor = KwPack.Colors().getColorFromRGB(126, 19, 70)
            
            return mainColor
        }
        
        func getButtonColor() -> UIColor {
            let buttonColor = KwPack.Colors().getColorFromRGB(255, 0, 0)
            
            return buttonColor
        }
        
        func setButtonColor(_ buttonToColor: UIButton) -> Void {
            //function's purpose is to color the button. Don't need to return this button back since the caller already has this button. We just coloring button.
           
            let buttonColor = self.getButtonColor()
            
            KwPack.Buttons().setButtonColor(buttonToColor, buttonColor)
        }
        
        func formatScoreButtonsInStack(_ stackToColor: UIStackView) -> Void {
            //for each button in the araay do something. stackview that only contains buttons for now
            for aButton in stackToColor.arrangedSubviews {
                //this makes it explicit that the element is a button
                let aButtonObj = aButton as! UIButton;
                
                self.setButtonColor(aButtonObj)
                
                //aButtonObj.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
                aButtonObj.layer.cornerRadius = 0.5 * aButtonObj.bounds.size.width
                aButtonObj.clipsToBounds = true
              
            }
            
        }
        
    }
}

