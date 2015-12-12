//
//  GameEndScene.m
//  Pocket Escape
//
//  Created by Chang Tong Xue on 2015-12-11.
//  Copyright © 2015 DX. All rights reserved.
//

#import "GameEndScene.h"

@implementation GameEndScene
-(void)didMoveToView:(SKView *)view {
    [self playEndSound];
    [self addRestartLabel];
    [self addRecordLabel];
    [self addMainLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touched = [touches anyObject];
    SKNode* touchedNode = [self nodeAtPoint:[touched locationInNode:self]];
    if ([touchedNode.name isEqualToString:@"restart"]) {
        GameScene* gameScene = [GameScene sceneWithSize:self.view.frame.size];
        [gameScene setSelectedPokemon:self.selectedPokemon];
        [self.view presentScene:gameScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
    } else if ([touchedNode.name isEqualToString:@"main"]) {
        GameStartScene* startScene = [GameStartScene sceneWithSize:self.view.frame.size];
        [self.view presentScene:startScene transition:[SKTransition doorsCloseHorizontalWithDuration:0.8]];
    }
}

- (void)addRestartLabel {
    SKLabelNode* restart = [self getLabelWithFront:@"Chalkduster" fontSize:36 fontColor:[SKColor whiteColor]];
    restart.text = @"Restart";
    restart.name = @"restart";
    restart.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:restart];
    [self addTimerLabel];
    [self addHighlight];
}

- (void) addMainLabel {
    SKLabelNode* main = [self getLabelWithFront:@"Futura Medium" fontSize:18 fontColor:[SKColor whiteColor]];
    main.text = @"<< Main Menu";
    main.name = @"main";
    main.zPosition = 3;
    main.position = CGPointMake(75, self.frame.size.height - 40);
    [self addChild:main];
}

- (void) addTimerLabel {
    SKLabelNode* timer = [self getLabelWithFront:@"Futura Medium Italic" fontSize:15 fontColor:[SKColor whiteColor]];
    timer.text = [NSString stringWithFormat:@"Time Survived: %.02f Seconds", self.timer];
    timer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 36);
    [self addChild:timer];
}

- (void) addHighlight {
    if (self.isRecord) {
        SKLabelNode* highlight = [self getLabelWithFront:@"Futura Medium" fontSize:12 fontColor:[SKColor whiteColor]];
        highlight.text = @"(Congratulations, you reached a new record!)";
        highlight.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 50);
        [self addChild:highlight];
    }
}

- (void) playEndSound {
    NSString* SFX = self.timer > 30 ? @"Sound/levelWin" : @"Sound/gameEnd";
    if (self.isRecord) SFX = @"Sound/gameWin";
    SKAction* playSFX = [SKAction playSoundFileNamed:SFX waitForCompletion:NO];
    [self runAction:playSFX];
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

- (SKLabelNode*) getLabelWithFront: (NSString*) font fontSize: (float) size fontColor: (SKColor*) color {
    SKLabelNode* label = [SKLabelNode labelNodeWithFontNamed:font];
    label.fontSize = size;
    label.fontColor = color;
    return label;
}
@end
