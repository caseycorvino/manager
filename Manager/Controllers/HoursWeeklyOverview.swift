//
//  HoursWeeklyOverview.swift
//  Manager
//
//  Created by Elizabeth Ha on 5/4/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class HoursWeeklyOverview: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        let daysArray = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        utils.setDates(today: 6, month: MonthLabel, days: daysArray as! Array<UILabel>)
        
//        let testHours = [4, 0, 8, 6, 0, 5, 2]
        setBars(hours: getHours())
        // Do any additional setup after loading the view.
    }
    
    func setBars(hours: Array<Int>) {
        let daysText = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        
        for i in 0...hours.count-1 {
            
            if hours[i] > 0 {

                let dayFrame = daysText[i]?.frame
                let newBar = utils.createImage(Name: "HoursBar.png")

                newBar.frame = CGRect(
                    x: CGFloat(dayFrame!.origin.x + 12),
                    y: CGFloat(dayFrame!.origin.y + 50),
                    width: CGFloat(16),
                    height: CGFloat(Float(hours[i]) / 12.0 * 700)
                )
                
                view.addSubview(newBar)
                
                print(Float(hours[i] / 12))
                print(newBar.frame)
                
            }
        }
    }
    
    func getHours() -> Array<Int> {
        var hours = [0,0,0,0,0,0,0]
        
        for i in 0...6 {
            var times = utils.getDateStartEnd(date: utils.getDateAgo(days: i))
            let tasks = taskServices.LoadTasks(start: times[0], end: times[1])
            if (tasks.count > 0) {
                hours[i] = taskServices.LoadTasks(start: times[0], end: times[1])[0].timeWorkedInMinutes()
            }
        }
        
        return hours.reversed()
    }
    
}
