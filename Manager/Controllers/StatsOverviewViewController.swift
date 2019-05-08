//
//  StatsOverviewViewController.swift
//  Manager
//
//  Created by Elizabeth Ha on 5/8/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class StatsOverviewViewController: UIViewController {

    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var Day1: UILabel!
    @IBOutlet weak var Day2: UILabel!
    @IBOutlet weak var Day3: UILabel!
    @IBOutlet weak var Day4: UILabel!
    @IBOutlet weak var Day5: UILabel!
    @IBOutlet weak var Day6: UILabel!
    @IBOutlet weak var Day7: UILabel!
    
    @IBOutlet weak var tasksCompleted: UILabel!
    @IBOutlet weak var tasksIncomplete: UILabel!
    @IBOutlet weak var hoursWorked: UILabel!
    @IBOutlet weak var daysWorked: UILabel!
    @IBOutlet weak var avgCompletedTasks: UILabel!
    @IBOutlet weak var avgProductivity: UILabel!
    
    
//    let taskServices = TaskServices()
    let utils = Utils()
    let tasksArr = TaskServices().LoadTasks()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let daysArray = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        utils.setDates(today: 6, month: MonthLabel, days: daysArray as! Array<UILabel>)
        
        
        tasksCompleted.text = String(getCompletedTasks())
        tasksIncomplete.text = String(getIncompletedTasks())
        hoursWorked.text = String(getTotalHoursWorked())
        daysWorked.text = String(getDaysWorked())
        avgCompletedTasks.text = String(getAvg())
        avgProductivity.text = String(getAvgProductivity())
    
        tasksCompleted.font = UIFont.boldSystemFont(ofSize: 33.0)
        tasksIncomplete.font = UIFont.boldSystemFont(ofSize: 33.0)
        hoursWorked.font = UIFont.boldSystemFont(ofSize: 33.0)
        daysWorked.font = UIFont.boldSystemFont(ofSize: 33.0)
        avgCompletedTasks.font = UIFont.boldSystemFont(ofSize: 33.0)
        avgProductivity.font = UIFont.boldSystemFont(ofSize: 33.0)
    }
    
    
//    myLabel.font = UIFont.boldSystemFont(ofSize: 12.0)

    func getCompletedTasks() -> Int {
        var total = 0
        for task in tasksArr {
            if (task.end != nil) {
                total += 1
            }
        }
        return total
    }
    func getIncompletedTasks() -> Int {
        var total = 0
        for task in tasksArr {
            if (task.end == nil) {
                total += 1
            }
        }
        return total
    }
    func getTotalHoursWorked() -> Float {
        var total = 0
        for task in tasksArr {
            total += task.timeWorkedInMinutes()
        }
        return Float(total) / 60.0
    }
    func getDaysWorked() -> Int {
        var total = 0
        
        for i in 0...6 {
            let day = utils.getDateAgo(days: i)
            let times = utils.getDateStartEnd(date: day)
            if (taskServices.LoadTasks(start: times[0], end: times[1]).count > 0) {
                total += 1
            }
        }
        
        return total
    }
    func getAvg() -> Int {
        return getCompletedTasks() / 7
    }
    
    func getAvgProductivity() -> Float {
        return Float(getCompletedTasks()) / getTotalHoursWorked()
    }
    func getDaysWorked(tasks: Array<Int>) -> Int {
        var count = 0
        for i in tasks {
            if (i > 0) {
                count += 1
            }
        }
        return count
    }

}
