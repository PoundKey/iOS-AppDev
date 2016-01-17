//
//  MainViewController.swift
//  TSLink Mobile
//
//  Created by Chang Tong Xue on 2016-01-15.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit
import Alamofire


class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var routes = [Route]()
    //var routeCell: UITableViewCell = RouteCell(style: .Default, reuseIdentifier: "cell")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.registerClass(routeCell.classForCoder, forCellReuseIdentifier: "cell")
        tableView.registerNib(UINib(nibName: "RouteCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
        
        /**
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
*/
    }

    
    func fetchRouteArray() -> [Int] {
        
        return [0]
    }
    
    func populateRoutes() {
        
    }


}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RouteCell
        print(cell)
        cell.stopNumber.text = "DEE"
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
}

