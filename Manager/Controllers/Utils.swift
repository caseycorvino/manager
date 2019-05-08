//
//  Utils.swift
//  Manager
//
//  Created by Elizabeth Ha on 5/4/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class Utils: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getDateStartEnd(date: Date) -> Array<Date> {
        var calendar = Calendar.current
        
        calendar.timeZone = NSTimeZone.local;
        let dateAtMidnight = calendar.startOfDay(for: date)
        
        //For End Date
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        
        let dateAtEnd = calendar.date(byAdding: .day, value: 1, to: dateAtMidnight)
        
        return [dateAtMidnight, dateAtEnd!]
    }
    func getDateAgo(days: Int) -> Date {
        let calendar = Calendar.current
        
        return calendar.date(byAdding: .day, value: days * -1, to: Date())!
    }
    
    func getDateAgoString(days: Int) -> String {
        let calendar = Calendar.current
        
        let day1 = calendar.date(byAdding: .day, value: days * -1, to: Date())
        return String(calendar.component(.day, from: day1!))
    }
    
    // Sets dates for an array of dates
    // Today is the index in the array of dates that will be today
    func setDates(today: Int, month: UILabel, days: Array<UILabel>) {
        let now = Date()
        let dateFormatter = DateFormatter()
//        let calendar = Calendar.current
        
        dateFormatter.dateFormat = "LLLL"
        month.text = dateFormatter.string(from: now)
        
        for i in 0...6 {
            days[i].text = getDateAgoString(days:(today - i))
            days[i].textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        }
        month.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        days[today].textColor = UIColor(red:0.07, green:0.07, blue:0.07, alpha:1.0)
        
    }
    
    func createImage(Name: String) -> UIImageView {
        let imageName = Name
        let image = UIImage(named: imageName)
        let imageObj = UIImageView(image: image!)
        
        return imageObj
    }

}
