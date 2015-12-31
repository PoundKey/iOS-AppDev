//
//  LogViewController.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-19.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class LogViewController: UITableViewController {

    @IBOutlet weak var segmentedBar: UISegmentedControl!
    
    var footprints = try! Realm().objects(FootPrint).sorted("name", ascending: true)
    var searchResults = try! Realm().objects(FootPrint)
    
    var searchController: UISearchController!
    
    
    func filterResultsWithSearchString(searchString: String) {
        let predicate = NSPredicate(format: "name CONTAINS[c] %@", searchString)
        let scopeIndex = searchController.searchBar.selectedScopeButtonIndex
        let realm = try! Realm()
        switch scopeIndex {
        case 0:
            searchResults = realm.objects(FootPrint).filter(predicate).sorted("name", ascending: true)
        case 1:
            searchResults = realm.objects(FootPrint).filter(predicate).sorted("created", ascending: true)
        default:
            searchResults = realm.objects(FootPrint).filter(predicate)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchResultsController = UITableViewController(style: .Plain)
        //print("searchResultsController loaded: \(unsafeAddressOf(searchResultsController.tableView))")
        searchResultsController.tableView.delegate = self
        searchResultsController.tableView.dataSource = self
        searchResultsController.tableView.rowHeight = 63
        searchResultsController.tableView.registerClass(FootPrintCell.self, forCellReuseIdentifier: "cell")
        
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.loadViewIfNeeded()
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor(red: 0, green: 0.36, blue: 0.66, alpha: 1.0)
        tableView.tableHeaderView?.addSubview(searchController.searchBar)
        
        //searchController.definesPresentationContext = true
        definesPresentationContext = true

    }
    

    
    
    @IBAction func scopeChanged(sender: AnyObject) {
        searchController.searchBar.selectedScopeButtonIndex = sender.selectedSegmentIndex
        
        let scopeBar = sender as! UISegmentedControl
        let realm = try! Realm()
        switch scopeBar.selectedSegmentIndex {
        case 0:
            footprints = realm.objects(FootPrint).sorted("name", ascending: true)
            break
        case 1:
            footprints = realm.objects(FootPrint).sorted("created", ascending: true)
        default:
            footprints = realm.objects(FootPrint).sorted("name", ascending: true)
        }
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //print("tableView loaded: \(unsafeAddressOf(tableView))")
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.active ? searchResults.count : footprints.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! FootPrintCell
        let footprint = searchController.active ? searchResults[indexPath.row] : footprints[indexPath.row]
        cell.titleLabel.text = footprint.name
        cell.subtitleLabel.text = footprint.category.name
        
        let imageName = getIconImage(footprint.category.name)
        cell.iconImageView.image = UIImage(named: imageName)
        
        cell.distanceLabel.text = ""
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let footprint = searchController.active ? searchResults[indexPath.row] : footprints[indexPath.row]

        if searchController.active {
            searchController.dismissViewControllerAnimated(false, completion: {
                self.performSegueWithIdentifier("pinLocation", sender: footprint)
            })
        } else {
            self.performSegueWithIdentifier("pinLocation", sender: footprint)
        }

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! MainViewController
        let footprint  = sender as! FootPrint
        controller.selectedFootPrint = footprint
    }

}

// MARK: - UISearchResultsUpdating
extension LogViewController: UISearchResultsUpdating {
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text!
        filterResultsWithSearchString(searchString)
        
        let searchResultsController = searchController.searchResultsController as! UITableViewController
        searchResultsController.tableView.reloadData()
    }
    
}

// MARK: - UISearchBarDelegate
extension LogViewController:  UISearchBarDelegate {
    
}

