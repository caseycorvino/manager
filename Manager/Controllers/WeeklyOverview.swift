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
        
        setCircles(tasks: getTasksCount())
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
            for task in taskServices.LoadTasks(start:times[0], end:times[1]) {
                if (task.end != nil) {
                    tasksCount[i] += 1
                }
            }
            
        }
        
        return tasksCount.reversed()
    }
    
    

    
}


