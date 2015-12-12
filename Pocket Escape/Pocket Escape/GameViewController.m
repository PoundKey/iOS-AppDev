//
//  GameViewController.m
//  Pocket Escape
//
//  Created by Chang Tong Xue on 2015-12-10.
//  Copyright (c) 2015 DX. All rights reserved.
//

#import "GameViewController.h"
#import "GameStartScene.h"

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.showsPhysics  = YES;
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameStartScene *scene = [GameStartScene sceneWithSize:skView.frame.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Memory Warning Triggered... 3..2..1");
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
