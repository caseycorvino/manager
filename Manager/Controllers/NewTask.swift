//
//  NewTask.swift
//  Manager
//
//  Created by Alex Li on 5/5/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

protocol myDelegate {
    func doSomething()
}

class NewTask: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var delegate:UIPopoverPresentationControllerDelegate?
    
    @IBOutlet weak var taskName: UITextField!
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }
//    @IBAction func closePopUp0(_ sender: Any) {
//        if(taskName.text != ""){
//            taskServices.NewTask(title: taskName.text as! String, estimation: String(1), day: Date())
//            performSegue(withIdentifier: "unwindSegue", sender: self)
//        }
//    }
//
//    @IBAction func closePopUp1(_ sender: Any) {
//        if(taskName.text != ""){
//            taskServices.NewTask(title: taskName.text as! String, estimation: String(3), day: Date())
//            performSegue(withIdentifier: "unwindSegue", sender: self)
//        }
//    }
//
//    @IBAction func closePopUp2(_ sender: Any) {
//        if(taskName.text != nil){
//            taskServices.NewTask(title: taskName.text as! String, estimation: String(4), day: Date())
//            performSegue(withIdentifier: "unwindSegue", sender: self)
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//        if segue.destination is StartDay
//         {
////         let vc = segue.destination as? StartDay
////         vc?.refresh()
//         }
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
