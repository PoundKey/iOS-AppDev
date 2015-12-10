//
//  GameScene.m
//  Brick Breaker
//
//  Created by Chang Tong Xue on 2015-12-06.
//  Copyright (c) 2015 Chang Tong Xue. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()

@property (nonatomic) SKSpriteNode* paddle;
@property (nonatomic) GameEndScene* endScene;
@end

@implementation GameScene {
    @private
    SKAction* paddleSFX;
    SKAction* brickSFX;
    CFTimeInterval prevTime;
    CFTimeInterval elapsedTime;
    BOOL initialState;
}

-(void)didMoveToView:(SKView *)view {
    
    [self initScene];
    [self addBall];
    [self addPlayer];
    [self addBricks];
    [self addBottomEdge];
    [self addSFX];
    
}

-(void)update:(CFTimeInterval)currentTime {
    if (prevTime == 0.0) prevTime = currentTime;
    elapsedTime = currentTime - prevTime;
}


- (void)initScene {
    [self addBGImage:@"bg2" toScene:self];
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask = edgeCategory;
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
    self.endScene = [GameEndScene sceneWithSize:self.view.frame.size];
    prevTime = 0.0;
    initialState = YES;
}


- (void) addBall {
    SKSpriteNode* ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball"];
    ball.name = @"ball";
    ball.position = CGPointMake(CGRectGetMidX(self.frame), self.paddle.position.y + 90);
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.frame.size.width/2];
    ball.physicsBody.friction = 0;
    ball.physicsBody.linearDamping = 0;
    ball.physicsBody.restitution = 1;
    ball.physicsBody.categoryBitMask = ballCategory;
    // Notified when ball touches bricks or the paddle
    ball.physicsBody.contactTestBitMask = brickCategory | paddleCategory | bottomEdgeCategory;
    
    [self addChild:ball];
}

- (void) addPlayer {
    self.paddle = [SKSpriteNode spriteNodeWithImageNamed:@"paddle"];
    self.paddle.position = CGPointMake(CGRectGetMidX(self.frame), 75);
    self.paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.paddle.frame.size];
    self.paddle.physicsBody.dynamic = NO;
    self.paddle.physicsBody.categoryBitMask = paddleCategory;
    [self addChild:self.paddle];
    
}

- (void) addBrick: (CGPoint) pos {
    SKSpriteNode* brick = [SKSpriteNode spriteNodeWithImageNamed:@"brick"];
    brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick.frame.size];
    brick.physicsBody.dynamic = NO;
    brick.name = @"brick";
    brick.physicsBody.categoryBitMask = brickCategory;
    brick.position = pos;
    [self addChild:brick];
}

- (void) addBricks {
    int len = self.frame.size.width / 10;
    int yPos = self.frame.size.height;
    for (int j = 0; j < 3; j++) {
        for (int i = 0; i < 9; i++) {
            [self addBrick:CGPointMake((i + 1) * len, yPos - 50 * (j + 1))];
        }
    }
}

- (void) addBottomEdge {
    SKNode* bottomEdge = [SKNode node];
    bottomEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 1) toPoint:CGPointMake(self.frame.size.width, 1)];
    bottomEdge.physicsBody.categoryBitMask = bottomEdgeCategory;
    [self addChild:bottomEdge];
}

-(void) addSFX {
    paddleSFX = [SKAction playSoundFileNamed:@"Sound/blip" waitForCompletion:NO];
    brickSFX = [SKAction playSoundFileNamed:@"Sound/brickhit" waitForCompletion:NO];
}

- (void) addBGImage: (NSString*) image toScene: (SKNode*) scene {
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:image];
    background.size = scene.frame.size;
    background.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
    background.zPosition = -1.0;
    [scene addChild:background];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (initialState) {
        initialState = NO;
        UITouch* touch = [touches anyObject];
        [self fireBall: touch];
    }
}

- (void)fireBall:(UITouch*) touch {
    
    SKNode* ball = [self childNodeWithName:@"ball"];
    CGPoint loc = [touch locationInNode:self]; // 320 x 562 iPhone 5S
    CGPoint origin = ball.position;
    CGVector vec = vectorMakeWithPoints(origin, loc);
    vec.dy = fabs(vec.dy);
    vec = vectorNormalize(vec);
    CGVector impulseVec = setImpulse(9.8, vec);
    [ball.physicsBody applyImpulse:impulseVec];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    [self movePaddle:touch];
}

- (void)movePaddle:(UITouch *)touch {
    float leftBound = self.paddle.frame.size.width / 2;;
    float rightBound = self.frame.size.width - leftBound;;
    CGPoint loc = [touch locationInNode:self];
    CGPoint newPos = CGPointMake(loc.x, 75);
    if (newPos.x < leftBound) {
        newPos.x = leftBound;
    } else if (newPos.x > rightBound) {
        newPos.x = rightBound;
    }
    self.paddle.position = newPos;
}


- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody* touched = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                             contact.bodyA : contact.bodyB;
    switch (touched.categoryBitMask) {
        case brickCategory:
            [self runAction: brickSFX];
            [touched.node removeFromParent];
            if ([self childNodeWithName:@"brick"] == nil) {
                [self setRecord:elapsedTime];
                [self endGame:YES];
            }
            break;
        case paddleCategory:
            [self runAction: paddleSFX];
            break;
        case bottomEdgeCategory:
            [self endGame:NO];
            break;
        default:
            break;
    }
}

- (void) endGame: (BOOL) gameWin {
    NSString* bgImage = gameWin ? @"bg3" : @"bg";
    [self addBGImage:bgImage toScene:self.endScene];
    [self.endScene setGameWin:gameWin];
    [self.endScene setTimer:elapsedTime];
    [self.view presentScene:self.endScene transition:[SKTransition doorsCloseHorizontalWithDuration:0.5]];
}

- (void) setRecord: (float) result {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    float record = [def floatForKey:@"record"];
    if (record) {
        if (result < record) [def setFloat:result forKey:@"record"];
    } else {
        [def setFloat:result forKey:@"record"];
    }
}

CGVector vectorMakeWithPoints (CGPoint fromPoint, CGPoint toPoint) {
    return CGVectorMake(toPoint.x - fromPoint.x, toPoint.y - fromPoint.y);
}

CGFloat vectorLength (CGVector vector) {
    return sqrt((vector.dx * vector.dx) + (vector.dy * vector.dy));
}

CGVector vectorNormalize (CGVector vector) {
    CGFloat len = vectorLength(vector);
    return CGVectorMake(vector.dx / len, vector.dy / len);
}

CGVector setImpulse (int factor, CGVector vec) {
    return CGVectorMake(vec.dx * factor, vec.dy * factor);
}

static const uint32_t ballCategory   = 0x1;  // 1
static const uint32_t brickCategory  = 0x1 << 1;  // 2
static const uint32_t paddleCategory = 0x1 << 2;  // 4
static const uint32_t edgeCategory   = 0x1 << 3;  // 8
static const uint32_t bottomEdgeCategory   = 0x1 << 4;  // 8


@end
