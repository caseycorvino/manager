//
//  TaskServices.swift
//  Manager
//
//  Created by Casey Corvino on 4/18/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import Foundation

class TaskServices {
    
    /*
     Save tasks to user defaults.
     */
    func SaveTasks(arrayToSave: [Task]){
        do{
            let tasksData = try NSKeyedArchiver.archivedData(withRootObject: arrayToSave, requiringSecureCoding: false);
            UserDefaults.standard.set(tasksData, forKey: "tasks");
        }catch{
            print("task save error");
        }
    }
    
    /*
     Load tasks from user defaults.
     */
    func LoadTasks()->[Task]{
        if let tasksData = UserDefaults.standard.object(forKey: "tasks") as? NSData {
            return NSKeyedUnarchiver.unarchiveObject(with: tasksData as Data) as! [Task];
        }
        return [];
    }
    
}
