//
//  ViewController.m
//  Weather
//
//  Created by Chang Tong Xue on 2015-12-17.
//  Copyright © 2015 DX. All rights reserved.
//

#import "MainViewController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
