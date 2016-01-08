//
//  NoteViewController.swift
//  CarbonKit Demo
//
//  Created by Chang Tong Xue on 2016-01-08.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class NoteViewController: UITableViewController {
    
    var refresh: CarbonSwipeRefresh = CarbonSwipeRefresh()
    
    override func viewDidLoad() {
        print(self.view.superview)
        refresh = CarbonSwipeRefresh(scrollView: self.tableView)
        
        refresh.setMarginTop(0)
        refresh.colors = [UIColor.blueColor(), UIColor.redColor(), UIColor.orangeColor(), UIColor.greenColor()]
        self.view.addSubview(refresh)
        refresh.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        print("NoteViewController Loaded")
    }
    
    func refresh(sender: AnyObject) {
        NSLog("REFRESH")
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.endRefreshing()
        }
    }
    
    func endRefreshing() {
        refresh.endRefreshing()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("noteCell", forIndexPath: indexPath)
        cell.textLabel!.text = "Cell \(Int(indexPath.row))"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
}
