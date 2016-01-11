//
//  NewsViewController.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-10.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("NewViewController Loaded")
        let color: UIColor = UIColor(red: 255.0 / 255, green: 20.0 / 255, blue: 147.0 / 255, alpha: 1)
        self.view.backgroundColor = color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
