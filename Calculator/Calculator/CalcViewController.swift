//
//  ViewController.swift
//  Calculator
//
//  Created by Chang Tong Xue on 2016-01-16.
//  Copyright © 2016 DX. All rights reserved.
//

import UIKit

class CalViewController: UIViewController {
    
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
        screenLabel.highlightedTextColor = UIColor.yellowColor()
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
        let input: String = (button.titleLabel?.text)!
        switch input {
        case "%", "÷", "x", "-", "+":
            updateOperations(input)
        case "AC":
            clear()
            updateScreen(result)
        case "=":
            updateResult()
        case "+/-":
            updateSign()
        default:
            updateNumber(input) // When button pressed is digit or dot
        }
    }
    
    func evaluate() {
        let res = result
        if let input = currentInput, op = operation {
            result = calculate(res, input: input, op: op)
            updateScreen(result)
        }
    }

    func clear() {
        result = "0"
        operation = nil
        currentInput = nil
    }
    
    func calculate(res: String, input: String, op: String) -> String {
        //var operand1 = isDecimal(res) ? Float(res)! : Int(res)!
        //var operand2 = isDecimal(input) ? Float(input)! : Int(input)!
        let operand1 = NSDecimalNumber(string:res)
        let operand2 = NSDecimalNumber(string:input)
        var result = "0"
        switch op {
        case "%":
            break
        case "÷":
            let val = operand1.decimalNumberByDividingBy(operand2)
            result = String(val)
        case "x":
            let val = operand1.decimalNumberByMultiplyingBy(operand2)
            result = String(val)
        case "-":
            let val = operand1.decimalNumberBySubtracting(operand2)
            result = String(val)
        case "+":
            let val = operand1.decimalNumberByAdding(operand2)
            result = String(val)
        default:
            break
        }
        return result
    }
    
    func updateOperations(input: String) {
        
        updatePrevResult()
        if let _ = currentInput, _ = operation {
            evaluate()
        }
        screenBlink()
        operation = input
    }
    
    func updateResult() {
        if currentInput != nil {
            evaluate()
            clear()
        } else {
            screenBlink()
        }
    }
    
    func updateSign() {
        updatePrevResult()
        if let input = currentInput, _ = operation {
            let val = NSDecimalNumber(string:input).decimalNumberByMultiplyingBy(-1)
            currentInput = String(val)
            updateScreen(currentInput!)
        } else {
            let val = NSDecimalNumber(string:result).decimalNumberByMultiplyingBy(-1)
            result = String(val)
            updateScreen(result)
        }
    }
    
    func updateNumber(input: String) {
        if operation == nil {
            if input == "." {
                result += "."
            } else if result == "0" {
                result = input
            } else {
                result += input
            }
            updateScreen(result)
            
        } else {
            if let curInput = currentInput {
                currentInput = curInput + input
            } else {
                if input == "." {
                    currentInput = "0."
                } else {
                    currentInput = input
                }
            }
            updateScreen(currentInput!)
        }
    }
    
    func updatePrevResult() {
        let isPrevResult = (screenLabel.text != "0" && operation == nil && currentInput == nil)
        if isPrevResult {
            self.result = (screenLabel.text)!
        }
    }
    
    func convertToNumber(input: String) -> NSNumber {
        let number: NSNumber = isDecimal(input) ? Float(input)! : Int(input)!
        return number
    }
    
    func updateScreen(val: String) {
        screenLabel.text = val
    }
    
    func screenBlink() {
        UIView.transitionWithView(screenLabel, duration: 0.1, options: .TransitionCrossDissolve, animations: {
            self.screenLabel.textColor = UIColor.lightGrayColor()
            }) { val in
                self.screenLabel.textColor = UIColor.whiteColor()
        }
    }
    
    func isDecimal(input: String) -> Bool {
        for i in input.characters {
            if i == "."  {
                return true
            }
        }
        return false
    }
    
    func isValid() -> Bool {
        let input: String = operation == nil ? result : currentInput!
        return isDecimal(input) ? false : true
    }
    
}

