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
            return SKAction()
        default:
            return SKAction()
        }
    }

    class func blowupActionWithFoePlaneType(type: FoePlaneType) -> SKAction {
        switch type {
        case .Big:
            return SKAction()
        default:
            return SKAction()
        }
    }
    
    class func playerPlaneAction() -> SKAction {
        return SKAction()
    }
    
    
    class func playerPlaneBlowupAction() -> SKAction {
        return SKAction()
    }
    
}
