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
     // Example on how to use in psuedocode:
     // Get tasks for today:
     tasks = taskService.LoadTasks(Date(), Date() + 1 day);
     
     // Some event that passes task id. ex. Set start time:
     task = taskService.GetTask(id);
     task.startTime = Date();
     taskService.UpdateTask(task);
    */
    
    /*
     Create and save a new task. Don't use let task = Task(...) to make tasks. Use this:
     */
    func NewTask(title: String, estimation: String, day: Date) -> Task {
        let id = getNextId();
        let task = Task.init(title: title, estimation: estimation, day: day, id: id);
        var tasks = LoadTasks();
        tasks.append(task);
        SaveTasks(arrayToSave: tasks);
        return task;
    }
    
    /*
     Create and save a new task. Don't use task = Task(...) to make tasks. Use this:
     */
    func GetTask(id: Int) -> Task? {
        let tasks = LoadTasks();
        for task in tasks {
            if task.id == id {
                return task;
            }
        }
        return nil;
    }
    
    /*
     Update a given task.
     */
    func UpdateTask(task: Task)-> Task {
        var tasks = LoadTasks();
        for i in tasks.indices {
            if tasks[i].id == task.id {
                tasks[i] = task;
            }
        }
        SaveTasks(arrayToSave: tasks);
        return task;
    }
    
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
    
    /*
     Get Tasks in between dates.
     */
    func LoadTasks(start: Date, end: Date)->[Task]{
        var temp:[Task] = [];
        let tasks = LoadTasks();
        for task in tasks{
            if((start ... end).contains(task.day ?? Date()) ){
                temp.append(task);
            }
        }
        return temp;
    }
    
    /*
     Get amount worked in between dates in minutes.
     */
    func timeWorkedInMinutes(start: Date, end: Date) -> Int{
        let tasks = LoadTasks();
        var totalTime = 0;
        for task in tasks{
            if((start ... end).contains(task.day ?? Date()) ){
                totalTime += task.timeWorkedInMinutes();
            }
        }
        return totalTime;
    }
    
    
    /* ======== helper functions ======= */
    /*
     Get next id
     */
    func getNextId() -> Int {
        let tasks = LoadTasks();
        let lastTask = tasks.last;
        if(lastTask != nil){
            return lastTask!.id + 1;
        }else{
            return 0;
        }
    }
}
