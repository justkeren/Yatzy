//
//  PermStore.swift
//  YatzyMVC
//
//  Created by Keren Weinstein on 1/17/17.
//  Copyright © 2017 Keren Weinstein. All rights reserved.
//

import Foundation

extension KwPack {
    class PermStore {
        static let obj = PermStore();
        private init() {};
        
        var initialized = false;
        var userObjs: [KwPack.User] = [];
        
        func getInitialized () -> Bool {
            return self.initialized;
        }
        func setInitialized(_ initVal: Bool) -> Void {
            self.initialized    = initVal;
        }
    }
}
