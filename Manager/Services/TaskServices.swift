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
     Example on how to use:
     
     Get tasks for today:
     tasks = taskService.LoadTasks(Date(), Date() + 1 day);
     
     
     Some event that passes task id. ex. Set start time:
     task = taskService.GetTask(id);
     task.startTime = Date();
     taskService.UpdateTask(task);
    */
    
    /*
     Create and save a new task. Don't use let task = Task(...) to make tasks. Use this:
     */
    func NewTask(title: String, day: Date) -> Task {
        let id = getNextId();
        let task = Task.init(title: title, day: day, id: id);
        var tasks = LoadTasks();
        tasks.append(task);
        SaveTasks(arrayToSave: tasks);
        return task;
    }
    
    /*
     delete task
     */
    func DeleteTask(id: Int){
        var tasks = LoadTasks();
        for (index, task) in tasks.enumerated() {
            if Int(truncating: task.id) == id {
                tasks.remove(at: index);
                break;
            }
        }
        SaveTasks(arrayToSave: tasks);
    }
    
    /*
     Create and save a new task. Don't use task = Task(...) to make tasks. Use this:
     */
    func GetTask(id: Int) -> Task? {
        let tasks = LoadTasks();
        for task in tasks {
            if Int(truncating: task.id) == id {
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
            NSKeyedArchiver.setClassName("Task", for: Task.self);
            let tasksData = try NSKeyedArchiver.archivedData(withRootObject: arrayToSave, requiringSecureCoding: false);
            UserDefaults.init(suiteName: "group.com.caseycorvino.manager")?.set(tasksData, forKey: "tasks");
        }catch{
            print("task save error");
        }
    }
    
    /*
     Load tasks from user defaults.
     */
    func LoadTasks()->[Task]{
        if let tasksData = UserDefaults.init(suiteName: "group.com.caseycorvino.manager")?.object(forKey: "tasks") as? NSData {
            NSKeyedUnarchiver.setClass(Task.self, forClassName: "Task");
            return NSKeyedUnarchiver.unarchiveObject(with: tasksData as Data) as! [Task];
        }
        return [];
    }
    
    /*
     Set start time to now for all tasks today.
     */
    func setStartTime(){
        var calendar = NSCalendar.current;
        calendar.timeZone = NSTimeZone.local;
        let start = calendar.startOfDay(for: Date())
        let end = Date(timeInterval: 86400, since: start);
        let tasks = LoadTasks(start: start, end: end)
        for task in tasks{
            task.start = Date();
            _ = UpdateTask(task: task);
        }
    }
    
    /*
     Set end time to now for all tasks today.
     */
    func setEndTime(){
        var calendar = NSCalendar.current;
        calendar.timeZone = NSTimeZone.local;
        let start = calendar.startOfDay(for: Date())
        let end = Date(timeInterval: 86400, since: start);
        let tasks = LoadTasks(start: start, end: end)
        for task in tasks{
            task.end = Date();
            _ = UpdateTask(task: task);
        }
    }

    /*
     Get Tasks in between dates.
     */
    func LoadTasks(start: Date, end: Date)->[Task]{
        var temp:[Task] = [];
        let tasks = LoadTasks();
        for task in tasks{
            if((start ... end).contains(task.day!) ){
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
    
    /*
     This creates hardcoded tasks for the last 5 days.
     */
    func generateTasks(){
        SaveTasks(arrayToSave: []);
        let now = Date();
        var calendar = NSCalendar.current;
        calendar.timeZone = NSTimeZone.local;
        let start = calendar.startOfDay(for: now)
        print(start);
        for i in 1...7{
            let rand = arc4random_uniform(6) + 1;
            for _ in 1...rand{
                let t = NewTask(title: "Demo Task", day: Date.init(timeInterval: -86400 * Double(i) + 100, since: start));
                t.start = Date.init(timeInterval: -86400 * Double(i) + 28000, since: start);
                t.end = Date.init(timeInterval: -86400 * Double(i) + 31600, since: start);
                _ = UpdateTask(task: t);
            }
        }
        let tasks = LoadTasks();
        for t in tasks{
            print(t.start,t.end);
        }
    }
    
    
    /* ======== helper functions ======= */
    /*
     Get next id
     */
    func getNextId() -> Int {
        let tasks = LoadTasks();
        let lastTask = tasks.last;
        if(lastTask != nil){
            return Int(truncating: lastTask!.id) + 1;
        }else{
            return 0;
        }
    }
}
