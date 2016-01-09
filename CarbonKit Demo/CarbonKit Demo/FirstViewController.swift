//
//  FirstViewController.swift
//  CarbonKit Demo
//
//  Created by Chang Tong Xue on 2016-01-07.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var items = []
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        items = [UIImage(named: "note")!, UIImage(named: "photo")!, UIImage(named: "favorite")!, UIImage(named: "info")!, "SpaceX", "Geography", "Science","More..."]
        
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insertIntoRootViewController(self)
        self.style()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func style() {
        let color: UIColor = UIColor(red: 24.0 / 255, green: 75.0 / 255, blue: 152.0 / 255, alpha: 1)
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = color
        self.navigationController!.navigationBar.barStyle = .BlackTranslucent
        carbonTabSwipeNavigation.toolbar.translucent = false
        carbonTabSwipeNavigation.setIndicatorColor(color)
        
        carbonTabSwipeNavigation.setTabExtraWidth(30)
        for var i = 0; i < items.count; i++ {
            carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(80, forSegmentAtIndex: i)
        }
        
        carbonTabSwipeNavigation.setNormalColor(UIColor.blackColor().colorWithAlphaComponent(0.6))
        carbonTabSwipeNavigation.setSelectedColor(color, font: UIFont.boldSystemFontOfSize(14))
        
    }
    
    


}

extension FirstViewController: CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAtIndex index: UInt) -> UIViewController {
        switch index {
        case 0:
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("NoteViewController") as! NoteViewController
            return controller
        case 1:
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PhotoViewController") as! PhotoViewController
            return controller
        default:
            return UIViewController()
        }
        
    }
    
    func carbonTabSwipeNavigation(carbonTabSwipeNavigation: CarbonTabSwipeNavigation, didMoveAtIndex index: UInt) {
        switch index {
        case 0:
            self.navigationItem.title = "News"
        case 1:
            self.navigationItem.title = "PhotoViews"
        case 2:
            self.navigationItem.title = "Favorites"
        case 3:
            self.navigationItem.title = "Books"
        default:
            self.navigationItem.title = "CarbonKit"
        }
    }
}
