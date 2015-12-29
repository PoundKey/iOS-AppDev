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
    @IBOutlet weak var entryCancel: UIBarButtonItem!
    
    var selectedAnnotation: FootPrintAnnotation!
    var selectedCategory: Category?
    var footPrint: FootPrint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedAnnotation.title! != "Untitled" {
            footPrint = selectedAnnotation.footPrint
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
    
    func addFootPrint() {
        let realm = try! Realm()
        
        try! realm.write {
            let newFootPrint = FootPrint()
            
            newFootPrint.name = self.entryName.text!
            newFootPrint.category = self.selectedCategory
            newFootPrint.detail = self.entryDetail.text
            newFootPrint.latitude = self.selectedAnnotation.coordinate.latitude
            newFootPrint.longitude = self.selectedAnnotation.coordinate.longitude
            
            realm.add(newFootPrint)
            footPrint = newFootPrint
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier! == "cancelEntry" {
            
            let alert = UIAlertController(title: "Delete FootPrint", message: "Are you sure to you want to delete?", preferredStyle: .Alert)
            // add the actions (buttons)
            let alertActionDelete = UIAlertAction(title: "Delete", style: .Destructive) { action in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }
            
            let alertActionCancel = UIAlertAction(title: "Cancel", style: .Cancel) {
                action in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }
            
            alert.addAction(alertActionDelete)
            alert.addAction(alertActionCancel)
            //self.presentViewController(alert, animated: true, completion: nil)
            return true
        }
        
        if validateFields() {
            addFootPrint()
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
