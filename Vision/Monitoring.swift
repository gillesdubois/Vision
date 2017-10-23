//
//  Monitoring.swift
//  Vision
//
//  Created by Gilles Dubois on 11/10/2017.
//  Copyright © 2017 Gilles Dubois. All rights reserved.
//

import UIKit
import os.log

class Monitoring: NSObject, NSCoding  {

    // MARK : Properties
    var name: String
    var serverUrl: String
    var isIcmp: Bool
    var isHttp: Bool
    var refreshRate: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("monitorings")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let serverUrl = "serverUrl"
        static let isIcmp = "isIcmp"
        static let isHttp = "isHttp"
        static let refreshRate = "refreshRate"
    }
    
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
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(serverUrl, forKey: PropertyKey.serverUrl)
        aCoder.encode(isIcmp, forKey: PropertyKey.isIcmp)
        aCoder.encode(isHttp, forKey: PropertyKey.isHttp)
        aCoder.encode(refreshRate, forKey: PropertyKey.refreshRate)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Monitoring object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let serverUrl = aDecoder.decodeObject(forKey: PropertyKey.serverUrl) as? String else {
            os_log("Unable to decode the name for a Monitoring object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Other properties
        let isIcmp = aDecoder.decodeBool(forKey: PropertyKey.isIcmp)
        let isHttp = aDecoder.decodeBool(forKey: PropertyKey.isHttp)
        let refreshRate = aDecoder.decodeInteger(forKey: PropertyKey.refreshRate)
        
        // Must call designated initializer.
        self.init(name: name, serverUrl: serverUrl, isIcmp: isIcmp, isHttp: isHttp, refreshRate: refreshRate)
    }

}
