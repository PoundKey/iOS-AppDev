//
//  FoePlane.h
//  Air Strike
//
//  Created by Chang Tong Xue on 2015-12-17.
//  Copyright © 2015 DX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(int, FoePlaneType) {
    
    FoePlaneTypeBig = 1,
    FoePlaneTypeMedium = 2,
    FoePlaneTypeSmall = 3
};


@interface FoePlane : SKSpriteNode

@property (nonatomic) int hp;
@property (nonatomic) FoePlaneType type;


+ (instancetype)createBigPlane;

+ (instancetype)createMediumPlane;

+ (instancetype)createSmallPlane;

@end

