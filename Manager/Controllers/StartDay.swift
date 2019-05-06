//
//  StartDay.swift
//  Manager
//
//  Created by Alex Li on 5/5/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class StartDay: UIViewController {

    var startTime = NSDate()
    var endTime = NSDate()
    var started = false
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
        // Do any additional setup after loading the view.
    }
    func refresh(){
        let currentDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        D0.text = dateFormatter.string(from: currentDate as Date)
        var calculatedDate = currentDate.addingTimeInterval(86400)
        D1.text = dateFormatter.string(from: calculatedDate as Date)
        calculatedDate = calculatedDate.addingTimeInterval(86400)
        D2.text = dateFormatter.string(from: calculatedDate as Date)
        calculatedDate = calculatedDate.addingTimeInterval(86400)
        D3.text = dateFormatter.string(from: calculatedDate as Date)
        calculatedDate = currentDate.addingTimeInterval(-86400)
        Dm1.text = dateFormatter.string(from: calculatedDate as Date)
        calculatedDate = calculatedDate.addingTimeInterval(-86400)
        Dm2.text = dateFormatter.string(from: calculatedDate as Date)
        calculatedDate = calculatedDate.addingTimeInterval(-86400)
        Dm3.text = dateFormatter.string(from: calculatedDate as Date)
        calculatedDate = calculatedDate.addingTimeInterval(-86400)
        dateFormatter.dateFormat = "MMMM"
        Month.text = dateFormatter.string(from: currentDate as Date)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        Date.text = dateFormatter.string(from: currentDate as Date)
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
        task1.frame = CGRect(origin: CGPoint(x: 205, y: 225), size: task1.sizeThatFits(maxSize))
        task2.frame = CGRect(origin: CGPoint(x: 205, y: 255), size: task2.sizeThatFits(maxSize))
        task3.frame = CGRect(origin: CGPoint(x: 205, y: 285), size: task3.sizeThatFits(maxSize))
        task4.frame = CGRect(origin: CGPoint(x: 205, y: 315), size: task4.sizeThatFits(maxSize))
        task5.frame = CGRect(origin: CGPoint(x: 205, y: 345), size: task5.sizeThatFits(maxSize))
        task6.frame = CGRect(origin: CGPoint(x: 205, y: 375), size: task6.sizeThatFits(maxSize))
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
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var task1: UILabel!
    @IBOutlet weak var task2: UILabel!
    @IBOutlet weak var task3: UILabel!
    @IBOutlet weak var task4: UILabel!
    @IBOutlet weak var task5: UILabel!
    @IBOutlet weak var task6: UILabel!
    
    
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Month: UILabel!
    @IBOutlet weak var Dm3: UILabel!
    @IBOutlet weak var Dm2: UILabel!
    @IBOutlet weak var Dm1: UILabel!
    @IBOutlet weak var D0: UILabel!
    @IBOutlet weak var D1: UILabel!
    @IBOutlet weak var D2: UILabel!
    @IBOutlet weak var D3: UILabel!
    
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

