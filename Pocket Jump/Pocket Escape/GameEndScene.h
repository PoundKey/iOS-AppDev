//
//  GameEndScene.h
//  Pocket Escape
//
//  Created by Chang Tong Xue on 2015-12-11.
//  Copyright © 2015 DX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "GameStartScene.h"

@interface GameEndScene : SKScene
@property (nonatomic) CFTimeInterval timer;
@property (nonatomic) BOOL isRecord;
@property (nonatomic) NSString* selectedPokemon;
@end
