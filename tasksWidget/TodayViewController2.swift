//
//  TodayViewController.swift
//  tasksWidget
//
//  Created by Casey Corvino on 5/7/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController2: UIViewController, NCWidgetProviding {
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var Day1: UILabel!
    @IBOutlet weak var Day2: UILabel!
    @IBOutlet weak var Day3: UILabel!
    @IBOutlet weak var Day4: UILabel!
    @IBOutlet weak var Day5: UILabel!
    @IBOutlet weak var Day6: UILabel!
    @IBOutlet weak var Day7: UILabel!
    
    let taskServices = TaskServices();
    let utils = Utils()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        let daysArray = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        utils.setDates(today: 6, month: MonthLabel, days: daysArray as! Array<UILabel>)
        self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:210)
        if #available(iOSApplicationExtension 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }
//                let testTasks = [2,1,0,6,3,2,4]
//                setCircles(tasks: testTasks)
        setCircles(tasks: getTasksCount())
    }
    @available(iOS 10.0, *)
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: CGFloat(500))
        }else if activeDisplayMode == .compact{
            self.preferredContentSize = CGSize(width: maxSize.width, height: 110)
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
                        x: dayFrame!.origin.x + CGFloat(30),
                        y: dayFrame!.origin.y + CGFloat(j*40) + 12,
                        width: 16,
                        height: 16)
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
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
