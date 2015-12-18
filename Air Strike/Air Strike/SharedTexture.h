//
//  SharedTexture.h
//  Air Strike
//
//  Created by Chang Tong Xue on 2015-12-17.
//  Copyright © 2015 DX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "FoePlane.h"

typedef NS_ENUM(int, TextureType) {
    TextureTypeBackground = 1,
    TextureTypeBullet = 2,
    TextureTypePlayerPlane = 3,
    TextureTypeSmallFoePlane = 4,
    TextureTypeMediumFoePlane = 5,
    TextureTypeBigFoePlane = 6,
};


@interface SharedTexture : SKTextureAtlas

+ (SKTexture *)textureWithType:(TextureType)type;

+ (SKAction *)playerPlaneAction;

+ (SKAction *)playerPlaneBlowupAction;

+ (SKAction *)hitActionWithFoePlaneType:(FoePlaneType)type;

+ (SKAction *)blowupActionWithFoePlaneType:(FoePlaneType)type;

@end
