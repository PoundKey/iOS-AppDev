//
//  GameScene.h
//  Dark Escape
//

//  Copyright (c) 2015 DX. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>
@property (nonatomic) SKSpriteNode* player;
@property (nonatomic) SKSpriteNode* camera;
@property (nonatomic) SKSpriteNode* gate;
@end
