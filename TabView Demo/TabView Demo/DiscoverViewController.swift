//
//  DiscoverViewController.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-08.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    var tableView: UITableView!
    let imageSet = ["icon_tab_event","icon_tab_qa","icon_tab_tag","icon_tab_rank"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Discover"
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        tableView.dataSource = self
        tableView.delegate   = self
        self.view.addSubview(tableView)
        
        tableView.registerNib(UINib(nibName: "DiscoverTableCell", bundle:nil), forCellReuseIdentifier: "dscell")
        let footView = UIView(frame: CGRectZero)
        tableView.tableFooterView = footView
    }
}

extension DiscoverViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dscell", forIndexPath: indexPath) as! DiscoverTableCell
        let options: [String: String]
        switch indexPath.section {
        case 0:
            options = ["Img": imageSet[indexPath.row], "Title": "Section \(indexPath.section)", "Contents": "Row Content: \(indexPath.row)"]
        case 1:
            options = ["Img": imageSet[indexPath.row + 1], "Title": "Section \(indexPath.section)", "Contents": "Row Content: \(indexPath.row)"]
        default:
            options = [String:String]()
        }
        cell.setDiscoverTableCell(options)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 150
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //let footer =  NSBundle.mainBundle().loadNibNamed("DiscoverSectionView", owner: nil, options: nil)[0] as? DiscoverSectionView
        if section == 0 {
            let image = UIImage(named: "Img1")
            let footer = UIImageView(image: image)
            return footer
        }
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 25
        default:
            return 0
        }
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
