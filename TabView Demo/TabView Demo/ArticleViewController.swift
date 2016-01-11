//
//  ArticleViewController.swift
//  TabView Demo
//
//  Created by Chang Tong Xue on 2016-01-08.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var scrollView: UIScrollView!
    
    var slideView: UIView!
    let topViewBarTitles = ["Latest", "Hottest", "Rummor"]
    
    var screenWidth: Float!
    var screenHeight: Float!
    
    var currentButton: UIButton!
    var currentLabel: UILabel!
    
    var currentViewController: UIViewController!
    var contentView: UIView!
    
    
    
    lazy var newsViewController: NewsViewController = {
        //let newsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NewsViewController")
        return NewsViewController()
    }()
    
    lazy var hotViewController: HotViewController = HotViewController()
    
    lazy var rumorViewController: RumorViewController = RumorViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Articles"
        self.view.backgroundColor = UIColor.redColor()
        
        screenWidth = Float(self.view.frame.size.width)
        screenHeight = Float(self.view.frame.size.height)
        
        contentView = UIView(frame: CGRectMake(0, 40, CGFloat(screenWidth), CGFloat(screenHeight - 40)))
        self.view.addSubview(contentView)
        
        loadTopViewSlider()
        loadCurrentViewController(0)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        currentViewController.viewWillDisappear(animated)
    }
    
    
    func loadCurrentViewController(tag: Int) {
        
        switch tag {
        case 0:
           currentViewController = newsViewController
        case 1:
            currentViewController = hotViewController
        case 2:
            currentViewController = rumorViewController
        default:
           currentViewController = UIViewController()
        }
        
        self.addChildViewController(currentViewController)
        currentViewController.didMoveToParentViewController(self)
        currentViewController.view.frame = self.contentView.bounds
        contentView.addSubview(currentViewController.view)
        
    }
    
    
    func loadTopViewSlider() {
        slideView = UIView(frame: CGRectMake(0, 0, CGFloat(screenWidth), 40))
        slideView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view.addSubview(slideView)
        
        let avgWidth = screenWidth / 3
        
        var slideButton: UIButton
        
        for (index, title) in topViewBarTitles.enumerate() {
            
            slideButton = UIButton(frame: CGRectMake(CGFloat(avgWidth) * CGFloat(index), 0 , CGFloat(avgWidth), 40))
            slideButton.tag = index
            slideButton.setTitle(title, forState: .Normal)
            slideButton.addTarget(self, action: "slideButtonClick:", forControlEvents: .TouchUpInside)
            slideButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
            slideButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
            slideView.addSubview(slideButton)
            
            if(slideButton.tag == 0) {
                let color = UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0)
                slideButton.setTitleColor(color, forState: UIControlState.Normal)
            }
            
            if index == 0 { self.currentButton = slideButton }
        }
        
        currentLabel = UILabel(frame: CGRectMake(0, 38, CGFloat(avgWidth), 2))
        currentLabel.backgroundColor = UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        slideView.addSubview(currentLabel)
    }
    
    func resetContentView(sender: UIButton) {
        self.currentViewController.view.removeFromSuperview()
        self.currentViewController.removeFromParentViewController()
    }
    
    func resetButtonAndLabel(sender: UIButton) {
        currentButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
        currentButton = sender
        let color = UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        sender.setTitleColor(color, forState: .Normal)
    }
    
    func slideButtonClick(sender: UIButton) {
        
        if sender.tag == currentButton.tag { return }
        
        resetButtonAndLabel(sender)
        resetContentView(sender)
        loadCurrentViewController(sender.tag)
        
         // Animate the label bar under the button
        UIView.animateWithDuration(0.2, animations: {
            self.currentLabel.frame = CGRectMake(sender.frame.origin.x, 38, CGFloat(self.screenWidth)/3, 2);
        })
    }

}
