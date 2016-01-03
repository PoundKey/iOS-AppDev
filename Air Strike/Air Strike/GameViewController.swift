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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        let scene = GameScene(size: skView.frame.size)
        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
        
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
        
    }
    
    func pause() {
        
    }
    
    func restart(button: UIButton) {
        
    }
    
    func continueGame(button: UIButton) {
        
        
    }
}
