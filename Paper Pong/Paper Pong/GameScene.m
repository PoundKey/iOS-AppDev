//
//  GameScene.m
//  Paper Pong
//
//  Created by Chang Tong Xue on 2015-12-13.
//  Copyright (c) 2015 DX. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    SKSpriteNode* _player;
    SKSpriteNode* _ball;
}

-(void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    [self initScene];
}

- (void) initScene {
    SKPhysicsBody* setup = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    setup.friction    = 0;
    setup.restitution = 1;
    self.physicsBody  = setup;
    self.physicsWorld.contactDelegate = self;
    _ball = (SKSpriteNode*)[self childNodeWithName:@"ball"];
    
}

- (void) fireBall {
    CGVector force = CGVectorMake(0, 100);
    [_ball.physicsBody applyImpulse:force];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {

        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
