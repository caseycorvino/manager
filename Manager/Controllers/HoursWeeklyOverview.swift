//
//  HoursWeeklyOverview.swift
//  Manager
//
//  Created by Elizabeth Ha on 5/4/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class HoursWeeklyOverview: UIViewController {
    
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
        
//        let testHours = [4, 0, 8, 6, 0, 5, 2]
        setBars(hours: getHours())
        // Do any additional setup after loading the view.
    }
    
    // Create hours bar
    func createHoursBar() -> UIImageView {
        let imageName = "HoursBar.png"
        let image = UIImage(named: imageName)
        let HoursBar = UIImageView(image: image!)
        HoursBar.contentMode = .scaleToFill
        return HoursBar
    }
    
    func setBars(hours: Array<Int>) {
        print("Setting hour bars...\n")
        let daysText = [Day1, Day2, Day3, Day4, Day5, Day6, Day7]
        
        for i in 0...hours.count-1 {
            
            if hours[i] > 0 {

                let dayFrame = daysText[i]?.frame
                let newBar = createHoursBar()
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
            
            hours[i] = taskServices.timeWorkedInMinutes(start: times[0], end: times[1])
        }
        return hours
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
