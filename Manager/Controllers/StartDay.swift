//
//  StartDay.swift
//  Manager
//
//  Created by Alex Li on 5/5/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class StartDay: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var task1: UILabel!
    @IBOutlet weak var task2: UILabel!
    @IBOutlet weak var task3: UILabel!
    @IBOutlet weak var task4: UILabel!
    @IBOutlet weak var task5: UILabel!
    @IBOutlet weak var task6: UILabel!
    
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var Day1: UILabel!
    @IBOutlet weak var Day2: UILabel!
    @IBOutlet weak var Day3: UILabel!
    @IBOutlet weak var Day4: UILabel!
    @IBOutlet weak var Day5: UILabel!
    @IBOutlet weak var Day6: UILabel!
    @IBOutlet weak var Day7: UILabel!

    let taskServices = TaskServices()
    let utils = Utils()
    
    var startTime = NSDate()
    var endTime = NSDate()
    var started = false
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let daysArray = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        utils.setDates(today: 3, month: MonthLabel, days: daysArray as! Array<UILabel>)
        
//        refresh()
        // Do any additional setup after loading the view.
    }
    func refresh() {
        
        let tasks = taskServices.LoadTasks()
        if(tasks.count > 0){
            task1.text = tasks[i].title
            if(tasks.count > 1){
                task2.text = tasks[i+1].title
                if(tasks.count > 2){
                    task3.text = tasks[i+2].title
                    if(tasks.count > 3){
                        task4.text = tasks[i+3].title
                        if(tasks.count > 4){
                            task5.text = tasks[i+4].title
                            if(tasks.count > 5){
                                task6.text = tasks[i+5].title
                            }
                        }
                    }
                }
            }
        }
        let maxSize = CGSize(width: 150, height: 100)
        task1.frame = CGRect(origin: CGPoint(x: 205-task1.sizeThatFits(maxSize).width/2, y: 225), size: task1.sizeThatFits(maxSize))
        task2.frame = CGRect(origin: CGPoint(x: 205-task2.sizeThatFits(maxSize).width/2, y: 255), size: task2.sizeThatFits(maxSize))
        task3.frame = CGRect(origin: CGPoint(x: 205-task3.sizeThatFits(maxSize).width/2, y: 285), size: task3.sizeThatFits(maxSize))
        task4.frame = CGRect(origin: CGPoint(x: 205-task4.sizeThatFits(maxSize).width/2, y: 315), size: task4.sizeThatFits(maxSize))
        task5.frame = CGRect(origin: CGPoint(x: 205-task5.sizeThatFits(maxSize).width/2, y: 345), size: task5.sizeThatFits(maxSize))
        task6.frame = CGRect(origin: CGPoint(x: 205-task6.sizeThatFits(maxSize).width/2, y: 375), size: task6.sizeThatFits(maxSize))
    }

    @IBAction func dayStartStop(_ sender: Any) {
        if(!started){
            startTime = NSDate()
            startStopButton.setTitle("END MY DAY", for: .normal)
            started = true
        }else{
            endTime = NSDate()
            startStopButton.setTitle("START MY DAY", for: .normal)
            started = false
            for t in taskServices.LoadTasks(start: NSDate() as Date, end: NSDate().addingTimeInterval(86400) as Date){
                t.start = startTime as Date
                t.end = endTime as Date
            }
        }
    }
    
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

