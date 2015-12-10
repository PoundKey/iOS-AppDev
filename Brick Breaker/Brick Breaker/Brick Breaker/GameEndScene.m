//
//  GameOverScene.m
//  Brick Breaker
//
//  Created by Chang Tong Xue on 2015-12-07.
//  Copyright © 2015 Chang Tong Xue. All rights reserved.
//

#import "GameEndScene.h"

@implementation GameEndScene

-(void)didMoveToView:(SKView *)view {
    //self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    [self playEndSound];
    [self addEmitter];
    [self addGameEndLabel];
    [self addRestartLabel];
    [self addRecordLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // UITouch *touched = [touches anyObject];
    for (UITouch* touched in touches) {
        SKNode* touchedNode = [self nodeAtPoint:[touched locationInNode:self]];
        if ([touchedNode.name isEqualToString:@"restart"]) {
            GameScene* gameScene = [GameScene sceneWithSize:self.view.frame.size];
            [self.view presentScene:gameScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
        }
    }
}

- (void)addRestartLabel {
    SKLabelNode* restart = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    restart.text = @"Restart";
    restart.name = @"restart";
    restart.fontColor = [SKColor whiteColor];
    restart.fontSize = 21;
    restart.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 60);
    [self addChild:restart];
    if (self.gameWin) [self addTimerLabel];
}

- (void) addTimerLabel {
    SKLabelNode* timer = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium Italic"];
    timer.text = [NSString stringWithFormat:@"Time Elapsed: %.02f Seconds", self.timer];
    timer.fontColor = [SKColor whiteColor];
    timer.fontSize = 15;
    timer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 120);
    [self addChild:timer];
}

- (void) addRecordLabel {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    float record = [def floatForKey:@"record"];
    SKLabelNode* rec = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    rec.text = [NSString stringWithFormat:@"Best Record: %.02f Seconds", record];
    rec.fontColor = [SKColor whiteColor];
    rec.fontSize = 15;
    rec.position = CGPointMake(CGRectGetMidX(self.frame), 30);
    [self addChild:rec];
}

- (void) addGameEndLabel {
    SKLabelNode* gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura Medium"];
    gameOverLabel.text = self.gameWin ? @"YOU WIN!" : @"GAME OVER.";
    gameOverLabel.fontColor = [SKColor whiteColor];
    gameOverLabel.fontSize = 36;
    gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:gameOverLabel];
}

- (void) playEndSound {
    NSString* SFX = [NSString stringWithFormat:@"Sound/%@", self.gameWin ? @"win" : @"gameover"];
    SKAction* playSFX = [SKAction playSoundFileNamed:SFX waitForCompletion:NO];
    [self runAction:playSFX];
}

- (void) addEmitter {
    NSString* eType = self.gameWin ? @"Spark" : @"Snow";
    SKEmitterNode* emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:eType ofType:@"sks"]];
    emitter.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 30);
    // [emiiter advanceSimulationTime:3];
    [self addChild:emitter];
}



@end
