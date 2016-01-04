//
//  GameScene.swift
//  Air Strike
//
//  Created by Chang Tong Xue on 2015-12-31.
//  Copyright (c) 2015 DX. All rights reserved.
//

import SpriteKit

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
        initBackground()
        initScore()
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
        let action = SKAction.playSoundFileNamed("game_music.mp3", waitForCompletion: true)
        //self.runAction(SKAction.repeatActionForever(action))
    }
    
    func scrollBackground() {
        _scrollBackgroundPosition = _scrollBackgroundPosition! - 1;
        
        if (_scrollBackgroundPosition < 0) {
            _scrollBackgroundPosition = Int(self.size.height)
        }
        _background1.position = CGPointMake(self.size.width / 2, CGFloat(_scrollBackgroundPosition! - Int(self.size.height)));
        _background2.position = CGPointMake(self.size.width / 2, CGFloat(_scrollBackgroundPosition! - 1))
    }
    
    func initScore() {
        _scoreLabel.text = "0000"
        _scoreLabel.zPosition = 2
        _scoreLabel.fontColor = SKColor.blackColor()
        _scoreLabel.horizontalAlignmentMode = .Left
        _scoreLabel.position = CGPointMake(50, self.size.height - 52)
        
        self.addChild(_scoreLabel)
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
        let interval = SKAction.waitForDuration(0.6)
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
        
    }
    
    func playerPlaneCollisionAnimation(plane: SKSpriteNode) {
        
    }
    
    func restart() {
        removeAllChildren()
        removeAllActions()
        initBackground()
        initScore()
        initPlayerPlane()
        fireBullets()
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBeginContact(contact: SKPhysicsContact) {
        
    }
}

let edgeCategory: UInt32        = 0x1
let bulletCategory: UInt32      = 0x1 << 1
let foePlaneCategory: UInt32    = 0x1 << 2
let playerPlaneCategory: UInt32 = 0x1 << 3
