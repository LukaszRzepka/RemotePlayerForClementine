//
//  VCVolumeControl.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 08.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "VCVolumeControl.h"
#import "RemotePlayer.h"

@interface VCVolumeControl ()
@property (weak, nonatomic) IBOutlet UIStepper *uiStepper;
@end

@implementation VCVolumeControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.uiStepper setMaximumValue:100];
    [self.uiStepper setMinimumValue:0];
    [self updateVolumeStepper];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeDidChangeNotification:) name:ClementinePlayerVolumeDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChangedStepper:(id)sender {
    [[RemotePlayer sharedInstance].playerSenderService setVolume:self.uiStepper.value];
}

- (void)volumeDidChangeNotification:(NSNotification*)note {
    __weak __typeof__(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __typeof__(self)strongSelf = weakSelf;
        [strongSelf.uiStepper setValue:[[RemotePlayer sharedInstance] volume]];
    });
}

- (void)updateVolumeStepper {
    [self.uiStepper setValue:[[RemotePlayer sharedInstance] volume]];
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
