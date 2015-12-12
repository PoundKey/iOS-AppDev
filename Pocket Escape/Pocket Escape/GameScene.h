//
//  GameScene.h
//  Pocket Escape
//

//  Copyright (c) 2015 DX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "GameEndScene.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate>
@property (nonatomic) NSString* selectedPokemon;
@end
