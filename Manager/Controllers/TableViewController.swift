//
//  TableViewController.swift
//  Manager
//
//  Created by Elizabeth Ha on 5/7/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //this method will populate the table view
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableRow = tableView.dequeueReusableCellWithIdentifier("TableRow") as UITableViewCell!
        
        //adding the item to table row
//        tableRow.textLabel?.text = tableItems[indexPath.row]
        
        return tableRow!
    }
    
    
    //this method will return the total rows count in the table view
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }

}
