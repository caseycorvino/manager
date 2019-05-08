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
        setBars(hours: getHoursPerDay())
        // Do any additional setup after loading the view.
    }
    
    func setBars(hours: Array<Int>) {
        let daysText = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        
        for i in 0...hours.count-1 {
            
            if hours[i] > 0 {

                let dayFrame = daysText[i]?.frame
                let newBar = utils.createImage(Name: "HoursBar.png")
                let hoursLabel = UILabel()

                newBar.frame = CGRect(
                    x: CGFloat(dayFrame!.origin.x + 12),
                    y: CGFloat(dayFrame!.origin.y + 50),
                    width: CGFloat(16),
                    height: CGFloat(Float(hours[i]) / 12.0 * 16)
                )
                hoursLabel.frame = CGRect(
                    x: dayFrame!.origin.x + 8,
                    y: dayFrame!.origin.y + 48 + CGFloat(Float(hours[i]) / 12.0 * 16),
                    width: 40,
                    height: 40)
                hoursLabel.text = String(Float(hours[i])/60.0)
                hoursLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
                
                view.addSubview(newBar)
                view.addSubview(hoursLabel)
                
                print(Float(hours[i] / 12))
                print(newBar.frame)
                
            }
        }
    }
    
    func getHoursPerDay() -> Array<Int> {
        var hours = [0,0,0,0,0,0,0]
        
        for i in 0...6 {
            var date = utils.getDateStartEnd(date: utils.getDateAgo(days: i))
            let workTime = taskServices.timeWorkedInMinutes(start: date[0], end: date[1])
            
            hours[i] += workTime
        }
        
        return hours.reversed()
    }
    
}
