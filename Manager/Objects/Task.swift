//
//  Task.swift
//  Manager
//
//  Created by Casey Corvino on 4/18/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import Foundation

class Task:NSObject, NSCoding {
    
    //Title property.
    var title: String;
    
    //Start and End properties.
    var start:Date?, end:Date?;
    
    //Estimation property.
    var estimation: String;
    
    // Contructor with 2 parameters.
    init (title: String, estimation: String)  {
        self.title = title;
        self.estimation = estimation;
    }
    
    // Helper function to get time worked converted to minutes. If missing start or end time return -1;
    func timeWorkedInMinutes() -> Int {
        let calendar = Calendar.current;
        if((self.start != nil) && (self.end != nil)){
            let startComponent = calendar.dateComponents([.hour, .minute], from: self.start ?? Date());
            let endComponent = calendar.dateComponents([.hour, .minute], from: self.end ?? Date());
            let minutes = calendar.dateComponents([.minute], from: startComponent, to: endComponent).minute!;
            return minutes;
        }
        return -1;
    }
    
    /*
     Decoding when loaded from User Defaults
     */
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as! String;
        self.estimation = decoder.decodeObject(forKey: "estimation") as! String;
        self.start = decoder.decodeObject(forKey: "start") as? Date;
        self.end = decoder.decodeObject(forKey: "end") as? Date;
    }
    /*
     Encoding when saving to User Defaults
     */
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title");
        aCoder.encode(self.estimation, forKey: "estimation");
        aCoder.encode(self.start, forKey: "start");
        aCoder.encode(self.end, forKey: "end");
    }
}
