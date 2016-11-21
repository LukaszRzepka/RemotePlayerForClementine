//
//  MenuVC.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 26.07.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "MenuVC.h"
#import "SWRevealViewController.h"

@interface MenuVC()
@property(nonatomic, strong)NSArray *menuItems;

@end

@implementation MenuVC

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuItems = @[@"MenuCellTop", @"RemotePlayer", @"Library", @"Settings"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

@end
