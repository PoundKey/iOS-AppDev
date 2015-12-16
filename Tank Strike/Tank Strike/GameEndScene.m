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

}

- (void) initScene {
    clickSFX = [SKAction playSoundFileNamed:@"ts-start" waitForCompletion:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touched = [touches anyObject];
    SKNode* touchedNode = [self nodeAtPoint:[touched locationInNode:self]];
    NSString* nodeName = touchedNode.name;
    if ([nodeName isEqualToString:@"start"]) {
        [self runAction:clickSFX];
        GameScene* gameScene = [GameScene nodeWithFileNamed:@"GameScene"];
        gameScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.view presentScene:gameScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    }
}

@end
