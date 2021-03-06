//
//  ProfileViewController.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-08.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var tableView: UITableView!
    
    var tableCell: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        
        scrollView = UIScrollView(frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        scrollView.contentSize.height = CGFloat(self.view.frame.size.height + 100)
        scrollView.contentSize.width = CGFloat(self.view.frame.size.width)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator   = false
        self.view.addSubview(scrollView)
        
        let headerView = (NSBundle.mainBundle().loadNibNamed("ProfileHeaderView", owner: nil, options: nil)[0] as? ProfileHeaderView)!
        headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150)
        headerView.backgroundColor = UIColor(red: 55.0/255.0, green: 168.0/255.0, blue: 122.0/255.0, alpha: 1.0)
        scrollView.addSubview(headerView)
        
        tableView = UITableView(frame: CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height - 120))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.scrollEnabled = false
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.registerClass(tableCell.classForCoder, forCellReuseIdentifier: "cell")
        scrollView.addSubview(tableView)
        
        // Add empty padding to the tableView
        let footerView = UIView(frame: CGRectZero)
        tableView.tableFooterView = footerView
        
        setNavBarItems()
    }
    
    override func viewWillAppear(animated: Bool) {
        // Fix the one line gap between navigationBar and the scrollView
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.hideBottomHairline()
    }

    
    func setNavBarItems(){
        
        let leftItem = UIBarButtonItem(title:"Info",style:.Plain,target:self,action:"updateInfo");
        leftItem.tintColor = UIColor.whiteColor();
        self.navigationItem.leftBarButtonItem = leftItem;
        
        let rightItem = UIBarButtonItem(title:"Update",style:.Plain,target:self,action:"updateProfile");
        rightItem.tintColor = UIColor.whiteColor();
        self.navigationItem.rightBarButtonItem = rightItem;
        
    }
    
    func updateInfo() {
        
    }
    
    func updateProfile() {
        
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = "Profile View Cell:  \(Int(indexPath.row))"
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 30
        default:
            return 15
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    
}
