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
        
        if entryName.text!.isEmpty || entryCategory.text!.isEmpty {
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
    
    @IBAction func cancelFromCategories(segue: UIStoryboardSegue) {
        //print("This is a unwind going back")
    }
    
    @IBAction func confirmFromCategories(segue: UIStoryboardSegue) {
        print("Hello Unwind Action")
        if segue.identifier == "category" {
            /**
            let categoriesController = segue.sourceViewController as! CategoryTVController
            selectedCategory = categoriesController.selectedCategory
            entryCategory.text = selectedCategory!.name
*/
        }
    }
}

extension EntryViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        performSegueWithIdentifier("category", sender: self)
    }
}
