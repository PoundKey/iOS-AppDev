//
//  GameViewController.swift
//  Air Strike
//
//  Created by Chang Tong Xue on 2015-12-31.
//  Copyright (c) 2015 DX. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var mainScene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        let skView = self.view as! SKView
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        mainScene = GameScene(size: skView.bounds.size)
        mainScene.scaleMode = .AspectFill
        
        skView.presentScene(mainScene)
        
        let image = UIImage(named: "BurstAircraftPause")!
        let button = UIButton()
        button.frame = CGRectMake(10, 25, image.size.width,image.size.height)
        button.setBackgroundImage(image, forState: .Normal)
        button.addTarget(self, action: "pause", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gameOver", name: "gameOverNotification", object: nil)

    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension GameViewController {
    
    func gameOver() {
        let backgroundView = UIView(frame: self.view.bounds)
        let button = UIButton()
        button.bounds = CGRectMake(0, 0, 200, 30)
        button.center = backgroundView.center
        button.setTitle("Restart", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: 18)
        button.layer.borderWidth = 2.0
        button.layer.cornerRadius = 15.0
        button.layer.borderColor = UIColor.grayColor().CGColor
        button.addTarget(self, action: "restart:", forControlEvents: .TouchUpInside)
        backgroundView.addSubview(button)
        
        let button3 = UIButton()
        button3.bounds = CGRectMake(0, 50, 200, 30)
        button3.center = CGPointMake(backgroundView.center.x, backgroundView.center.y + 50)
        button3.setTitle("Record: \(getRecord()) Points", forState: .Normal)
        button3.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button3.titleLabel?.font = UIFont(name: "Futura Medium", size: 12)
        button3.layer.borderWidth = 2.0
        button3.layer.cornerRadius = 15.0
        button3.layer.borderColor = UIColor.grayColor().CGColor
        backgroundView.addSubview(button3)
        
        backgroundView.center = self.view.center
        self.view.addSubview(backgroundView)
    }
    
    func pause() {
        mainScene._bgmSFX.pause()
        
        (self.view as! SKView).paused = true
        let pauseView = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200))
        
        let button1 = UIButton()
        button1.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 100, 50, 200, 30)
        button1.setTitle("Continue", forState: .Normal)
        button1.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button1.titleLabel?.font = UIFont(name: "Chalkduster", size: 18)
        button1.layer.borderWidth = 2.0
        button1.layer.cornerRadius = 15.0
        button1.layer.borderColor = UIColor.grayColor().CGColor
        button1.addTarget(self, action: "continueGame:", forControlEvents: .TouchUpInside)
        pauseView.addSubview(button1)
        
        let button2 = UIButton()
        button2.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 100, 100, 200, 30)
        button2.setTitle("Restart", forState: .Normal)
        button2.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button2.titleLabel?.font = UIFont(name: "Chalkduster", size: 18)
        button2.layer.borderWidth = 2.0
        button2.layer.cornerRadius = 15.0
        button2.layer.borderColor = UIColor.grayColor().CGColor
        button2.addTarget(self, action: "restart:", forControlEvents: .TouchUpInside)
        pauseView.addSubview(button2)
    
        let button3 = UIButton()
        button3.frame = CGRectMake(CGRectGetWidth(self.view.frame) / 2 - 100, 150, 200, 30)
        button3.setTitle("Record: \(getRecord()) Points", forState: .Normal)
        button3.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button3.titleLabel?.font = UIFont(name: "Futura Medium", size: 12)
        button3.layer.borderWidth = 2.0
        button3.layer.cornerRadius = 15.0
        button3.layer.borderColor = UIColor.grayColor().CGColor
        pauseView.addSubview(button3)
        
        pauseView.center = self.view.center
        
        self.view.addSubview(pauseView)
    }
    
    func restart(button: UIButton) {
        button.superview!.removeFromSuperview()
        (self.view as! SKView).paused = false
        NSNotificationCenter.defaultCenter().postNotificationName("restartNotification", object: nil)
    }
    
    func continueGame(button: UIButton) {
        button.superview!.removeFromSuperview()
        mainScene._bgmSFX.play()
        (self.view as! SKView).paused = false
        
    }
    
    func getRecord() -> Int {
        let def = NSUserDefaults.standardUserDefaults()
        let record = def.integerForKey("record")
        return record
    }
}
