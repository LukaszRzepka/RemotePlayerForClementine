//
//  Clementine.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "RemotePlayer.h"

@interface RemotePlayer() <PlayerReceiverServiceListener>
@property (nonatomic, readwrite) id<PlayerSenderServiceProtocol> playerSenderService;
@property (nonatomic, strong) id<PlayerReceiverServiceProtocol> playerReceiverService;

@property (nonatomic, readwrite)float trackRate;
@property (nonatomic, readwrite)NSInteger volume;
@property (nonatomic, readwrite)NSInteger trackPosition;
@property (nonatomic, readwrite)ClementineRepeatMode repeat;
@property (nonatomic, readwrite)ClementineShuffleMode shuffle;
@property (nonatomic, strong, readwrite)RemoteSong *currentSong;
@property (nonatomic, readwrite)ClementinePlayerState state;
@end

@implementation RemotePlayer

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[super alloc] initInstance];
    });
    return sharedInstance;
}

- (instancetype)initInstance
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

- (void)setPlayerSenderService:(id<PlayerSenderServiceProtocol>)playerSenderService andReceiverService:(id<PlayerReceiverServiceProtocol>)receiverService
{
    self.playerSenderService = playerSenderService;
    self.playerReceiverService = receiverService;
    self.playerReceiverService.listenerPlayerReceive = self;
}

- (void)setVolume:(NSInteger)volume
{
    _volume = volume;
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerVolumeDidChangeNotification
                                                        object:nil
                                                      userInfo:nil];
}

- (void)setTrackRate:(float)trackRate
{
    _trackRate = trackRate;
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerTrackRateDidChangeNotification
                                                        object:nil
                                                      userInfo:nil];
}

- (void)setShuffle:(ClementineShuffleMode)shuffle
{
    _shuffle = shuffle;
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerShuffleDidChangeNotification
                                                        object:nil
                                                      userInfo:nil];
}

- (void)setTrackPosition:(NSInteger)trackPosition
{
    _trackPosition = trackPosition;
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerTrackPositionDidChangeNotification
                                                        object:nil
                                                      userInfo:nil];
}

- (void)setRepeat:(ClementineRepeatMode)repeat
{
    _repeat = repeat;
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerRepeatDidChangeNotidication
                                                        object:nil
                                                      userInfo:nil];
}

- (void)setCurrentSong:(RemoteSong *)currentSong
{
    _currentSong = currentSong;
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerCurrentSongDidChangeNotification
                                                        object:nil
                                                      userInfo:nil];
}

- (void)setState:(ClementinePlayerState)state
{
    _state = state;
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerStateDidChangeNotification
                                                        object:nil
                                                      userInfo:nil];
}


#pragma mark - PlayerReceiverServiceListener

- (void)currentPlayerStateDidChange:(ClementinePlayerState)state
{
    self.state = state;
}

- (void)currentRepeatModeDidChange:(ClementineRepeatMode)mode
{
    self.repeat = mode;
}

- (void)currentShuffleModeDidChange:(ClementineShuffleMode)mode
{
    self.shuffle = mode;
}

- (void)currentSongDidChange:(RemoteSong *)song
{
    self.currentSong = song;
}

- (void)currentSongPositionDidChange:(NSInteger)position
{
    self.trackPosition = position;
}

- (void)currentVolumeDidChange:(NSInteger)volume
{
    self.volume = volume;
}

@end
