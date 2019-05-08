//
//  StartDay.swift
//  Manager
//
//  Created by Alex Li on 5/5/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class StartDay: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate
 {
    var dateModelPicker: DateModelPicker!
    @IBOutlet weak var DayPicker: UIPickerView!
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var DayLabel: UILabel!
    
    @IBOutlet weak var AddNewTaskField: UITextField!
    @IBOutlet weak var textSendBtn: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!

    let taskServices = TaskServices()
    let utils = Utils()
    var currentDate = Date()
    
    let unstartedBtn = UIImage(named: "NotStartedBtn.png")
    let startedBtn = UIImage(named: "StartedBtn.png")
    let finishedBtn = UIImage(named: "FinishedBtn.png")
    
    private var taskID: [NSNumber] = []
    private var taskTitles: [String] = []
    private var taskState: [Int] = [] // Unstarted: 0, Started: 1, Finished: 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        dateModelPicker = DateModelPicker()
        
        // Set footer calendar
       
        DayPicker.transform = CGAffineTransform(rotationAngle: -.pi/2 as CGFloat)
        DayPicker.frame = CGRect(x: -100, y: 812, width: view.frame.width + 200, height: 48)
        DayPicker.delegate = self
        DayPicker.dataSource = dateModelPicker
        
        let df = DateFormatter()
        df.dateFormat = "dd"
        let firstD = Date()
        let cal = Calendar.current
        let day = cal.ordinality(of: .day, in: .year, for: firstD)
        
        DayPicker.selectRow(day!, inComponent: 0, animated: true)
        
        // Table setup
        populateTable(date: currentDate)
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.0)
        
        // Add new task field setup
        self.AddNewTaskField.delegate = self
        
        //Month Label Setup
        df.dateFormat = "MMMM"
        MonthLabel.text = df.string(for: currentDate)
        
        //Day Label Setup
        df.dateFormat = "MM/dd/YYYY"
        DayLabel.text = df.string(for: currentDate)
        
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        view.transform = CGAffineTransform(rotationAngle: (90 * (.pi / 180)))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 20))
        let df = DateFormatter()
        df.dateFormat = "dd"
        let firstD = Date()
        let cal = Calendar.current
        let day = cal.ordinality(of: .day, in: .year, for: firstD)
        label.text = df.string(for: Date()+TimeInterval(row * 86400)-TimeInterval(86400*day!))
        label.textAlignment = .center
        view.addSubview(label)
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var dateComponents = DateComponents()
        dateComponents.day = row
        dateComponents.year = 2019
        
        let cal = NSCalendar.current
        currentDate = cal.date(from: dateComponents)!
        
        populateTable(date: currentDate)
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:0.0)
        
        let df = DateFormatter()
        df.dateFormat = "MMMM"
        MonthLabel.text = df.string(for: currentDate)
        
        df.dateFormat = "MM/dd/YYYY"
        DayLabel.text = df.string(for: currentDate)
    }
    
}

