//
//  EntryViewController.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-19.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController {

    @IBOutlet weak var entryName: UITextField!
    @IBOutlet weak var entryCategory: UITextField!
    @IBOutlet weak var entryDetail: UITextView!
    
    var selectedAnnotation: FootPrintAnnotation!
    var selectedCategory: Category?
    var selectedFootPrint: FootPrint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedAnnotation.title! != "Untitled" {
            selectedFootPrint = selectedAnnotation.footPrint
            fillTextFields(selectedFootPrint!)
            title = "Edit \(selectedFootPrint!.name)"
        } else {
            title = "New FootPrint"
        }
    
    }
    
    
    override func viewWillAppear(animated: Bool) {
        // if footPrint != nil 
        if entryName.text! == "" {
            entryName.becomeFirstResponder()
        } else {
            entryDetail.becomeFirstResponder()
        }
    }
    
    func fillTextFields(footprint: FootPrint) {
        entryName.text     = footprint.name
        entryCategory.text = footprint.category.name
        entryDetail.text   = footprint.detail
        selectedCategory   = footprint.category
    }
    
    func validateFields() -> Bool {
        if entryName.text!.isEmpty || selectedCategory == nil {
            let alertController = UIAlertController(title: "Oops...", message: "Please fill all required fields.", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Destructive) { action in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(alertAction)
            presentViewController(alertController, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    @IBAction func removeFootPrint(sender: AnyObject) {
        if let footprint = selectedFootPrint {
            let alert = UIAlertController(title: "Delete FootPrint?", message: "Are you sure to you want to delete?", preferredStyle: .Alert)
            let alertActionDelete = UIAlertAction(title: "Delete", style: .Destructive) { action in
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(footprint)
                }
                alert.dismissViewControllerAnimated(true, completion: nil)
                self.performSegueWithIdentifier("cancelEntry", sender: self)
            }
            
            let alertActionCancel = UIAlertAction(title: "Cancel", style: .Cancel) {
                action in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alert.addAction(alertActionDelete)
            alert.addAction(alertActionCancel)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("cancelEntry", sender: self)
        }

    }
    
    func addFootPrint() {
        let realm = try! Realm()
        
        try! realm.write {
            let newFootPrint = FootPrint()
            
            newFootPrint.name      = self.entryName.text!
            newFootPrint.category  = self.selectedCategory
            newFootPrint.detail    = self.entryDetail.text
            newFootPrint.latitude  = self.selectedAnnotation.coordinate.latitude
            newFootPrint.longitude = self.selectedAnnotation.coordinate.longitude
            
            realm.add(newFootPrint)
            selectedFootPrint = newFootPrint
        }
    }
    
    func updateFootPrint() {
        let realm = try! Realm()
        try! realm.write {
            if let footprint = selectedFootPrint {
                footprint.name      = self.entryName.text!
                footprint.category  = self.selectedCategory
                footprint.detail    = self.entryDetail.text
                /**
                footprint.latitude  = self.selectedAnnotation.coordinate.latitude
                footprint.longitude = self.selectedAnnotation.coordinate.longitude
                */
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if validateFields() {
            if selectedFootPrint == nil {
                addFootPrint()
            } else {
                updateFootPrint()
            }
            return true
        } else {
            return false
        }
    }
    
    @IBAction func cancelFromCategories(segue: UIStoryboardSegue) {
        //print("segue.identifier: \(segue.identifier)")
    }
    
    @IBAction func confirmFromCategories(segue: UIStoryboardSegue) {
        // check segue.identifier
        let categoriesController = segue.sourceViewController as! CategoryTVController
        selectedCategory = categoriesController.selectedCategory
        entryCategory.text = selectedCategory!.name
        
    }
}

extension EntryViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        performSegueWithIdentifier("category", sender: self)
    }
}
