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
}

- (void) initScene {
    clickSFX = [SKAction playSoundFileNamed:@"ts-start" waitForCompletion:NO];
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
    }
}

@end
