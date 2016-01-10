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
    var slideButton: UIButton!
    var slideLabel: UILabel!
    
    var slideItems = [UIButton]()
    let topViewBarTitles = ["Latest", "Hottest", "Rummor"]
    
    var screenWidth: Float!
    var screenHeight: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Articles"
        screenWidth = Float(self.view.frame.size.width)
        screenHeight = Float(self.view.frame.size.height)
        setTopViewSlider()
        
        let color: UIColor = UIColor(red: 30.0 / 255, green: 144.0 / 255, blue: 255.0 / 255, alpha: 1)
        //let color: UIColor = UIColor(red: 255.0 / 255, green: 20.0 / 255, blue: 147.0 / 255, alpha: 1)
        //let color: UIColor = UIColor(red: 32.0 / 255, green: 178.0 / 255, blue: 170.0 / 255, alpha: 1)
        self.view.backgroundColor = color
       
    }
    
    func setTopViewSlider() {
        slideView = UIView(frame: CGRectMake(0, 0, CGFloat(screenWidth!), 40))
        slideView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.view.addSubview(slideView)
        
        let avgWidth = screenWidth / 3
        
        for (index, title) in topViewBarTitles.enumerate() {
            slideButton = UIButton(frame: CGRectMake(CGFloat(avgWidth) * CGFloat(index), 0 , CGFloat(avgWidth), 40))
            slideButton.tag = (index + 1) * 10
            slideButton.setTitle(title, forState: .Normal)
            slideButton.addTarget(self, action: "slideButtonClick:", forControlEvents: .TouchUpInside)
            slideButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
            slideButton.setTitleColor(UIColor.grayColor(), forState: .Normal)
            slideView.addSubview(slideButton)
            slideItems.append(slideButton)
            
            if(slideButton!.tag==10) {
                let color = UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0)
                slideButton.setTitleColor(color, forState: UIControlState.Normal)
            }
        }
        
        slideLabel = UILabel(frame: CGRectMake(0, 38, CGFloat(avgWidth), 2))
        slideLabel.backgroundColor = UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        slideView.addSubview(slideLabel)
    }
    
    func slideButtonClick(sender:UIButton) {
        // Animate the label bar under the button
        UIView.animateWithDuration(0.2, animations: {
            self.slideLabel.frame = CGRectMake(sender.frame.origin.x, 38, CGFloat(self.screenWidth)/3, 2);
        })
        
        for button in slideItems {
            if button.tag == sender.tag {
                let color = UIColor(red: 21.0/255.0, green: 153.0/255.0, blue: 99.0/255.0, alpha: 1.0)
                button.setTitleColor(color, forState: .Normal)
            } else {
                button.setTitleColor(UIColor.grayColor(), forState: .Normal)
            }
        }
    }

}
