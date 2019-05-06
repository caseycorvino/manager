//
//  Task.swift
//  Manager
//
//  Created by Casey Corvino on 4/18/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import Foundation

@objc(Task)
open class Task:NSObject, NSCoding {
    
    //iD
    var id: NSNumber;
    
    //Title property.
    var title: String;
    
    //Start and End properties.
    var start:Date?, end:Date?;
    
    var day: Date?;
    
    //Estimation property.
    var estimation: String;
    
    // Contructor with 2 parameters.
    init (title: String, estimation: String, day: Date, id:Int)  {
        self.title = title;
        self.estimation = estimation;
        self.day = day;
        self.id = id as NSNumber;
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
        return 0;
    }
    
    /*
     Decoding when loaded from User Defaults
     */
    required public init(coder decoder: NSCoder) {
        self.id = decoder.decodeObject(forKey: "id") as! NSNumber;
        self.title = decoder.decodeObject(forKey: "title") as! String;
        self.estimation = decoder.decodeObject(forKey: "estimation") as! String;
        self.start = decoder.decodeObject(forKey: "start") as? Date;
        self.end = decoder.decodeObject(forKey: "end") as? Date;
        self.day = decoder.decodeObject(forKey: "day") as? Date;
    }
    /*
     Encoding when saving to User Defaults
     */
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id");
        aCoder.encode(self.title, forKey: "title");
        aCoder.encode(self.estimation, forKey: "estimation");
        aCoder.encode(self.start, forKey: "start");
        aCoder.encode(self.end, forKey: "end");
        aCoder.encode(self.day, forKey: "day");
    }
}
