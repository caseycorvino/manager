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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDates()
        

    }
    
    func createTask() -> UIImageView {
        let imageName = "TaskCirclex4.png"
        let image = UIImage(named: imageName)
        let TaskCircle = UIImageView(image: image!)
        
        return TaskCircle
    }
    
    func setTasks() {
        let tasks = getTasksCount()
        
        for tasks in tasks {
            
        }
    }
    
    func getDateAgo(days: Int) -> String {
        let calendar = Calendar.current
        
        let day1 = calendar.date(byAdding: .day, value: days * -1, to: Date())
        return String(calendar.component(.day, from: day1!))
    }
    func setDates() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        MonthLabel.text = nameOfMonth
        
        let calendar = Calendar.current
        
        Day1.text = getDateAgo(days:6)
        Day2.text = getDateAgo(days:5)
        Day3.text = getDateAgo(days:4)
        Day4.text = getDateAgo(days:3)
        Day5.text = getDateAgo(days:2)
        Day6.text = getDateAgo(days:1)
        Day7.text = String(calendar.component(.day, from: now))
        
        Day7.textColor = UIColor(red: 254, green: 221, blue: 101, alpha: 1.0)
    }
    func getTasksCount() -> Array<Int> {
        var tasksCount:[Int] = [0,0,0,0,0,0,0];
        
        // query tasks and count how many tasks per day
        
        return tasksCount
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


