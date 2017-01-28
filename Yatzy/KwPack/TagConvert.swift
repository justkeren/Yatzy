//
//  User.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/17/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import UIKit

extension KwPack {
    
    
    class TagConvert {
        
        func getRowIdFromButton(_ button: UIButton) -> Int {
            
            let number = button.tag;
            if (number > 100 && number < 200) {
                
                return 0;
                
            } else if (number > 200 && number < 300) {
                
                return 1;
                
            } else if (number > 300 && number < 400) {
                
                return 2;
                
            } else if (number > 400 && number < 500)  {
                
                return 3;
                
            } else if (number > 500 && number < 600) {
                
                return 4;
                
            } else if (number > 600 && number < 700) {
                
                return 5;
                
            } else if (number > 700 && number < 800) {
                
                return 6;
                
            } else if (number > 800 && number < 900) {
                
                return 7;
                
            } else if (number > 900 && number < 1000) {
                
                return 8;
                
            } else if (number > 1000 && number < 1100) {
                
                return 9;
                
            } else if (number > 1100 && number < 1200) {
                
                return 10;
                
            } else if (number > 1200 && number < 1300) {
                
                return 11;
                
            } else if (number > 1300 && number < 1400) {
                
                return 12;
                
            } else if (number > 1400 && number < 1500) {
                
                return 13;
                
            } else if (number > 1500 && number < 1600) {
                
                return 14;
                
            } else if (number > 1600 && number < 1700) {
                
                return 15;
                
            } else if (number > 1700 && number < 1800) {
                
                return 16;
                
            } else if (number > 1800 && number < 1900) {
                
                return 17;
                
            } else if (number > 1900 && number < 2000) {
                
                return 18;
                                
            }  else {
                return 99999;
            }
        }
        
        func getPlayerFromButton(_ button: UIButton) -> KwPack.User {
            
            let pId         = self.getPlayerIdFromButton(button);
            //players are indexed from 0 but the getPlayerId return player 1 as the number 1
            return KwPack.PermStore.obj.userObjs[(pId - 1)];
        }
        
        
        func getPlayerIdFromButton(_ button: UIButton) -> Int {
            
            do {
                
                let text        = String(button.tag);
                let regex       = try NSRegularExpression(pattern: "([0-9]{1})$", options: [])
                let nsString    = text as NSString
                let results     = regex.matches(in: text, options: [], range: NSMakeRange(0, nsString.length))
                let pids        = results.map { nsString.substring(with: $0.range)}
                return Int(pids[0])!;
                
            } catch let error as NSError {
                print("invalid regex: \(error.localizedDescription)")
                return 99999
            }
        }

    }
}

