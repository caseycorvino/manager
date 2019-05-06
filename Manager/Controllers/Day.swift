//
//  Day.swift
//  Manager
//
//  Created by Alex Li on 5/5/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class Day: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        dateFormatter.dateFormat = "h:mm a"
        Time.text = dateFormatter.string(from: timeStarted as Date)
        // Do any additional setup after loading the view.
    }
    @IBAction func showPopUp(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newTaskID") as! NewTask
        
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    @IBAction func endDay(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var timeStarted: NSDate!
    @IBOutlet weak var Month: UILabel!
    @IBOutlet weak var Dm3: UILabel!
    @IBOutlet weak var Dm2: UILabel!
    @IBOutlet weak var Dm1: UILabel!
    @IBOutlet weak var D0: UILabel!
    @IBOutlet weak var D1: UILabel!
    @IBOutlet weak var D2: UILabel!
    @IBOutlet weak var D3: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Time: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
