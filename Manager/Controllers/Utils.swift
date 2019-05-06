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
        
        calendar.timeZone = TimeZone(abbreviation: "UTC")! //OR NSTimeZone.localTimeZone()
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
    
    func createImage(Name: String) -> UIImageView {
        let imageName = Name
        let image = UIImage(named: imageName)
        let imageObj = UIImageView(image: image!)
        
        return imageObj
    }

}
