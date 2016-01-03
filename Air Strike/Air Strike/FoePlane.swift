//
//  FoePlane.swift
//  Air Strike
//
//  Created by Chang Tong Xue on 2016-01-01.
//  Copyright © 2016 DX. All rights reserved.
//

import SpriteKit

enum FoePlaneType: Int {
    case Big = 1
    case Medium
    case Small
}

class FoePlane: SKSpriteNode {

    var hp: Int = 1
    var type: FoePlaneType = .Small
    
    class func createSmallPlane() -> FoePlane {
        let plane = FoePlane(texture: SharedAtlas.textureWithType(.SmallFoePlane))
        plane.physicsBody = SKPhysicsBody(rectangleOfSize: plane.size)
        return plane
    }
    
    class func createMediumPlane() -> FoePlane {
        let plane = FoePlane(texture: SharedAtlas.textureWithType(.MediumFoePlane))
        plane.hp = 5
        plane.type = .Medium
        plane.physicsBody = SKPhysicsBody(rectangleOfSize: plane.size)
        return plane
    }
    
    class func createBigPlane() -> FoePlane {
        let plane = FoePlane(texture: SharedAtlas.textureWithType(.BigFoePlane))
        plane.hp = 7
        plane.type = .Big
        plane.physicsBody = SKPhysicsBody(rectangleOfSize: plane.size)
        return plane
    }

}



