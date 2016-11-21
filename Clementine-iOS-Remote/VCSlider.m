//
//  VCSlider.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 05.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "VCSlider.h"
#import "RemotePlayer.h"


@interface VCSlider ()
@property (weak, nonatomic) IBOutlet UISlider *uiSlider;
@end

@implementation VCSlider

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setInitialValuesForSlider];
    [self updateSlider];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentSongDidChangeNotification:) name:ClementinePlayerCurrentSongDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentSongPositionDidChangeNotification:) name:ClementinePlayerTrackPositionDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChangedSlider:(id)sender {
    [[[RemotePlayer sharedInstance] playerSenderService] setTrackPosition:self.uiSlider.value];
}

- (void)currentSongPositionDidChangeNotification:(NSNotification*)note {
    __weak __typeof__(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __typeof__(self)strongSelf = weakSelf;
        [strongSelf updateSlider];
    });
}

- (void)currentSongDidChangeNotification:(NSNotification*)note {
    __weak __typeof__(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __typeof__(self)strongSelf = weakSelf;
        [strongSelf setInitialValuesForSlider];
    });
}

- (void)updateSlider {
    [self.uiSlider setValue:[[RemotePlayer sharedInstance] trackPosition] animated:YES];
}

- (void)setInitialValuesForSlider {
    [self.uiSlider setMinimumValue:0];
    [self.uiSlider setMaximumValue:[RemotePlayer sharedInstance].currentSong.lenght];
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
