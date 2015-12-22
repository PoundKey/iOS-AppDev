//
//  LogViewController.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-19.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit
import MapKit

class LogViewController: UITableViewController {

    @IBOutlet weak var segmentedBar: UISegmentedControl!
    
    var footprints = []
    var searchResults = []
    
    var searchController: UISearchController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let searchResultsController = UITableViewController(style: .Plain)
        searchResultsController.tableView.delegate = self
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.rowHeight = 63
        searchResultsController.tableView.registerClass(FootPrintCell.self, forCellReuseIdentifier: "LogCell")
        
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor(red: 0, green: 0.36, blue: 0.66, alpha: 1.0)
        tableView.tableHeaderView?.addSubview(searchController.searchBar)
        
        definesPresentationContext = true

    }
    

    
    
    @IBAction func scopeChanged(sender: AnyObject) {
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.active ? searchResults.count : footprints.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("LogCell") as! FootPrintCell
        
        return cell
    }
    

}

// MARK: - UISearchResultsUpdating
extension LogViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchResultsController = searchController.searchResultsController as! UITableViewController
        searchResultsController.tableView.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate
extension LogViewController:  UISearchBarDelegate {
    
}

