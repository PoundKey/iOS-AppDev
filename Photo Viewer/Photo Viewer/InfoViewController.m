//
//  InfoViewController.m
//  Photo Viewer
//
//  Created by Chang Tong Xue on 2015-12-16.
//  Copyright © 2015 DX. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textNote;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textNote.text = self.note;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
