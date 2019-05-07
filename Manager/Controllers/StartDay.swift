//
//  StartDay.swift
//  Manager
//
//  Created by Alex Li on 5/5/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class StartDay: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
 {
    
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var Day1: UILabel!
    @IBOutlet weak var Day2: UILabel!
    @IBOutlet weak var Day3: UILabel!
    @IBOutlet weak var Day4: UILabel!
    @IBOutlet weak var Day5: UILabel!
    @IBOutlet weak var Day6: UILabel!
    @IBOutlet weak var Day7: UILabel!
    
    @IBOutlet weak var AddNewTaskField: UITextField!
    @IBOutlet weak var textSendBtn: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!

    let taskServices = TaskServices()
    let utils = Utils()
    let currentDate = Date()
    
    let unstartedBtn = UIImage(named: "NotStartedBtn.png")
    let startedBtn = UIImage(named: "StartedBtn.png")
    let finishedBtn = UIImage(named: "FinishedBtn.png")
    
    private var taskID: [NSNumber] = []
    private var taskTitles: [String] = []
    private var taskState: [Int] = [] // Unstarted: 0, Started: 1, Finished: 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set footer calendar
        let daysArray = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        utils.setDates(today: 3, month: MonthLabel, days: daysArray as! Array<UILabel>)
        
        // Table setup
        populateTable(date: currentDate)
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.0)
        
        // Add new task field setup
        self.AddNewTaskField.delegate = self
        
        // Testing
        print("printing initial tasks count")
        print(taskServices.LoadTasks().count)
        
    }
    
    // Pull tasks from server onto interface
    func populateTable(date: Date) {
        let times = utils.getDateStartEnd(date: date)
        
        let tasks = taskServices.LoadTasks(start: times[0], end: times[1])
        
        for t in tasks {
            taskID.append(t.id)
            taskTitles.append(t.title)
            
            if (t.start == nil) { // Unstarted
                taskState.append(0)
            }
            else if (t.end == nil) { // Started but not finished
                taskState.append(1)
            } else { // Finished
                taskState.append(2)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskTitles.count
    }
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        
        let text = taskTitles[indexPath.row]
            
        var taskBtn = unstartedBtn
            
        if (taskState[indexPath.row] == 1) {
            taskBtn = startedBtn
        }
        if (taskState[indexPath.row] == 2) {
            taskBtn = finishedBtn
        }
            
            
        // Table cells setup
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
            
        cell.textLabel?.text = text
        cell.imageView?.image = taskBtn
        cell.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.0)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.0)
        cell.selectedBackgroundView = bgColorView
        
        return cell
    }
    
    // Action when a task is tapped
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        print("image tapped")
        let activeCell = recognizer.view as? UITableViewCell
        
        let tapLocation = recognizer.location(in: self.tableView)
        if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
            
            var activeTask = taskServices.GetTask(id: Int(truncating: taskID[tapIndexPath.row]))
            // Update state of task
            if (taskState[tapIndexPath.row] == 0) { // Start a task
                activeCell?.imageView!.image = startedBtn
                activeTask?.start = Date()
            }
            else if (taskState[tapIndexPath.row] == 1) { // Finish a task
                activeCell?.imageView!.image = finishedBtn
                activeTask?.end = Date()
            }
            
            taskServices.UpdateTask(task: activeTask!)
            taskState[tapIndexPath.row] += 1
        }
//        activeCell?.imageView!.image = UIImage(named: "StartedBtn.png")
    }
    

    // New task created
    @IBAction func sendTaskBtn(_ sender: Any) {
        AddNewTaskField.resignFirstResponder() // Dismiss keyboard
        
        let newTask = taskServices.UpdateTask(task: taskServices.NewTask(title: AddNewTaskField.text!, day: currentDate))
        
        // Dynamically add data to table
        taskID.append(newTask.id)
        taskTitles.append(AddNewTaskField.text!)
        taskState.append(0)
        
        // Refresh table to add new task
        self.tableView.reloadData()
   
        // Clear textfield
        AddNewTaskField.text = ""
    }
    
}

