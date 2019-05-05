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
    
    let taskServices = TaskServices()
    let utils = Utils()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDates()
        
        let testTasks = [2,1,0,6,3,2,4]
        setTasks(tasks: testTasks)
    }
    
    // Create circle icon per task
    func createTaskCircle() -> UIImageView {
        let imageName = "TaskCirclex4.png"
        let image = UIImage(named: imageName)
        let TaskCircle = UIImageView(image: image!)
        
        return TaskCircle
    }
    
    // Set correct number of task circles per day
    func setTasks(tasks: Array<Int>) {
//        let tasks = getTasksCount()
        let daysText = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        
        for i in 0...tasks.count-1 {
            if tasks[i] > 0 {
                for j in 1...tasks[i] {
                    print("Creating new task circle")
                    let dayFrame = daysText[i]?.frame
                    let newCircle = createTaskCircle()
                    newCircle.frame = CGRect(
                        x: dayFrame!.origin.x + CGFloat(10),
                        y: dayFrame!.origin.y + CGFloat(j*40) + 20,
                        width: 20,
                        height: 20)
                    view.addSubview(newCircle)
                    print(newCircle.frame)
                }
            }
        }
    }
    
    // Return array of task counts for the past week, in reverse days order
    func getTasksCount() -> Array<Int> {
        var tasksCount:[Int] = [0,0,0,0,0,0,0];
        
        for i in 0...6 {
            var times = utils.getDateStartEnd(date: utils.getDateAgo(days: i))
            tasksCount[i] = (taskServices.LoadTasks(start:times[0], end:times[1])).count
        }
        
        return tasksCount
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


