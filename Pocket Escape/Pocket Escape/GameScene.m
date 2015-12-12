//
//  GameScene.m
//  Pocket Escape
//
//  Created by Chang Tong Xue on 2015-12-10.
//  Copyright (c) 2015 DX. All rights reserved.
//

#import "GameScene.h"

@interface GameScene()
@property (nonatomic) SKSpriteNode* pokemon;
@property (nonatomic) GameEndScene* endScene;
@end

@implementation GameScene {
    
    @private
    CGSize frameSize;
    CFTimeInterval prevTime;
    CFTimeInterval elapsedTime;
    SKAction* jumpSFX;
    AVAudioPlayer* bgmSFX;
    
}

-(void)didMoveToView:(SKView *)view {
    [self initScene];
    [self addLeftEdge];
    [self addPokemon];
    [self spawnPockets];

}

-(void)update:(CFTimeInterval)currentTime {
    if (prevTime == 0.0) prevTime = currentTime;
    elapsedTime = currentTime - prevTime;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self jumpPokemon];
}

- (void) initScene {
    frameSize = self.view.frame.size;
    NSString* bgImage = [NSString stringWithFormat:@"bg%d", randomize(0, 4)];
    [self setBGImage:bgImage toScene:self];
    [self setSFX];
    [self playBackgroundMusic];
    self.endScene = [GameEndScene sceneWithSize:self.view.frame.size];
    prevTime = 0.0;
    self.physicsBody                  = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask  = edgeCategory;
    self.physicsWorld.gravity         = CGVectorMake(0, -3.2);
    self.physicsWorld.contactDelegate = self;
    
}

- (void) addPokemon {
    self.pokemon = [SKSpriteNode spriteNodeWithImageNamed:self.selectedPokemon];
    [self setSpriteScale:self.pokemon To:0.4];
    self.pokemon.position    = CGPointMake(50, CGRectGetMidY(self.frame));
    self.pokemon.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: self.pokemon.frame.size.width / 5];
    self.pokemon.physicsBody.categoryBitMask    = pokemonCategory;
    self.pokemon.physicsBody.collisionBitMask   = edgeCategory;
    self.pokemon.physicsBody.contactTestBitMask = pocketCategory;
    self.pokemon.physicsBody.allowsRotation     = NO;
    [self addChild:self.pokemon];
}

- (void) jumpPokemon {
    CGVector impluse = CGVectorMake(0.0, 28.0);
    [self runAction:jumpSFX];
    [self.pokemon.physicsBody applyImpulse:impluse];
}

- (void) addPocket {
    CGFloat rand = [self randomFrom:0.01 To:0.95];
    NSString* pname = [NSString stringWithFormat:@"Pocket-%d", randomize(1, 2)];
    SKSpriteNode* pocket = [SKSpriteNode spriteNodeWithImageNamed:pname];
    [self setSpriteScale:pocket To:0.3];
    pocket.name        = @"pocket";
    pocket.position    = CGPointMake(frameSize.width + pocket.size.width / 2, frameSize.height * rand);
    pocket.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: self.pokemon.frame.size.width / 8];
    pocket.physicsBody.categoryBitMask    = pocketCategory;
    pocket.physicsBody.collisionBitMask   = leftEdgeCategory;
    pocket.physicsBody.contactTestBitMask = pokemonCategory | leftEdgeCategory;
    pocket.physicsBody.dynamic            = YES;
    pocket.physicsBody.affectedByGravity  = NO;
    [self addChild:pocket];
    
    SKAction* movePocket = [SKAction moveByX:-frameSize.width - 2 * pocket.size.width y: 0.0
                                    duration: (NSTimeInterval) 10 * [self randomFrom:0.1 To:1.0]];
    [pocket runAction:movePocket];
}

- (void) spawnPockets {
    SKAction* spawn = [SKAction runBlock:^{ [self addPocket]; }];
    SKAction* wait  = [SKAction waitForDuration:2.5];
    SKAction* seq   = [SKAction sequence: @[spawn, wait]];
    [self runAction:[SKAction repeatActionForever:seq]];
}

- (void) addLeftEdge {
    SKNode* leftEdge = [SKNode node];
    CGPoint bottomLeft = CGPointMake(-20, 0);
    CGPoint topLeft = CGPointMake(-20, frameSize.height);
    leftEdge.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:bottomLeft toPoint:topLeft];
    leftEdge.physicsBody.categoryBitMask    = leftEdgeCategory;
    leftEdge.physicsBody.collisionBitMask   = pocketCategory;
    leftEdge.physicsBody.contactTestBitMask = pocketCategory;
    [self addChild:leftEdge];
}

- (void) setBGImage: (NSString*) image toScene: (SKNode*) scene {
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:image];
    background.size          = scene.frame.size;
    background.position      = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
    background.zPosition     = -1.0;
    [scene addChild:background];
}

- (void) setSpriteScale: (SKSpriteNode*) sprite To: (float) scale {
    sprite.xScale = scale;
    sprite.yScale = scale;
}

-(void) setSFX {
    jumpSFX = [SKAction playSoundFileNamed:@"Sound/jump2" waitForCompletion:NO];
}

- (void) playBackgroundMusic {
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Sound/BGM" withExtension:@"mp3"];
    bgmSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:(NSURL *)url fileTypeHint:@"mp3" error:nil];
    bgmSFX.numberOfLoops = -1;
    bgmSFX.volume = 0.3;
    [bgmSFX prepareToPlay];
    [bgmSFX play];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    SKPhysicsBody* first  = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                            contact.bodyA : contact.bodyB; // return the SKNode with larger category
    SKPhysicsBody* second = contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask ?
                            contact.bodyB : contact.bodyA; // return the SKnode with smaller category
    BOOL record;
    switch (first.categoryBitMask) {
        case pokemonCategory:
            // RUNSFX
            record = [self setRecord:elapsedTime];
            [self endGame: record];
            break;
        case leftEdgeCategory:
            [second.node removeFromParent];
            break;
        default:
            break;
    }
}

- (void) endGame: (BOOL) record {
    [bgmSFX stop];
    NSString* bgImage = @"bgEnd";
    [self setBGImage:bgImage toScene:self.endScene];
    [self.endScene setTimer:elapsedTime];
    [self.endScene setIsRecord:record];
    [self.endScene setSelectedPokemon:self.selectedPokemon];
    [self removeAllActions];
    [self removeAllChildren];
    [self.view presentScene:self.endScene transition:[SKTransition doorsCloseHorizontalWithDuration:0.8]];
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

/**
 *  Returns a float value between 0 and 1
 *  @return CGFloat
 */
- (CGFloat) random {
    return (CGFloat)((float)arc4random() / 0xFFFFFFFF);
}

/**
 *  returns a float value between min and main
 *  @return CGFloat
 */
- (CGFloat) randomFrom: (float) min To: (float) max {
    return [self random] * (max - min) + min;
}

/**
 *  generate a integer between start and end, inclusive
 *
 *  @param start
 *  @param end
 *
 *  @return result integer
 */
int randomize(int start, int end) {
    int n = end - start + 1;
    return arc4random_uniform(n) + start;
}

/**
 Define the contactBody Bitmask
 */
typedef NS_OPTIONS(int32_t, contactBodyCategory) {
    pocketCategory   = 0x1,
    edgeCategory     = 0x1 << 1,
    leftEdgeCategory = 0x1 << 2,
    pokemonCategory  = 0x1 << 3,
    
};

@end
