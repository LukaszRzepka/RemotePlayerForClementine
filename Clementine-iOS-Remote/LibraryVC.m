//
//  LibraryVC.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 26.07.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "LibraryVC.h"
#import "SWRevealViewController.h"

@interface LibraryVC()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@end

@implementation LibraryVC
-(void)viewDidLoad {
    [super viewDidLoad];
    //TODO: ogarnac jak dziala ta magia :D
    SWRevealViewController *rvc = self.revealViewController;
    if (rvc) {
        [self.menuButton setTarget:self.revealViewController];
        [self.menuButton setAction:@selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}
@end
