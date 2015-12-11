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

@end


@implementation GameScene {
    
    @private
    CGSize frameSize;
    CFTimeInterval prevTime;
    CFTimeInterval elapsedTime;
}

-(void)didMoveToView:(SKView *)view {
    [self initScene];
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
    self.physicsBody                  = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask  = edgeCategory;
    self.physicsWorld.gravity         = CGVectorMake(0, -3.2);
    self.physicsWorld.contactDelegate = self;
    
}

- (void) addPokemon {
    self.pokemon = [SKSpriteNode spriteNodeWithImageNamed:@"Pokemon_1"];
    [self setSpriteScale:self.pokemon To:0.4];
    self.pokemon.name        = @"pokemon";
    self.pokemon.position    = CGPointMake(50, CGRectGetMidY(self.frame));
    self.pokemon.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: self.pokemon.frame.size.width / 4];
    self.pokemon.physicsBody.categoryBitMask    = pokemonCategory;
    self.pokemon.physicsBody.collisionBitMask   = edgeCategory;
    self.pokemon.physicsBody.contactTestBitMask = pokemonCategory;
    self.pokemon.physicsBody.allowsRotation     = NO;
    [self addChild:self.pokemon];
}

- (void) jumpPokemon {
    CGVector impluse = CGVectorMake(0.0, 36.0);
    [self.pokemon.physicsBody applyImpulse:impluse];
}

- (void) addPocket {
    SKSpriteNode* pocket = [SKSpriteNode spriteNodeWithImageNamed:@"Pocket"];
    [self setSpriteScale:pocket To:0.3];
    pocket.name        = @"pocket";
    pocket.position    = CGPointMake(frameSize.width + pocket.size.width / 2, frameSize.height * [self randomFrom:0.03 To:0.95]);
    pocket.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: self.pokemon.frame.size.width / 6];
    pocket.physicsBody.categoryBitMask    = pocketCategory;
    pocket.physicsBody.collisionBitMask   = 0;
    pocket.physicsBody.contactTestBitMask = pokemonCategory;
    pocket.physicsBody.dynamic            = NO;
    pocket.physicsBody.affectedByGravity  = NO;
    [self addChild:pocket];
    
    SKAction* movePocket = [SKAction moveByX:-frameSize.width - pocket.size.width y: 0.0
                                    duration: (NSTimeInterval) 10 * [self randomFrom:0.1 To:1.0]];
    [pocket runAction:movePocket];
}

- (void) spawnPockets {
    SKAction* spawn = [SKAction runBlock:^{ [self addPocket]; }];
    SKAction* wait  = [SKAction waitForDuration:2.5];
    SKAction* seq   = [SKAction sequence: @[spawn, wait]];
    [self runAction:[SKAction repeatActionForever:seq]];
}

- (void) setBGImage: (NSString*) image toScene: (SKNode*) scene {
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:image];
    background.size          = scene.frame.size;
    background.position      = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
    background.zPosition     = -1.0;
    [scene addChild:background];
}

- (void) setLabel {
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text     = @"Hello, World!";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    [self addChild:myLabel];
}

- (void) setSpriteScale: (SKSpriteNode*) sprite To: (float) scale {
    sprite.xScale = scale;
    sprite.yScale = scale;
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
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
 Define the contactBody Bitmask
 */
typedef NS_OPTIONS(int32_t, contactBodyCategory) {
    edgeCategory     = 0x1,
    pokemonCategory  = 0x1 << 1,
    pocketCategory   = 0x1 << 2,
    leftEdgeCategory = 0x1 << 3
};

@end
