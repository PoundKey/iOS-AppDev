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
    var footPrint: FootPrint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
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
            self.footPrint = newFootPrint
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
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
