//
//  GameScene.m
//  Paper Pong
//
//  Created by Chang Tong Xue on 2015-12-13.
//  Copyright (c) 2015 DX. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene {
    AVAudioPlayer* _bgmSFX;
    CGSize _size;
    SKSpriteNode* _player1;
    SKSpriteNode* _player2;
    SKSpriteNode* _ball;
    int _player1Score;
    int _player2Score;
    BOOL _initialState;
}

-(void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];
    [self initScene];
}

- (void) initScene {
    //[self playBackgroundMusic];
    _size = self.frame.size;
    _ball    = (SKSpriteNode*)[self childNodeWithName:@"ball"];
    _player1 = (SKSpriteNode*)[self childNodeWithName:@"player1"];
    _player2 = (SKSpriteNode*)[self childNodeWithName:@"player2"];
    
    [self setEdges];
    [self setBitMasks];
    
    _player1Score = 0;
    _player2Score = 0;
    _initialState = YES;
    
    _ball.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    _player1.position = CGPointMake(CGRectGetMidX(self.frame), 124);
    _player2.position = CGPointMake(CGRectGetMidX(self.frame), _size.height - 124);
    
    SKPhysicsBody* setup = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    setup.friction    = 0;
    setup.restitution = 1;
    self.physicsBody  = setup;
    self.physicsWorld.contactDelegate = self;
    
}

- (void) setEdges {
    CGPoint topLeft  = CGPointMake(0, _size.height);
    CGPoint topRight = CGPointMake(_size.width, _size.height);
    SKNode* topEdge  = [self getLineEdgeFrom:topLeft toPoint:topRight withCategory:topEdgeCategory];
    [self setNode:topEdge categoryMask:topEdgeCategory collisionMask:-1 contactMask:ballCategory];
    
    CGPoint bottomLeft  = CGPointMake(0, 0);
    CGPoint bottomRight = CGPointMake(_size.width, 0);
    SKNode* bottomEdge = [self getLineEdgeFrom:bottomLeft toPoint:bottomRight withCategory:bottomCategory];
    [self setNode:bottomEdge categoryMask:bottomCategory collisionMask:-1 contactMask:ballCategory];
    
    [self addChild:topEdge];
    [self addChild:bottomEdge];
}

- (SKNode*) getLineEdgeFrom: (CGPoint) p1 toPoint: (CGPoint) p2 withCategory: (int32_t) category{
    SKNode* lineEdge = [SKNode node];
    lineEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:p1 toPoint:p2];
    lineEdge.physicsBody.categoryBitMask = category;
    return lineEdge;
}

- (void) setBitMasks {
    self.physicsBody.categoryBitMask = edgeCategory;
    [self setNode:_ball categoryMask:ballCategory collisionMask:-1 contactMask:(topEdgeCategory | bottomCategory)];
}



- (void) setNode: (SKNode*) node categoryMask: (int32_t) m1 collisionMask: (int32_t) m2 contactMask: (int32_t) m3 {
    SKPhysicsBody* body = node.physicsBody;
    if (m1 > 0) body.categoryBitMask    = m1;
    if (m2 > 0) body.collisionBitMask   = m2;
    if (m3 > 0) body.contactTestBitMask = m3;
}

- (void) fireBall {
    int dx = randomize(-200, 200);
    dx = (dx >= 0 ? dx + 100 : dx - 100);
    int dy = randomize(-200, 200);
    dy = (dy >= 0 ? dy + 100 : dy - 100);
    CGVector force = CGVectorMake(dx, dy);
    [_ball.physicsBody applyImpulse:force];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches) {
        CGPoint loc = [touch locationInNode:self];
        SKNode* node = [self nodeAtPoint:loc];
        
        if ([node.name isEqualToString:@"paddle1"]) {
            [self movePlayer:_player1 to:loc];
        } else if ([node.name isEqualToString:@"paddle2"]) {
            [self movePlayer:_player2 to:loc];
        }
    }
}

- (void)movePlayer: (SKSpriteNode*)player to: (CGPoint) loc {
    float leftBound = player.frame.size.width / 2;;
    float rightBound = self.frame.size.width - leftBound;;
    CGPoint newPos = CGPointMake(loc.x, player.position.y);
    
    if (newPos.x < leftBound) {
        newPos.x = leftBound;
    } else if (newPos.x > rightBound) {
        newPos.x = rightBound;
    }
    player.position = newPos;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_initialState) {
        _initialState = NO;
        [self fireBall];
    }
}

-(void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody* first  = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                            contact.bodyA : contact.bodyB; // return the SKNode with larger category
    SKPhysicsBody* second = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                            contact.bodyB : contact.bodyA; // return the SKnode with smaller category
    
    if (second.categoryBitMask == topEdgeCategory) {
        NSLog(@"Ball hits the top edge, reset game");
    } else if (second.categoryBitMask == bottomCategory) {
        NSLog(@"Ball hits the bottom edge, reset game");
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void) playBackgroundMusic {
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Sound/BGM" withExtension:@"mp3"];
    _bgmSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:(NSURL *)url fileTypeHint:@"mp3" error:nil];
    _bgmSFX.numberOfLoops = -1;
    _bgmSFX.volume = 0.3;
    [_bgmSFX prepareToPlay];
    [_bgmSFX play];
}

/**
 *  generate a integer between start and end, inclusive
 */
int randomize(int start, int end) {
    int n = end - start + 1;
    return arc4random_uniform(n) + start;
}

typedef NS_OPTIONS(int32_t, contactBodyCategory) {
    edgeCategory    = 0x1 << 0,
    topEdgeCategory = 0x1 << 1,
    bottomCategory  = 0x1 << 2,
    ballCategory    = 0x1 << 3,
};

@end
