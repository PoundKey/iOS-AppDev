//
//  FoePlane.m
//  Air Strike
//
//  Created by Chang Tong Xue on 2015-12-17.
//  Copyright © 2015 DX. All rights reserved.
//

#import "FoePlane.h"

@implementation FoePlane

+ (instancetype)createBigPlane{
    FoePlane *foePlane = (FoePlane *)[FoePlane spriteNodeWithTexture:[SharedTexture textureWithType:TextureTypeBigFoePlane]];
    foePlane.hp = 7;
    foePlane.type = FoePlaneTypeBig;
    foePlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:foePlane.size];
    return foePlane;
}

+ (instancetype)createMediumPlane{
    FoePlane *foePlane = (FoePlane *)[FoePlane spriteNodeWithTexture:[SharedTexture textureWithType:TextureTypeMediumFoePlane]];
    foePlane.hp = 5;
    foePlane.type = FoePlaneTypeMedium;
    foePlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:foePlane.size];
    return foePlane;
}

+ (instancetype)createSmallPlane{
    FoePlane *foePlane = (FoePlane *)[FoePlane spriteNodeWithTexture:[SharedTexture textureWithType:TextureTypeSmallFoePlane]];
    foePlane.hp = 1;
    foePlane.type = FoePlaneTypeSmall;
    foePlane.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:foePlane.size];
    return foePlane;
}


@end
