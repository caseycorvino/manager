//
//  ViewController.swift
//  Manager
//
//  Created by Casey Corvino on 4/11/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //No need to import, just declare the singleton like this :-)
    let taskServices = TaskServices();
    
    var tasks:[Task]? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Casey's example on how to use the services.
        //load from saved data:
        tasks = taskServices.LoadTasks();
        print(tasks!);

        //save a task:
        let newtask = Task(title: "Task Example",estimation: "<1");
        newtask.start = Date();
        tasks?.append(newtask);
        taskServices.SaveTasks(arrayToSave: tasks!);//Saves new array
        print(taskServices.LoadTasks());
        
        //to clear the saved array:
        taskServices.SaveTasks(arrayToSave: []);//Saves new array
        print(taskServices.LoadTasks());
        
    }


}

