//
//  Monitoring.swift
//  Vision
//
//  Created by Gilles Dubois on 11/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import UIKit
import os.log

class Monitoring: NSObject  {

    // MARK : Properties
    var name: String
    var serverUrl: String
    var isIcmp: Bool
    var isHttp: Bool
    var refreshRate: Int
    
    //MARK: Initialization
    init?(name: String, serverUrl: String, isIcmp: Bool, isHttp: Bool, refreshRate: Int) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // server url too
        guard !serverUrl.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.serverUrl = serverUrl
        self.isIcmp = isIcmp
        self.isHttp = isHttp
        self.refreshRate = refreshRate
    }

}
