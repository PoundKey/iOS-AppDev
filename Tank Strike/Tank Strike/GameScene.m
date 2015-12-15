//
//  GameScene.m
//  Dark Escape
//
//  Created by Chang Tong Xue on 2015-12-12.
//  Copyright (c) 2015 DX. All rights reserved.
//

#import "GameScene.h"
static const CGFloat playerSpeed = 150.0;
static const CGFloat enemySpeed = 75.0;

@implementation GameScene {
    CGSize frameSize;
    NSMutableArray* enemies;
    CGPoint lastTouch;
    BOOL initialState;
    CFTimeInterval prevTime;
    CFTimeInterval elapsedTime;
}

-(void)didMoveToView:(SKView *)view {
    [self initScene];
}

- (void) initScene {
    frameSize = self.frame.size;
    self.physicsWorld.contactDelegate  = self;
    self.player = (SKSpriteNode*)[self childNodeWithName:@"player"];
    self.goal   = (SKSpriteNode*)[self childNodeWithName:@"goal"];
    self.camera = (SKCameraNode*)[self childNodeWithName:@"camera"];
    lastTouch   = self.player.position;
    prevTime    = 0.0;
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask  = edgeCategory;
    self.physicsWorld.gravity         = CGVectorMake(0, 0);
    
    [self setNode:self.player categoryMask:playerCategory collisionMask:-1 contactMask:(goalCategory | enemyCategory)];
    [self updateCamera];
}

- (void) handleTouches: (NSSet*) touches {
    for (UITouch* touch in touches) {
        CGPoint loc = [touch locationInNode:self];
        lastTouch = loc;
    }
}

- (void)didSimulatePhysics {
    [self updatePlayer];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self handleTouches:touches];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self handleTouches:touches];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self handleTouches:touches];
}

- (BOOL) shouldMove: (CGPoint) position to: (CGPoint) location {
    BOOL condA = fabs(position.x - location.x) > self.player.frame.size.width / 2;
    BOOL condB = fabs(position.y - location.y) > self.player.frame.size.height / 2;
    return condA || condB;
 }

- (void) rotateObject: (SKSpriteNode*) sprite from: (CGPoint) position to: (CGPoint) location {
    CGFloat angle = atan2(position.y - location.y, position.x - location.x);
    SKAction* rotate = [SKAction rotateToAngle:angle + M_PI*0.5 duration:0];
    [sprite runAction:rotate];
}

- (void) moveObject: (SKSpriteNode*) sprite from: (CGPoint) position to: (CGPoint) location withSpeed: (CGFloat) speed {
    CGFloat angle = atan2(position.y - location.y, position.x - location.x) + M_PI;
    CGFloat dx = speed * cos(angle);
    CGFloat dy = speed * sin(angle);
    CGVector velocity = CGVectorMake(dx, dy);
    sprite.physicsBody.velocity = velocity;
    [self updateCamera];
}

- (void) rotateAndMove: (SKSpriteNode*) sprite from: (CGPoint) position to: (CGPoint) location withSpeed: (CGFloat) speed {
    [self rotateObject:sprite from:position to:location];
    [self moveObject:sprite from:position to:location withSpeed:playerSpeed];
}

- (void) updatePlayer {
    CGPoint pos = self.player.position;
    if ([self shouldMove:pos to:lastTouch]) {
        [self rotateAndMove:self.player from:pos to:lastTouch withSpeed:playerSpeed];
    } else {
        self.player.physicsBody.resting = true;
    }
    
}

- (void) updateCamera {
    self.camera.position = self.player.position;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (prevTime == 0.0) prevTime = currentTime;
    elapsedTime = currentTime - prevTime;
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody* first  = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                            contact.bodyA : contact.bodyB; // return the SKNode with larger category
    SKPhysicsBody* second = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                            contact.bodyB : contact.bodyA; // return the SKnode with smaller category
    
    if (first.categoryBitMask == enemyCategory) {
        // Game Over
    } else if (first.categoryBitMask == goalCategory) {
        // Game Win
    }
}

- (void) setNode: (SKNode*) node categoryMask: (int32_t) m1 collisionMask: (int32_t) m2 contactMask: (int32_t) m3 {
    SKPhysicsBody* body = node.physicsBody;
    if (m1 > 0) body.categoryBitMask    = m1;
    if (m2 > 0) body.collisionBitMask   = m2;
    if (m3 > 0) body.contactTestBitMask = m3;
}

typedef NS_OPTIONS(int32_t, contactBodyCategory) {
    edgeCategory   = 0x1 << 0,
    playerCategory = 0x1 << 1,
    enemyCategory  = 0x1 << 2,
    goalCategory   = 0x1 << 3,
};

@end
