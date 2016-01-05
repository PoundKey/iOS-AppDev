//
//  GameScene.swift
//  Air Strike
//
//  Created by Chang Tong Xue on 2015-12-31.
//  Copyright (c) 2015 DX. All rights reserved.
//

import SpriteKit
import AVFoundation.AVAudioPlayer

class GameScene: SKScene {
    
    var _smallPlaneTime: Int  = 0
    var _mediumPlaneTime: Int = 0
    var _bigPlaneTime: Int    = 0
    
    var _scrollBackgroundPosition: Int?
    
    let _scoreLabel  = SKLabelNode(fontNamed: "MarkerFelt-Thin")
    let _playerPlane = SKSpriteNode(texture: SharedAtlas.textureWithType(.PlayerPlane))
    let _background1 = SKSpriteNode(texture: SharedAtlas.textureWithType(.Background))
    let _background2 = SKSpriteNode(texture: SharedAtlas.textureWithType(.Background))
    
    let _smallFoePlaneHitAction     = SharedAtlas.hitActionWithFoePlaneType(.Small)
    let _mediumFoePlaneHitAction    = SharedAtlas.hitActionWithFoePlaneType(.Medium)
    let _bigFoePlaneHitAction       = SharedAtlas.hitActionWithFoePlaneType(.Big)

    let _smallFoePlaneBlowupAction  = SharedAtlas.blowupActionWithFoePlaneType(.Small)
    let _mediumFoePlaneBlowupAction = SharedAtlas.blowupActionWithFoePlaneType(.Medium)
    let _bigFoePlaneBlowupAction    = SharedAtlas.blowupActionWithFoePlaneType(.Big)
    
    var _bgmSFX: AVAudioPlayer!

