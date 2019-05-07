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
    
    
    
    private var taskTitles: [String] = []
    private var taskState: [String] = []
    
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
    
    func populateTable(date: Date) {
        let times = utils.getDateStartEnd(date: date)
        
        let tasks = taskServices.LoadTasks(start: times[0], end: times[1])
        
        for t in tasks {
            taskTitles.append(t.title)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! //1.
        
        let text = taskTitles[indexPath.row] //2.
        let taskBtn = UIImage(named: "NotStartedBtn.png")
    
        cell.isUserInteractionEnabled = true
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
            
        cell.textLabel?.text = text //3.
        
        cell.imageView?.image = taskBtn
        cell.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.0)
            
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.0)
//        cell.selectedBackgroundView = bgColorView
        
            
        
        return cell //4.
    }
    
    // Action when a task is tapped
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        print("image tapped")
        let activeCell = recognizer.view as? UITableViewCell
        
        activeCell?.imageView!.image = UIImage(named: "StartedBtn.png")
    }
    

    @IBAction func sendTaskBtn(_ sender: Any) {
        AddNewTaskField.resignFirstResponder() // Dismiss keyboard
        
        taskServices.UpdateTask(task: taskServices.NewTask(title: AddNewTaskField.text!, day: currentDate))
        
        // Dynamically add data to table
        taskTitles.append(AddNewTaskField.text!)
        self.tableView.reloadData()
   
        AddNewTaskField.text = ""
    }
    
//    func tableView(tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tapped!!!!")
//    }
//
//    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
//        let translation = recognizer.translation(in: self.view)
//        if let view = recognizer.view {
//            view.center = CGPoint(x:view.center.x + translation.x,
//                                  y:view.center.y + translation.y)
//        }
//        recognizer.setTranslation(CGPoint.zero, in: self.view)
//    }
    
    
//    self.tableView.addGestureRecognizer(tap)
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("??")
    }
}

