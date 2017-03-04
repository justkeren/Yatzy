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
            let mainColor = KwPack.Colors().getColorFromHex("59D3A3")
            
            return mainColor
        }
        
        func getNameColor() -> UIColor {
            let nameColor = KwPack.Colors().getColorFromHex("4C4C4C")
            
            return nameColor
        }

        func getButtonColor() -> UIColor {
            let buttonColor = KwPack.Colors().getColorFromHex("e8eaf6")
            
            return buttonColor
        }
        
        func setButtonColor(_ buttonToColor: UIButton) -> Void {
            //function's purpose is to color the button. Don't need to return this button back since the caller already has this button. We just coloring button.
           
            let buttonColor = self.getButtonColor()
            
            KwPack.Buttons().setButtonColor(buttonToColor, buttonColor)
        }
        
        
        func testFormatButtons (_ stackToColor: UIStackView) -> Void {
            //for each button in the araay do something. stackview that only contains buttons for now
            
            for subViewObj in stackToColor.arrangedSubviews {
                
                let className   = String(describing: subViewObj.classForCoder);
                
                if (className == "UIButton") {
                    
                    //this makes it explicit that the element is a button
                    let aButtonObj = subViewObj as! UIButton;
                    
                    let borderAlpha : CGFloat = 0.7
                    let cornerRadius : CGFloat = 5.0
                    
                    aButtonObj.setTitleColor(UIColor.white, for: UIControlState.normal)
                    aButtonObj.backgroundColor = UIColor.clear
                    aButtonObj.layer.borderWidth = 0.5
                    aButtonObj.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
                    aButtonObj.layer.cornerRadius = cornerRadius
                    
                    

                    
                } else if (className ==  "UIStackView") {
                    //if you give this function a masterstack, it will take the stack view obj out and then run the function over to get the buttons out.
                    let aStackViewObj = subViewObj as! UIStackView;
                    self.formatScoreButtonsInStack(aStackViewObj)
                }
            }
        }
        
    
        
        
        
        func formatScoreButtonsInStack(_ stackToColor: UIStackView) -> Void {
            //for each button in the araay do something. stackview that only contains buttons for now
           
            for subViewObj in stackToColor.arrangedSubviews {
                
                let className   = String(describing: subViewObj.classForCoder);

                if (className == "UIButton") {
                    
                    //this makes it explicit that the element is a button
                    let aButtonObj = subViewObj as! UIButton;
                        KwPack.Buttons().setButtonColor(aButtonObj, getButtonColor())
                    
                    
            
                    //aButtonObj.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
//                    aButtonObj.layer.cornerRadius = 0.5 * aButtonObj.bounds.size.width
//                    aButtonObj.clipsToBounds = true
 
//                    let rowId = KwPack.TagConvert().getRowIdFromButton(aButtonObj)
//                    if (rowId != 99999 && rowId != 18){
//                        
//                        self.setButtonColor(aButtonObj)
//                        aButtonObj.showsTouchWhenHighlighted = true
//                        aButtonObj.setTitleColor(KwPack.Colors().getColorFromHex("B3B3B3"), for: .normal)
//                        var title = ""
//                        
//                        if (rowId == 0) {
//                           title = "Ones"
//                        
//                            
//                        } else if (rowId == 1) {
//                           title = "Twos"
//                            
//                            
//                        } else if (rowId == 2) {
//                            title = "Threes"
//                            
//                        } else if (rowId == 3) {
//                             title = "Fours"
//                            
//                        } else if (rowId == 4) {
//                        
//                            title = "Fives"
//                        } else if (rowId == 5) {
//                            title = "Sixes"
//                        } else if (rowId == 8) {
//                            title = "One Pair"
//                        } else if (rowId == 9) {
//                            title = "Two Pair"
//                        } else if (rowId == 10) {
//                            title = "Three of a Kind"
//                        } else if (rowId == 11) {
//                            title = "Full House"
//                        }
//                
//                        aButtonObj.setTitle(title, for: UIControlState.normal)
//        
//                        
//                    } else {
//                        //labels will be in here because rowId == 99999
//                        
//                    }
//                    
//                    
                } else if (className ==  "UIStackView") {
                    //if you give this function a masterstack, it will take the stack view obj out and then run the function over to get the buttons out.
                     let aStackViewObj = subViewObj as! UIStackView;
                    self.formatScoreButtonsInStack(aStackViewObj)
                }
            }
        }
        
        
        
        func changebackStackColor (_ stackToColor: UIStackView) -> Void {
            //for each button in the araay do something. stackview that only contains buttons for now
             let buttonColor1 = KwPack.Colors().getColorFromHex("7986cb")
            for subViewObj in stackToColor.arrangedSubviews {
                
                let className   = String(describing: subViewObj.classForCoder);
                
                if (className == "UIButton") {
                    
                    //this makes it explicit that the element is a button
                    let aButtonObj = subViewObj as! UIButton;
                    
                    
                      KwPack.Buttons().setButtonColor(aButtonObj, buttonColor1)

                    aButtonObj.showsTouchWhenHighlighted = true
                    
                    //aButtonObj.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
//                    aButtonObj.layer.cornerRadius = 0.5 * aButtonObj.bounds.size.width
//                    aButtonObj.clipsToBounds = true
                    
                } else if (className ==  "UIStackView") {
                    let aStackViewObj = subViewObj as! UIStackView;
                    self.formatScoreButtonsInStack(aStackViewObj)
                }
            }
        }
    }
    
}



