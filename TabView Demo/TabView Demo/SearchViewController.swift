//
//  SearchViewController.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-08.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        
        searchBar.frame = CGRectMake(0,0, self.view.bounds.size.width, 44)
        searchBar.delegate = self
        searchBar.placeholder = "Search Questions/Articles..."
        self.view.addSubview(searchBar)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // Do something
    }
}