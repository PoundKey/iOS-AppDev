//
//  GameEndScene.h
//  Tank Strike
//
//  Created by Chang Tong Xue on 2015-12-15.
//  Copyright © 2015 DX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "GameStartScene.h"
@interface GameEndScene : SKScene
@property (nonatomic) CFTimeInterval timer;
@property (nonatomic) BOOL isRecord;
@property (nonatomic) BOOL didWin;
@end
