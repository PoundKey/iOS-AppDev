//
//  MainViewController.swift
//  UISearch Demo
//
//  Created by Chang Tong Xue on 2015-12-31.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredTeams = [Team]()
    
    let west = UIImage(named: "western")
    let east = UIImage(named: "eastern")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NBA"
        setSearchController()
    }
    
    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.barTintColor = UIColor(red: 0, green: 0.36, blue: 0.66, alpha: 1.0)
        
        // Add scope to the searchController
        searchController.searchBar.scopeButtonTitles = ["League", "West", "East"]
        searchController.searchBar.delegate = self
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "League") {
        filteredTeams = defaultTeams.filter { team in
            let teamMatch = (scope == "League") || (team.division == scope)
            if searchController.searchBar.text == "" {
                return teamMatch
            } else {
                return teamMatch && team.name.lowercaseString.containsString(searchText.lowercaseString)
            }
        }
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! DetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if searchController.active  {
                controller.selectedTeam = filteredTeams[indexPath.row]
            } else {
                controller.selectedTeam = defaultTeams[indexPath.row]
            }
        }
    }

}

extension MainViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return filteredTeams.count
        } else {
            return defaultTeams.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let team: Team
        if searchController.active {
            team = filteredTeams[indexPath.row]
        } else {
            team = defaultTeams[indexPath.row]
        }
        cell.textLabel?.text = team.name
        cell.imageView?.image = (team.division == "West" ? west : east)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
