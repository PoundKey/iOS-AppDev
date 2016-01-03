//
//  GameScene.swift
//  Air Strike
//
//  Created by Chang Tong Xue on 2015-12-31.
//  Copyright (c) 2015 DX. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        initScene()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "restart", name: "restartNotification", object: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        createFoePlane()
        scrollBackground()
    }
    
    func initScene() {
        initPhysicsWorld()
        initAction()
        initBackground()
        initScore()
        initPlayerPlane()
        fireBullets()
    }
    
    func initPhysicsWorld() {
        
    }
    
    func initAction() {
        
    }
    
    func initBackground() {
        
    }
    
    func initScore() {
        
    }
    
    func initPlayerPlane() {
        
    }
    
    
    func createFoePlane() {
        
    }
    
    func createBullets() {
        
    }
    
    func fireBullets() {
        
    }
    
    func scrollBackground() {
        
    }
    
    func changeScore(type: FoePlaneType) {
        let score: Int
        
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
    
    static let edgeCategory        = 0x1
    static let bulletCategory      = 0x1 << 1
    static let foePlaneCategory    = 0x1 << 2
    static let playerPlaneCategory = 0x1 << 3
    
    func didBeginContact(contact: SKPhysicsContact) {
        
    }
}
