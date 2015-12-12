//
//  GameStartScene.m
//  Pocket Escape
//
//  Created by Chang Tong Xue on 2015-12-11.
//  Copyright © 2015 DX. All rights reserved.
//

#import "GameStartScene.h"

@implementation GameStartScene {
    SKSpriteNode* player;
    SKAction* clickSFX;
    int totalPokemon;
    int pokemon;
}

-(void)didMoveToView:(SKView *)view {
    [self initScene];
    [self addPlayLabel];
    [self addSwitch];
    [self addPokemon];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touched = [touches anyObject];
    SKNode* touchedNode = [self nodeAtPoint:[touched locationInNode:self]];
    NSString* nodeName = touchedNode.name;
    if ([nodeName isEqualToString:@"play"]) {
        GameScene* gameScene = [GameScene sceneWithSize:self.view.frame.size];
        [gameScene setSelectedPokemon:[NSString stringWithFormat:@"Pokemon-%d", pokemon]];
        [self.view presentScene:gameScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    } else if ([nodeName isEqualToString:@"rightSwitch"]) {
        pokemon = (pokemon + 1) % totalPokemon;
        [self runAction:clickSFX];
        [self setSpriteImage:player withImage:pokemon];
    } else if ([nodeName isEqualToString:@"leftSwitch"]) {
        pokemon = (pokemon - 1 + totalPokemon) % totalPokemon;
        [self runAction:clickSFX];
        [self setSpriteImage:player withImage:pokemon];
    }
}

- (void) initScene {
    [self setBGImage: @"bgStart" toScene:self];
    clickSFX = [SKAction playSoundFileNamed:@"Sound/click" waitForCompletion:NO];
    totalPokemon = 8;
    pokemon = 0;
}

- (void) addPokemon {
    NSString* imageName = [NSString stringWithFormat:@"Pokemon-%d", pokemon];
    player = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    player.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self setSpriteScale:player To:0.8];
    [self addChild:player];
}

- (void) addPlayLabel {
    SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.fontSize = 40;
    label.color = [SKColor whiteColor];
    label.text = @"Play";
    label.name = @"play";
    label.zPosition = 3;
    label.position = CGPointMake(CGRectGetMidX(self.frame), 36);
    [self addChild:label];
}

- (void) addSwitch {
    SKSpriteNode* rightSwitch = [SKSpriteNode spriteNodeWithImageNamed:@"rarrow"];
    SKSpriteNode* leftSwitch = [SKSpriteNode spriteNodeWithImageNamed:@"larrow"];
    rightSwitch.name = @"rightSwitch";
    leftSwitch.name = @"leftSwitch";
    CGPoint mid = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    rightSwitch.position = CGPointMake(mid.x + 160, mid.y);
    leftSwitch.position = CGPointMake(mid.x - 160, mid.y);
    [self setSpriteScale:rightSwitch To:0.5];
    [self setSpriteScale:leftSwitch To:0.5];
    [self addChild:rightSwitch];
    [self addChild:leftSwitch];
}

- (void) setSpriteImage: (SKSpriteNode*) sprite withImage: (int) image {
    NSString* imageName = [NSString stringWithFormat:@"Pokemon-%d", image];
    [player setTexture:[SKTexture textureWithImageNamed:imageName]];
}

- (void) setSpriteScale: (SKSpriteNode*) sprite To: (float) scale {
    sprite.xScale = scale;
    sprite.yScale = scale;
}

- (void) setBGImage: (NSString*) image toScene: (SKNode*) scene {
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:image];
    background.size          = scene.frame.size;
    background.position      = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
    background.zPosition     = -1.0;
    [scene addChild:background];
}

@end
