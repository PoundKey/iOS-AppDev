//
//  SharedTexture.m
//  Air Strike
//
//  Created by Chang Tong Xue on 2015-12-17.
//  Copyright © 2015 DX. All rights reserved.
//

#import "SharedTexture.h"

@interface SharedTexture ()

@end

@implementation SharedTexture

static SharedTexture* _shared = nil;

+ (instancetype)shared {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = (SharedTexture*) [SharedTexture atlasNamed:@"gameArts-hd"];
    });
    return _shared;
}

+ (SKTexture *)textureWithType:(TextureType) type {
    
    switch (type) {
        case TextureTypeBackground:
            return [[[self class] shared] textureNamed:@"background_2.png"];
            break;
        case TextureTypeBullet:
            return [[[self class] shared] textureNamed:@"bullet1.png"];
            break;
        case TextureTypePlayerPlane:
            return [[[self class] shared] textureNamed:@"hero_fly_1.png"];
            break;
        case TextureTypeSmallFoePlane:
            return [[[self class] shared] textureNamed:@"enemy1_fly_1.png"];
            break;
        case TextureTypeMediumFoePlane:
            return [[[self class] shared] textureNamed:@"enemy3_fly_1.png"];
            break;
        case TextureTypeBigFoePlane:
            return [[[self class] shared] textureNamed:@"enemy2_fly_1.png"];
            break;
        default:
            break;
    }
    return nil;
}

+ (SKTexture *)playerPlaneTextureWithIndex:(int) index {
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"hero_fly_%d.png", index]];
}

+ (SKTexture *)playerPlaneBlowupTextureWithIndex:(int) index {
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"hero_blowup_%d.png", index]];
}

+ (SKTexture *)hitTextureWithPlaneType:(int) type animatonIndex:(int)animatonIndex{
    
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"enemy%d_hit_%d.png",type,animatonIndex]];
}

+ (SKTexture *)blowupTextureWithPlaneType:(int) type animatonIndex:(int)animatonIndex{
    
    return [[[self class] shared] textureNamed:[NSString stringWithFormat:@"enemy%d_blowup_%i.png",type,animatonIndex]];
}

+ (SKAction *)hitActionWithFoePlaneType:(FoePlaneType) type {
    
    switch (type) {
        case 1:
        {
            NSMutableArray *textures = [[NSMutableArray alloc]init];
            
            SKTexture *texture1 = [[self class] hitTextureWithPlaneType:2 animatonIndex:1];
            SKAction *action1 = [SKAction setTexture:texture1];
            
            SKTexture *texture2 = [[self class] textureWithType:TextureTypeBigFoePlane];
            SKAction *action2 = [SKAction setTexture:texture2];
            
            [textures addObject:action1];
            [textures addObject:action2];
            
            return [SKAction sequence:textures];
        }
            break;
        case 2:
        {
            NSMutableArray *textures = [[NSMutableArray alloc]init];
            for (int i = 1; i<=2; i++) {
                SKTexture *texture = [[self class] hitTextureWithPlaneType:3 animatonIndex:i];
                SKAction *action = [SKAction setTexture:texture];
                [textures addObject:action];
            }
            
            return [SKAction sequence:textures];
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
    return nil;
}


@end
