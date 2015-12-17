//
//  GameScene.m
//  Dark Escape
//
//  Created by Chang Tong Xue on 2015-12-12.
//  Copyright (c) 2015 DX. All rights reserved.
//

#import "GameScene.h"
static const CGFloat playerSpeed = 150.0;
static const CGFloat enemySpeed = 60.0;

@implementation GameScene {
    CGSize frameSize;
    NSMutableArray* enemies;
    CGPoint lastTouch;
    BOOL gameState;
    CFTimeInterval prevTime;
    CFTimeInterval elapsedTime;
    SKAction* moveTank;
    AVAudioPlayer* bgmSFX;
}

-(void)didMoveToView:(SKView *)view {
    [self initScene];
    [self playBackgroundMusic];
    [self addEnemies];
    [self updateCamera];
}

- (void) initScene {
    frameSize = self.frame.size;
    self.physicsWorld.contactDelegate  = self;
    self.physicsWorld.gravity         = CGVectorMake(0, 0);
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask  = edgeCategory;
    
    self.player = (SKSpriteNode*)[self childNodeWithName:@"player"];
    //self.player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: self.player.frame.size.width / 3];
    [self setNode:self.player categoryMask:playerCategory collisionMask:-1 contactMask:(goalCategory | enemyCategory)];
    
    self.goal   = (SKSpriteNode*)[self childNodeWithName:@"goal"];
    [self setNode:self.goal categoryMask:goalCategory collisionMask:-1 contactMask:playerCategory];
    
    enemies     = [[NSMutableArray alloc] init];
    lastTouch   = self.player.position;
    prevTime    = 0.0;
    gameState   = YES;
    
    moveTank = [SKAction playSoundFileNamed:@"ts-move" waitForCompletion:YES];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (prevTime == 0.0) prevTime = currentTime;
    elapsedTime = currentTime - prevTime;
}


- (void)didSimulatePhysics {
    if (gameState) {
        [self updatePlayer];
        [self updateEnemies];
    }
}

- (void) handleTouches: (NSSet*) touches {
    for (UITouch* touch in touches) {
        CGPoint loc = [touch locationInNode:self];
        lastTouch = loc;
    }
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
    CGFloat angle = atan2(location.y - position.y, location.x - position.x);
    SKAction* rotate = [SKAction rotateToAngle:angle - M_PI*0.5 duration:0];
    [sprite runAction:rotate];
}

- (void) moveObject: (SKSpriteNode*) sprite from: (CGPoint) position to: (CGPoint) location withSpeed: (CGFloat) speed {
    CGFloat angle = atan2(location.y - position.y, location.x - position.x);
    CGFloat dx = speed * cos(angle);
    CGFloat dy = speed * sin(angle);
    CGVector velocity = CGVectorMake(dx, dy);
    sprite.physicsBody.velocity = velocity;
    [self updateCamera];
}

- (void) rotateAndMove: (SKSpriteNode*) sprite from: (CGPoint) position to: (CGPoint) location withSpeed: (CGFloat) speed {
    [self rotateObject:sprite from:position to:location];
    [self moveObject:sprite from:position to:location withSpeed:speed];
}

- (void) updatePlayer {
    CGPoint pos = self.player.position;
    if ([self shouldMove:pos to:lastTouch]) {
        if (![self.player hasActions]) [self.player runAction:moveTank];
        [self rotateAndMove:self.player from:pos to:lastTouch withSpeed:playerSpeed];
    } else {
        if([self.player hasActions]) [self.player removeAllActions];
        self.player.physicsBody.resting = true;
    }
    
}

- (void) updateCamera {
    self.camera.position = self.player.position;
}

- (void) addEnemies {
    for (SKNode* child in self.children) {
        if ([child.name isEqualToString:@"enemy"]) {
            [self setNode:child categoryMask:enemyCategory collisionMask:-1 contactMask:playerCategory];
            [enemies addObject:(SKSpriteNode*)child];
        }
    }
}

- (BOOL) shouldMoveEnemy: (CGPoint) position to: (CGPoint) location {
    BOOL condA = fabs(position.x - location.x) < 300; //initial: 285
    BOOL condB = fabs(position.y - location.y) < 300; //initial: 161
    return condA || condB;
}

- (void) updateEnemies {
    for (SKSpriteNode* enemy in enemies) {
        CGPoint position = enemy.position;
        CGPoint location = self.player.position;
        if ([self shouldMoveEnemy: position to:location]) {
            [self rotateAndMove:enemy from:position to:location withSpeed:enemySpeed];
        }
    }
}


-(void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody* first  = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                            contact.bodyA : contact.bodyB; // return the SKNode with larger category
    SKPhysicsBody* second = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                            contact.bodyB : contact.bodyA; // return the SKnode with smaller category

    if (first.categoryBitMask == enemyCategory) {
        [self gameOver:NO isRecord: NO];
    } else if (first.categoryBitMask == goalCategory) {
        BOOL record = [self setRecord:elapsedTime];
        [self gameOver:YES isRecord: record];
    }
}

- (void) gameOver: (BOOL) didWin isRecord: (BOOL) record {
    [bgmSFX stop];
    [self removeAllActions];
    gameState = NO;
    
    NSString* SFX      = [NSString stringWithFormat:@"ts-%@", didWin ? @"win" : @"over"];
    SKAction* soundSFX = [SKAction playSoundFileNamed:SFX waitForCompletion:NO];
    SKAction* bombSFX  = [SKAction playSoundFileNamed:@"ts-bomb" waitForCompletion:NO];
    SKAction* sequence = [SKAction sequence: @[bombSFX, soundSFX]];
    [self runAction:sequence completion:^{
        GameEndScene* scene = [GameEndScene nodeWithFileNamed:@"GameEnd"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        scene.didWin    = didWin;
        scene.isRecord  = record;
        scene.timer     = elapsedTime;
        [self.view presentScene:scene transition:[SKTransition doorsCloseHorizontalWithDuration:1.0]];
    }];
}

- (void) playBackgroundMusic {
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"ts-bg" withExtension:@"mp3"];
    bgmSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:(NSURL *)url fileTypeHint:@"mp3" error:nil];
    bgmSFX.numberOfLoops = -1;
    bgmSFX.volume = 0.3;
    [bgmSFX prepareToPlay];
    [bgmSFX play];
}

/**
 *  Set record for the longest survival time.
 */
- (BOOL) setRecord: (float) result {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    float record = [def floatForKey:@"record"];
    if (record) {
        if (result > record) {
            [def setFloat:result forKey:@"record"];
            return YES;
        } else {
            return NO;
        }
    } else {
        [def setFloat:result forKey:@"record"];
        return YES;
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
