//
//  ViewController.swift
//  Calculator
//
//  Created by Chang Tong Xue on 2016-01-16.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var screenLabel: UILabel!
    var pressedButton: UIButton?
    var sign: String = "+"
    var input1: String?
    var input2: String?
    
    
    let buttons = [["AC", "+/-", "%", "÷"],
                   ["7", "8", "9", "x"],
                   ["4", "5", "6", "-"],
                   ["1", "2", "3", "+"],
                   ["0", "E", ".", "="]]
    
    let buttonTargets = []
    
    var buttonWidth: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        buttonWidth = Float(self.view.frame.size.width) / 4
        
        initScreenLabel()
        initButtons()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func initScreenLabel() {
        let labelWidth = self.view.frame.size.width - 10
        let labelHeight = self.view.frame.size.height - CGFloat(5 * buttonWidth)
        
        screenLabel = UILabel(frame: CGRectMake(5, 20, labelWidth, labelHeight))
        screenLabel.text = "0"
        screenLabel.textColor = UIColor.whiteColor()
        screenLabel.font = UIFont.systemFontOfSize(45)
        screenLabel.textAlignment = .Right
        screenLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(screenLabel)
    }
    
    func initButtons() {
        let row = 5, col = 4
        let initY = Float(self.view.frame.height) - 5 * buttonWidth
        
        for var i = 0; i < col; i++ {
            for var j = 0; j < row; j++ {
    
                let x = CGFloat(Float(i) * buttonWidth)
                let y = CGFloat(initY + Float(j) * buttonWidth)
                let width = CGFloat(buttonWidth)
                let button = UIButton(frame:CGRectMake(x, y, width, width))
                button.backgroundColor = UIColor.lightGrayColor()
                button.layer.borderWidth = 0.35
                button.layer.borderColor = UIColor.blackColor().CGColor
                button.setTitle(buttons[j][i], forState: .Normal)
                button.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
                button.titleLabel?.font = UIFont.systemFontOfSize(36)
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                setButtonColor(button)
                self.view.addSubview(button)
                
            }
        }
        

    }
    
    func setButtonColor(button: UIButton) {
        let title: String = (button.titleLabel?.text)!
        switch title {
        case "AC", "+/-", "%":
            button.backgroundColor = UIColor.grayColor()
        case "÷", "x", "-", "+", "=":
            button.backgroundColor = UIColor.orangeColor()
        case "0":
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.width * 2, button.frame.height)
        case "E":
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, 0, 0)
        default:
            break
        }
    }
    
    func clear() {
        
    }
    
    func changeSign() {
        
    }
    
    func mod() {
        
    }
    
    func sum() {
        
    }

}

