//
//  GameEndScene.m
//  Tank Strike
//
//  Created by Chang Tong Xue on 2015-12-15.
//  Copyright © 2015 DX. All rights reserved.
//

#import "GameEndScene.h"

@implementation GameEndScene {
    SKAction* clickSFX;
}

-(void)didMoveToView:(SKView *)view {
    [self initScene];
    [self updateRecord];
    [self updateTimer];
}

- (void) initScene {
    clickSFX = [SKAction playSoundFileNamed:@"ts-start" waitForCompletion:NO];
    if (self.didWin) [self addEmitter];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touched = [touches anyObject];
    SKNode* touchedNode = [self nodeAtPoint:[touched locationInNode:self]];
    NSString* nodeName = touchedNode.name;
    if ([nodeName isEqualToString:@"restart"]) {
        [self runAction:clickSFX];
        GameScene* scene = [GameScene nodeWithFileNamed:@"GameScene"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    } else if ([nodeName isEqualToString:@"main"]) {
        GameStartScene* scene = [GameStartScene nodeWithFileNamed:@"GameStart"];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:scene transition:[SKTransition doorsCloseHorizontalWithDuration:0.75]];
    }
}

- (void) updateRecord {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    float record = [def floatForKey:@"record"];
    SKLabelNode* recordNode = (SKLabelNode*)[self childNodeWithName:@"record"];
    NSString* recordText = [NSString stringWithFormat:@"Best Record: %.02f Seconds", record];
    recordNode.text = recordText;
}

- (void) updateTimer {
    SKLabelNode* timer   = (SKLabelNode*)[self childNodeWithName:@"timer"];
    SKLabelNode* message = (SKLabelNode*)[self childNodeWithName:@"message"];
    NSString* label;
    if (self.didWin) {
        label = [NSString stringWithFormat:@"Mission Succeeded! Time Used: %.02f Seconds", self.timer];
        timer.text = label;
        NSString* notice = @"(Congratulations, you just set a new record for the mission!)";
        message.text = self.isRecord ? notice : @"";
    } else {
        label = [NSString stringWithFormat:@"Mission Failed! Time Survived: %.02f Seconds", self.timer];
        timer.text = label;
        message.text = @"";
    }
}

- (void) addEmitter {
    NSString* eType = @"Spark";
    SKEmitterNode* emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:eType ofType:@"sks"]];
    emitter.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 20);
    // [emiiter advanceSimulationTime:3];
    [self addChild:emitter];
}


@end
