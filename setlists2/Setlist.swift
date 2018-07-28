//
//  Setlist.swift
//  setlists2
//
//  Created by Chris McQueen on 7/26/18.
//  Copyright © 2018 Chris McQueen. All rights reserved.
//

import Foundation

class Setlist: NSObject, NSCoding {
    
    var name: String
    var key: String
   
    // The following code required to allow for NSCoding (saving and loading data)
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "setlistName")
        aCoder.encode(key, forKey: "songKey")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "setlistName") as! String
        let key = aDecoder.decodeObject(forKey: "songKey") as! String
        self.init(name: name, key: key)
    }
    
    init?(name: String, key: String) {
        self.name = name
        self.key = key
        super.init()
    }
    
    static let Dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = Dir.appendingPathComponent("setlists")
    
}
