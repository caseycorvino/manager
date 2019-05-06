//
//  WeeklyOverview.swift
//  Manager
//
//  Created by Elizabeth Ha on 5/4/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class WeeklyOverview: UIViewController {

    
    @IBOutlet weak var MonthLabel: UITextField!
    @IBOutlet weak var Day1: UILabel!
    @IBOutlet weak var Day2: UILabel!
    @IBOutlet weak var Day3: UILabel!
    @IBOutlet weak var Day4: UILabel!
    @IBOutlet weak var Day5: UILabel!
    @IBOutlet weak var Day6: UILabel!
    @IBOutlet weak var Day7: UILabel!
    @IBOutlet weak var WeeklyReportBtn: UIButton!
    
    let taskServices = TaskServices()
    let utils = Utils()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDates()
        
//        let testTasks = [2,1,0,6,3,2,4]
//        setCircles(tasks: testTasks)
        setCircles(tasks: getTasksCount())
    }
    
    
    @IBAction func viewWeeklyReport(_ sender: Any) {
        print("Hello")
        
        let overlay = utils.createImage(Name: "GrayOverlay.png")
        
        overlay.frame = CGRect(x: 0, y: 200, width: 500, height: 400)
        view.addSubview(overlay)
        
    }
    // Set correct number of task circles per day
    func setCircles(tasks: Array<Int>) {
        let daysText = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        
        for i in 0...tasks.count-1 {
            if tasks[i] > 0 {
                for j in 1...tasks[i] {
                    let dayFrame = daysText[i]?.frame
                    let newCircle = utils.createImage(Name: "TaskCirclex4.png")
                    newCircle.frame = CGRect(
                        x: dayFrame!.origin.x + CGFloat(10),
                        y: dayFrame!.origin.y + CGFloat(j*40) + 20,
                        width: 20,
                        height: 20)
                    view.addSubview(newCircle)
                }
            }
        }
    }
    
    // Return array of task counts for the past week, in reverse days order
    func getTasksCount() -> Array<Int> {
        var tasksCount = [0,0,0,0,0,0,0];
        
        for i in (0...6) {
            var times = utils.getDateStartEnd(date: utils.getDateAgo(days: i))
            tasksCount[i] = (taskServices.LoadTasks(start:times[0], end:times[1])).count
            
        }
        
        return tasksCount.reversed()
    }
    
    func getTotalTasks(tasks: Array<Int>) -> Int {
        var total = 0
        for i in tasks {
            total += i
        }
        return total
    }
    func getHighestTasks(tasks: Array<Int>) -> Int {
        var highest  = tasks[0]
        for i in 0...6 {
            if (tasks[i] > highest) {
                highest = tasks[i]
            }
        }
        return highest
    }
    func getAvg(total: Int) -> Int {
        return total / 7
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
    
    func setDates() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        MonthLabel.text = nameOfMonth
        
        let calendar = Calendar.current
        
        Day1.text = utils.getDateAgoString(days:6)
        Day2.text = utils.getDateAgoString(days:5)
        Day3.text = utils.getDateAgoString(days:4)
        Day4.text = utils.getDateAgoString(days:3)
        Day5.text = utils.getDateAgoString(days:2)
        Day6.text = utils.getDateAgoString(days:1)
        Day7.text = String(calendar.component(.day, from: now))
        
        Day7.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    }
    

    
}


