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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        MonthLabel.text = nameOfMonth
        
        let calendar = Calendar.current
        
        let day1 = calendar.date(byAdding: .day, value: -6, to: Date())
        let day2 = calendar.date(byAdding: .day, value: -5, to: Date())
        let day3 = calendar.date(byAdding: .day, value: -4, to: Date())
        let day4 = calendar.date(byAdding: .day, value: -3, to: Date())
        let day5 = calendar.date(byAdding: .day, value: -2, to: Date())
        let day6 = calendar.date(byAdding: .day, value: -1, to: Date())
        
        Day1.text = String(calendar.component(.day, from: day1!))
        Day2.text = String(calendar.component(.day, from: day2!))
        Day3.text = String(calendar.component(.day, from: day3!))
        Day4.text = String(calendar.component(.day, from: day4!))
        Day5.text = String(calendar.component(.day, from: day5!))
        Day6.text = String(calendar.component(.day, from: day6!))
        Day7.text = String(calendar.component(.day, from: now))
        
        Day7.textColor = UIColor(red: 254, green: 221, blue: 101, alpha: 1.0)
        // Do any additional setup after loading the view.
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
