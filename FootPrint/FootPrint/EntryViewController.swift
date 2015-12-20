//
//  EntryViewController.swift
//  FootPrint
//
//  Created by Chang Tong Xue on 2015-12-19.
//  Copyright © 2015 DX. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var entryName: UITextField!
    @IBOutlet weak var entryCategory: UITextField!
    @IBOutlet weak var entryDetail: UITextView!
    
    var selectedAnnotation: FootPrintAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

extension EntryViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        performSegueWithIdentifier("category", sender: self)
    }
}
