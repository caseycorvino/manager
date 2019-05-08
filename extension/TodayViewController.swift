//
//  TodayViewController.swift
//  extension
//
//  Created by Casey Corvino on 5/6/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NCWidgetProviding {
    let taskServices = TaskServices();

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var doingLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    
    var tasks:[Task] = [];
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:210)
        if #available(iOSApplicationExtension 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone.local;
        let startDay = calendar.startOfDay(for: Date());
        var todoCount:Int = 0, startedCount:Int = 0, finishedCount:Int = 0;
        tasks = taskServices.LoadTasks(start: startDay, end: Date(timeInterval: 86400, since: startDay));
        for task in tasks {
            if task.start == nil && task.end == nil{
                todoCount += 1;
            } else if task.start != nil && task.end == nil{
                startedCount += 1
            } else if task.start != nil && task.end != nil{
                finishedCount += 1;
            }
        }
        todoLabel.text = String(todoCount);
        doingLabel.text = String(startedCount);
        doneLabel.text = String(finishedCount);
    }
    
    @available(iOS 10.0, *)
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: CGFloat(tasks.count) * 44 + 110)
        }else if activeDisplayMode == .compact{
            self.preferredContentSize = CGSize(width: maxSize.width, height: 110)
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
     
        cell.textLabel?.text = tasks[indexPath.row].title;
        return cell
     }
    
}