    override func didMoveToView(view: SKView) {
        self.size = view.bounds.size
        initScene()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "restart", name: "restartNotification", object: nil)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let action = SKAction.moveTo(location, duration: 0.8)
            _playerPlane.runAction(action)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        createFoePlane()
        scrollBackground()
    }
    
    
    func initScene() {
        initPhysicsWorld()
        initScore()
        initBackground()
        initPlayerPlane()
        fireBullets()
    }
    
    func initPhysicsWorld() {
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody?.categoryBitMask = edgeCategory
        self.physicsBody?.collisionBitMask = playerPlaneCategory
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0,0);
    }
    
    func initScore() {
        _scoreLabel.text = "0000"
        _scoreLabel.zPosition = 2
        _scoreLabel.fontColor = SKColor.blackColor()
        _scoreLabel.horizontalAlignmentMode = .Left
        _scoreLabel.position = CGPointMake(50, self.size.height - 52)
        
        self.addChild(_scoreLabel)
    }
    
    
    func initPlayerPlane() {
        _playerPlane.position = CGPointMake(160, 50);
        _playerPlane.zPosition = 1;
        _playerPlane.physicsBody = SKPhysicsBody(circleOfRadius: _playerPlane.frame.size.width / 3)
        _playerPlane.physicsBody?.categoryBitMask = playerPlaneCategory
        _playerPlane.physicsBody?.collisionBitMask = edgeCategory
        _playerPlane.physicsBody?.contactTestBitMask = foePlaneCategory
        _playerPlane.physicsBody?.friction = 0
        _playerPlane.physicsBody?.linearDamping = 0
        _playerPlane.physicsBody?.angularDamping = 0
        _playerPlane.physicsBody?.restitution = 0
        self.addChild(_playerPlane)
        _playerPlane.runAction(SharedAtlas.playerPlaneAction())
    }
    
    func initBackground() {
        _scrollBackgroundPosition = Int(self.size.height)
        
        _background1.position = CGPointMake(self.size.width / 2, 0);
        _background1.anchorPoint = CGPointMake(0.5, 0);
        _background1.zPosition = 0
        
        _background2.position = CGPointMake(self.size.width / 2, CGFloat(_scrollBackgroundPosition! - 1));
        _background2.anchorPoint = CGPointMake(0.5, 0);
        _background2.zPosition = 0;
        
        self.addChild(_background1)
        self.addChild(_background2)
        
        // TODO: run background music here
        let url = NSBundle.mainBundle().URLForResource("game_music", withExtension: "mp3")!
        _bgmSFX = try! AVAudioPlayer(contentsOfURL: url, fileTypeHint: "mp3")
        _bgmSFX.numberOfLoops = -1;
        _bgmSFX.volume = 0.3;
        _bgmSFX.prepareToPlay()
        _bgmSFX.play()
    }
    
    func scrollBackground() {
        _scrollBackgroundPosition = _scrollBackgroundPosition! - 1;
        
        if (_scrollBackgroundPosition < 0) {
            _scrollBackgroundPosition = Int(self.size.height)
        }
        _background1.position = CGPointMake(self.size.width / 2, CGFloat(_scrollBackgroundPosition! - Int(self.size.height)));
        _background2.position = CGPointMake(self.size.width / 2, CGFloat(_scrollBackgroundPosition! - 1))
    }

    
    func createFoePlane() {
        _smallPlaneTime += 1
        _mediumPlaneTime += 1
        _bigPlaneTime += 1
        
        // the clousre that creates a foe plane asynchronously
        let createAsync = { (type: FoePlaneType) -> FoePlane in
            
            let x = (arc4random() % 220) + 35
            
            let foePlane: FoePlane
            
            switch type {
            case .Big:
                foePlane = FoePlane.createBigPlane()
            case .Medium:
                foePlane = FoePlane.createMediumPlane()
            case .Small:
                foePlane = FoePlane.createSmallPlane()
            }
            
            foePlane.zPosition = 1
            foePlane.physicsBody = SKPhysicsBody(rectangleOfSize: foePlane.size)
            foePlane.physicsBody?.categoryBitMask = foePlaneCategory
            foePlane.physicsBody?.collisionBitMask = bulletCategory
            foePlane.physicsBody?.contactTestBitMask = bulletCategory
            foePlane.position = CGPointMake(CGFloat(x), self.size.height)
            
            return foePlane
        }
        
        if _smallPlaneTime > 30 {
            let speed = (arc4random() % 3) + 2
            
            let foePlane = createAsync(.Small)
            self.addChild(foePlane)
            let moveDown = SKAction.moveToY(0, duration: Double(speed))
            let remove = SKAction.removeFromParent()
            foePlane.runAction(SKAction.sequence([moveDown, remove]))
            
            _smallPlaneTime = 0
        }
        
        if _mediumPlaneTime > 360 {
            let speed = (arc4random() % 3) + 4
            
            let foePlane = createAsync(.Medium)
            self.addChild(foePlane)
            let moveDown = SKAction.moveToY(0, duration: Double(speed))
            let remove = SKAction.removeFromParent()
            foePlane.runAction(SKAction.sequence([moveDown, remove]))
            
            _mediumPlaneTime = 0
        }
        
        if _bigPlaneTime > 720 {
            let speed = (arc4random() % 3) + 6
            
            let foePlane = createAsync(.Big)
            self.addChild(foePlane)
            let moveDown = SKAction.moveToY(0, duration: Double(speed))
            let remove = SKAction.removeFromParent()
            foePlane.runAction(SKAction.sequence([moveDown, remove]))
            
            let action = SKAction.playSoundFileNamed("enemy2_out.mp3", waitForCompletion: false)
            self.runAction(action)
            
            _bigPlaneTime = 0
        }
    }
    
    func createBullets() {
        let bullet = SKSpriteNode(texture: SharedAtlas.textureWithType(.Bullet))
        bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.size)
        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.collisionBitMask = foePlaneCategory
        bullet.physicsBody?.contactTestBitMask = foePlaneCategory
        bullet.zPosition = 1;
        bullet.position = CGPointMake(_playerPlane.position.x, _playerPlane.position.y + (_playerPlane.size.height / 2));
        self.addChild(bullet)
        
        let move = SKAction.moveTo(CGPointMake(_playerPlane.position.x, self.size.height), duration: 0.75)
        let remove = SKAction.removeFromParent()
        bullet.runAction(SKAction.sequence([move, remove]))
        
        self.runAction(SKAction.playSoundFileNamed("bullet.mp3", waitForCompletion: false))
    }
    
    func fireBullets() {
        let fire = SKAction.runBlock {
            self.createBullets()
        }
        let interval = SKAction.waitForDuration(0.3)
        let actions = SKAction.sequence([fire, interval])
        self.runAction(SKAction.repeatActionForever(actions))
    }
    
    func changeScore(type: FoePlaneType) {
        let score: Int
        switch type {
        case .Big:
            score = 30000
        case .Medium:
            score = 6000
        case .Small:
            score = 1000
        }
        let updateScore = SKAction.runBlock {
            let prevScore = Int(self._scoreLabel.text!)
            let newScore = prevScore! + score
            self._scoreLabel.text = String(newScore)
        }
        self._scoreLabel.runAction(updateScore)
    }
    
    func foePlaneCollisionAnimation(plane: FoePlane) {
        let hitAction: SKAction
        let blowupAction: SKAction
        let SFX: String
        
        plane.hp -= 1
        
        switch plane.type {
        case .Big:
            hitAction = _bigFoePlaneHitAction
            blowupAction = _bigFoePlaneBlowupAction
            SFX = "enemy2_down.mp3"
        case .Medium:
            hitAction = _mediumFoePlaneHitAction
            blowupAction = _mediumFoePlaneBlowupAction
            SFX = "enemy3_down.mp3"
        case .Small:
            hitAction = _smallFoePlaneHitAction;
            blowupAction = _smallFoePlaneBlowupAction;
            SFX = "enemy1_down.mp3"
        }

        if plane.hp == 0 {
            plane.removeAllActions()
            plane.runAction(blowupAction)
            self.changeScore(plane.type)
            self.runAction(SKAction.playSoundFileNamed(SFX, waitForCompletion: false))
        } else if plane.hp > 0 {
            plane.runAction(hitAction)
        }
    }
    
    func playerPlaneCollisionAnimation(plane: SKSpriteNode) {
        self.removeAllActions()
        
        let blowup = SharedAtlas.playerPlaneBlowupAction()
        let gameOverMusic = SKAction.playSoundFileNamed("game_over.mp3", waitForCompletion: false)
        let interval = SKAction.waitForDuration(1.0)
        let gameOver = SKAction.runBlock {
            let label = SKLabelNode(fontNamed: "MarkerFelt-Thin")
            label.text = "Game Over"
            label.fontColor = SKColor.blackColor()
            label.position = CGPointMake(self.size.width / 2, self.size.height / 2 + 36)
            self.addChild(label)
        }
        
        plane.runAction(blowup) {
            let actions = SKAction.sequence([gameOverMusic, interval, gameOver])
            self.runAction(actions) {
                NSNotificationCenter.defaultCenter().postNotificationName("gameOverNotification", object: nil)
            }
        }
    }
    
    func restart() {
        removeAllChildren()
        removeAllActions()
        initBackground()
        initScore()
        initPlayerPlane()
        fireBullets()
    }
    
    func setRecord(score: Int) {
        let def: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let record = def.integerForKey("record")
        if score > record {
            def.setInteger(score, forKey: "record")
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBeginContact(contact: SKPhysicsContact) {
        // first return the SKNode with larger category
        let first  = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ? contact.bodyA : contact.bodyB
        
        // second return the SKnode with smaller category
        let second = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ? contact.bodyB : contact.bodyA;
        
        if second.categoryBitMask == bulletCategory {
            // Bullet hits a foe plane
            let bullet = second.node
            bullet?.removeFromParent()
            
            let foePlane = first.node as! FoePlane
            foePlaneCollisionAnimation(foePlane)
            
        } else if second.categoryBitMask == playerPlaneCategory {
            _bgmSFX.stop()
            if let score = Int(_scoreLabel.text!) {
                setRecord(score)
            }
            // Player plane hit by a foe plane
            playerPlaneCollisionAnimation(_playerPlane)
        }
    }
}

let edgeCategory: UInt32        = 0x1
let bulletCategory: UInt32      = 0x1 << 1
let playerPlaneCategory: UInt32 = 0x1 << 2
let foePlaneCategory: UInt32    = 0x1 << 3
