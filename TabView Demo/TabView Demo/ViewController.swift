//
//  ViewController.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-02.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Call from ViewController")
        // Do any additional setup after loading the view, typically from a nib.
        if let count = tabBarController?.tabBar.items?.count {
            print("HelloWorld \(count)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }


}

