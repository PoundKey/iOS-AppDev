//
//  SharedAtlas.swift
//  Air Strike
//
//  Created by Chang Tong Xue on 2016-01-01.
//  Copyright © 2016 DX. All rights reserved.
//

import SpriteKit

enum TextureType: Int {
    case Background = 1
    case Bullet
    case PlayerPlane
    case SmallFoePlane
    case MediumFoePlane
    case BigFoePlane
}

class SharedAtlas: SKTextureAtlas {
    
    static let atlas = SharedAtlas(named: "gameArts-hd")
    
    class func textureWithType(type: TextureType) -> SKTexture {
        switch type {
        case .Background:
            return atlas.textureNamed("background_2.png")
        case .Bullet:
            return atlas.textureNamed("bullet1.png")
        case .PlayerPlane:
            return atlas.textureNamed("hero_fly_1.png")
        case .SmallFoePlane:
            return atlas.textureNamed("enemy1_fly_1.png")
        case .MediumFoePlane:
            return atlas.textureNamed("enemy3_fly_1.png")
        case .BigFoePlane:
            return atlas.textureNamed("enemy2_fly_1.png")
        }
        
    }
    
    class func playerPlaneTextureWithIndex(index: Int) -> SKTexture {
        return atlas.textureNamed("hero_fly_\(index).png")
    }
    
    class func playerPlaneBlowupTextureWithIndex(index: Int) -> SKTexture {
        return atlas.textureNamed("hero_blowup_\(index).png")
    }
    
    class func hitTextureWithPlaneType(type: Int, animationIndex: Int) -> SKTexture {
        return atlas.textureNamed("enemy\(type)_hit_\(animationIndex).png")
    }
    
    class func blowupTextureWithPlaneType(type: Int, animationIndex: Int) -> SKTexture {
        return atlas.textureNamed("enemy\(type)_blowup_\(animationIndex).png")
    }
    
    class func hitActionWithFoePlaneType(type: FoePlaneType) -> SKAction {
        switch type {
        case .Big:
            let texture1 = SharedAtlas.hitTextureWithPlaneType(2, animationIndex: 1)
            let action1  = SKAction.setTexture(texture1)
            let texture2 = SharedAtlas.textureWithType(.BigFoePlane)
            let action2  = SKAction.setTexture(texture2)
            let actions  = [action1, action2]
            return SKAction.sequence(actions)
            
        case .Medium:
            let texture1 = SharedAtlas.hitTextureWithPlaneType(3, animationIndex: 1)
            let action1  = SKAction.setTexture(texture1)
            let texture2 = SharedAtlas.hitTextureWithPlaneType(3, animationIndex: 2)
            let action2  = SKAction.setTexture(texture2)
            let actions  = [action1, action2]
            return SKAction.sequence(actions)
            
        case .Small:
            return SKAction()
        }
    }

    class func blowupActionWithTextures(type: Int, loop: Int) -> SKAction {
        var textures = [SKTexture]()
        for var i = 1; i <= loop; i++ {
            let texture = SharedAtlas.blowupTextureWithPlaneType(type, animationIndex: i)
            textures.append(texture)
        }
        let destory = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let remove = SKAction.removeFromParent()
        return SKAction.sequence([destory, remove])
    }
    
    class func blowupActionWithFoePlaneType(type: FoePlaneType) -> SKAction {
        let textureType: Int
        let textureLoop: Int
        
        switch type {
        case .Big:
            textureType = 2
            textureLoop = 7
            
        case .Medium:
            textureType = 3
            textureLoop = 4
            
        case .Small:
            textureType = 1
            textureLoop = 4
        }
        
        let action = SharedAtlas.blowupActionWithTextures(textureType, loop: textureLoop)
        return action
    }
    
    
    class func playerPlaneAction() -> SKAction {
        var textures = [SKTexture]()
        for var i = 1; i <= 2; i++ {
            let texture = SharedAtlas.playerPlaneTextureWithIndex(i)
            textures.append(texture)
        }
        let action = SKAction.repeatActionForever(SKAction.animateWithTextures(textures, timePerFrame: 0.1))
        return action
    }
    
    
    class func playerPlaneBlowupAction() -> SKAction {
        var textures = [SKTexture]()
        for var i = 1; i <= 4; i++ {
            let texture = SharedAtlas.playerPlaneBlowupTextureWithIndex(i)
            textures.append(texture)
        }
        let destory = SKAction.animateWithTextures(textures, timePerFrame: 0.1)
        let remove = SKAction.removeFromParent()
        return SKAction.sequence([destory, remove])
    }
}
