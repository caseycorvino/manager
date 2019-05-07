//
//  WeeklyOverview.swift
//  Manager
//
//  Created by Elizabeth Ha on 5/4/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class WeeklyOverview: UIViewController {

    
    @IBOutlet weak var MonthLabel: UILabel!
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
    
    var reportActive = false
    var textFieldViews: [UILabel] = []
    var overlay = UIImageView(image: UIImage(named: "GrayOverlay.png"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let daysArray = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        utils.setDates(today: 6, month: MonthLabel, days: daysArray as! Array<UILabel>)
        
//        let testTasks = [2,1,0,6,3,2,4]
//        setCircles(tasks: testTasks)
        setCircles(tasks: getTasksCount())
    }
    
    
    @IBAction func viewWeeklyReport(_ sender: Any) {

        if (reportActive == false) {
            overlay.frame = CGRect(x: 0, y: 200, width: 500, height: 400)
            overlay.alpha = 1
        
            
            
            
            view.addSubview(overlay)

            let reportLabels = ["Total tasks completed this week: ",
                                "Greatest number of tasks in one day: ",
                                "Average number of tasks completed: ",
                                "Number of days worked this week: "]
//            let reportData = [10, 4, 9, 4]
            let reportData = [getTotalTasks(tasks: getTasksCount()),
                getHighestTasks(tasks: getTasksCount()),
                getAvg(total: getTotalTasks(tasks: getTasksCount())),
                getDaysWorked(tasks: getTasksCount())
            ]
            
            for i in 0...3 {
                let textField =  UILabel(frame: CGRect(x: 20, y: 220 + i*35, width: 400, height: 40))
                textField.text = reportLabels[i] + String(reportData[i])
                textField.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
                
                textFieldViews.append(textField)
                view.addSubview(textField)
            }
            WeeklyReportBtn.setTitle("Close Report", for: .normal)
            reportActive = true
        } else {
            print("hide overlay")
            
            for t in textFieldViews {
                t.removeFromSuperview()
            }
            overlay.alpha = 0
            WeeklyReportBtn.setTitle("Open Report", for: .normal)
            reportActive = false
        }
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

    
}


