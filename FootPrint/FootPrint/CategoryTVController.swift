//
//  CategoryTVController.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-19.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTVController: UITableViewController {
    
    let realm = try! Realm()
    lazy var categories: Results<Category> = { self.realm.objects(Category).sorted("name") }()
    
    var selectedCategory: Category!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDefaultCategories()
        // print(Realm.Configuration.defaultConfiguration.path!) // DataStore Physical Location
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        // Calls when decide if the unwind should happen
        //print("CategoryTVController: undwind \(identifier)")
        return true
    }
    
    func populateDefaultCategories() {
        
        if categories.count == 0 {
            
            try! realm.write() {
                
                for category in defaultCategories {
                    let newCategory = Category()
                    newCategory.name = category
                    realm.add(newCategory)
                }
            }
            
            categories = realm.objects(Category).sorted("name")
        }
    }
    
    
    

}

extension CategoryTVController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        let imageName = getIconImage(category.name)
        cell.imageView!.image = UIImage(named: imageName)
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath {
        selectedCategory = categories[indexPath.row]
        return indexPath
    }
}
