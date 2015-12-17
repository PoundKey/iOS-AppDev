//
//  DetailViewController.m
//  Photo Viewer
//
//  Created by Chang Tong Xue on 2015-12-16.
//  Copyright © 2015 DX. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logo.image = [UIImage imageNamed:self.photo.fileName];
    self.navigationItem.title = self.photo.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSegueWithIdentifier:@"info" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    InfoViewController* infoScene = [segue destinationViewController];
    infoScene.note = self.photo.note;
}


@end
