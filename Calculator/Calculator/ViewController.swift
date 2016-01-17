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
    
    var result = "0"
    var currentInput: String?
    var operation: String?
    
    let buttons = [["AC", "+/-", "%", "÷"],
                   ["7", "8", "9", "x"],
                   ["4", "5", "6", "-"],
                   ["1", "2", "3", "+"],
                   ["0", "E", ".", "="]]
    
    var buttonWidth: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        buttonWidth = Float(self.view.frame.size.width) / 4
        
        initScreen()
        initButtons()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func initScreen() {
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
                button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 36)
                button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                setButtonColor(button)
                button.addTarget(self, action: "handleButtonPress:", forControlEvents: .TouchUpInside)
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
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        case "0":
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.width * 2, button.frame.height)
        case "E":
            button.frame = CGRectMake(0, 0, 0, 0)
        default:
            break
        }
    }
    
    func handleButtonPress(button: UIButton) {
        let title: String = (button.titleLabel?.text)!
        switch title {
        case "%", "÷", "x", "-", "+":
            break
        case "AC":
            break
        case "+/-":
            break
        default:
            // When button pressed is digit or dot
            break
        }
    }
    
    func evaluate() {
        if let input = currentInput, op = operation {
            
            
        }
    }
    
    
    func updateScreen() {
        if let op = operation {
            
        } else {
            
            
        }
    }

    
}

