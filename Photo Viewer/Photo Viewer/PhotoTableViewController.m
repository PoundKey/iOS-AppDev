//
//  PhotoTableViewController.m
//  Photo Viewer
//
//  Created by Chang Tong Xue on 2015-12-16.
//  Copyright © 2015 DX. All rights reserved.
//

#import "PhotoTableViewController.h"

@interface PhotoTableViewController ()
@property NSMutableArray* photos;
@end

@implementation PhotoTableViewController {
    UIImage* icon_0;
    UIImage* icon_1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePhotos];
    [self.navigationItem setTitle:@"Golden State Warriors"];
    icon_0 = [UIImage imageNamed:@"star-0"];
    icon_1 = [UIImage imageNamed:@"star-1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Photo* photo = self.photos[indexPath.row];
    cell.textLabel.text = photo.name;
    cell.imageView.image = indexPath.row % 2 ? icon_1 : icon_0;
    return cell;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController* detailScene = [segue destinationViewController];
    NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
    detailScene.photo = self.photos[indexPath.row];
    
}

- (void) updatePhotos {
    self.photos = [[NSMutableArray alloc] init];
    
    NSString* note = @"The Secret of Getting Ahead Is Getting Started.";
    Photo* photo =  [[Photo alloc] initWithDetail:@"Team Logo NBA" fileName:@"gs1" detail:note];
    [self.photos addObject:photo];
    
    note = @"All Our Dreams Can Come True If We Have The Courage To Pursue Them";
    photo =  [[Photo alloc] initWithDetail:@"Team Logo Blue Background" fileName:@"gs2" detail:note];
    [self.photos addObject:photo];
    
    note = @"The Only Place Where Success Come Before Work Is In The Dictionary.";
    photo =  [[Photo alloc] initWithDetail:@"Team Logo Letters" fileName:@"gs3" detail:note];
    [self.photos addObject:photo];
    
    note = @"Success Does Not Consist In Never Making Mistakes, But In Never Making The Same One A Second Time.";
    photo =  [[Photo alloc] initWithDetail:@"Team Logo San Francisco" fileName:@"gs4" detail:note];
    [self.photos addObject:photo];
    
    note = @"Your Life Only Gets Better When You Get Better.";
    photo =  [[Photo alloc] initWithDetail:@"Team Logo California" fileName:@"gs5" detail:note];
    [self.photos addObject:photo];
    
    note = @"Everything You’ve Ever Wanted Is On The Other Side Of Fear.";
    photo =  [[Photo alloc] initWithDetail:@"Golden States 50 Years" fileName:@"gs6" detail:note];
    [self.photos addObject:photo];
    
    note = @"Think Big And Don’t Listen To People Who Tell You It Can’t Be Done. Life’s Too Short To Think Small.";
    photo =  [[Photo alloc] initWithDetail:@"NBA Championship 2015" fileName:@"gs7" detail:note];
    [self.photos addObject:photo];
    
}

@end
