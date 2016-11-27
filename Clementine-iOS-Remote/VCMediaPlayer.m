//
//  VCMediaPlayer.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 04.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "VCMediaPlayer.h"
#import "RemotePlayer.h"

@interface VCMediaPlayer ()
@property (weak, nonatomic) IBOutlet UIImageView *uiImageViewCoverArt;
@property (weak, nonatomic) IBOutlet UIImageView *uiImageViewBackground;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelSongTitle;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelSongArtist;
@property (weak, nonatomic) IBOutlet UILabel *uiLabelSongAlbum;
@property (weak, nonatomic) IBOutlet UIView *uiViewSlider;
@property (weak, nonatomic) IBOutlet UIView *uiViewPlayback;
@property (strong, nonatomic) RemoteSong *currentSong;

@end

@implementation VCMediaPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateMediaPlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentSongDidChangeNotification:) name:ClementinePlayerCurrentSongDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)currentSongDidChangeNotification:(NSNotification*)note {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateMediaPlayer];
    });
}

- (void)updateMediaPlayer {
    self.currentSong = [[RemotePlayer sharedInstance] currentSong];
    [self.uiImageViewCoverArt setImage:self.currentSong.art];
    [self.uiLabelSongTitle setText:self.currentSong.title];
    [self.uiLabelSongArtist setText:self.currentSong.artist];
    [self.uiLabelSongAlbum setText:self.currentSong.album];
    [self.uiImageViewBackground setImage:self.currentSong.art];
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
