//
//  RumorViewController.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-10.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class RumorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("RumorViewController Loaded")
        let color: UIColor = UIColor(red: 32.0 / 255, green: 178.0 / 255, blue: 170.0 / 255, alpha: 1)
        self.view.backgroundColor = color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
