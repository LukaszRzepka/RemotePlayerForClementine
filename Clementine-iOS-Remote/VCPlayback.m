//
//  VCPlayback.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 05.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "VCPlayback.h"
#import "RemotePlayer.h"

@interface VCPlayback ()
@property (weak, nonatomic) IBOutlet UIButton *uiButtonPlay;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonPrevious;
@property (weak, nonatomic) IBOutlet UIButton *uiButtonNext;
@end

@implementation VCPlayback

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updatePlayPauseButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerStateDidChange:) name:ClementinePlayerStateDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchUpInsidePlay:(id)sender {
    if ([RemotePlayer sharedInstance].state == ClementinePlayerStatePause)
    {
        [[RemotePlayer sharedInstance].playerSenderService setPlay];
    }
    else if ([RemotePlayer sharedInstance].state == ClementinePlayerStatePlay)
    {
        [[RemotePlayer sharedInstance].playerSenderService setPause];
    }
}

- (IBAction)touchUpInsidePrevious:(id)sender {
    [[RemotePlayer sharedInstance].playerSenderService setPrevious];
}

- (IBAction)touchUpInsideNext:(id)sender {
    [[RemotePlayer sharedInstance].playerSenderService setNext];
}

- (void)playerStateDidChange:(NSNotification*)note {
    __weak __typeof__(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __typeof__(self)strongSelf = weakSelf;
        [strongSelf updatePlayPauseButton];
    });
}

- (void)updatePlayPauseButton {
    if ([RemotePlayer sharedInstance].state == ClementinePlayerStatePause)
    {
        [self.uiButtonPlay setTitle:@"Play" forState:UIControlStateNormal];
    }
    else if ([RemotePlayer sharedInstance].state == ClementinePlayerStatePlay)
    {
        [self.uiButtonPlay setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
