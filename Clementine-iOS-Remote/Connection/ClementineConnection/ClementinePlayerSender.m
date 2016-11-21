//
//  RemoteSender.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 01.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementinePlayerSender.h"
#import "ClementineMessageFactory.h"

@interface ClementinePlayerSender()
@property (nonatomic, copy)MessageSenderToServer sendToServer;
@end


@implementation ClementinePlayerSender

- (instancetype)initWithBlockToSendMessage:(MessageSenderToServer)sendToServer
{
    self = [super init];
    if (self) {
        self.sendToServer = sendToServer;
    }
    return self;
}

- (void)setPlay
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildPlay];
    self.sendToServer(cMessage);
}

- (void)setPause
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildPause];
    self.sendToServer(cMessage);
}

- (void)setNext
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildNext];
    self.sendToServer(cMessage);
}

- (void)setPrevious
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildPrevious];
    self.sendToServer(cMessage);
}

-(void)setVolume:(NSInteger)volume
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildVolumeMessage:volume];
    self.sendToServer(cMessage);
}

- (void)setShuffle:(ClementineShuffleMode)mode
{
    ShuffleMode sMode;
    switch (mode) {
        case ClementineShuffleModeAlbums:
            sMode = ShuffleModeShuffleAlbums;
            break;
        case ClementineShuffleModeAll:
            sMode = ShuffleModeShuffleAll;
            break;
        case ClementineShuffleModeInsideAlbum:
            sMode = ShuffleModeShuffleInsideAlbum;
            break;
        case ClementineShuffleModeOff:
            sMode = ShuffleModeShuffleOff;
            break;
        default:
            break;
    }
    ClementineMessage *cMessage = [ClementineMessageFactory buildShuffle:sMode];
    self.sendToServer(cMessage);
}

- (void)setRepeat:(ClementineRepeatMode)repeat
{
    RepeatMode mode;
    switch (repeat) {
        case ClementineRepeatModeAlbum:
            mode = RepeatModeRepeatAlbum;
            break;
        case ClementineRepeatModeOff:
            mode = RepeatModeRepeatOff;
            break;
        case ClementineRepeatModePlaylist:
            mode = RepeatModeRepeatPlaylist;
            break;
        case ClementineRepeatModeTrack:
            mode = RepeatModeRepeatTrack;
            break;
        default:
            break;
    }
    
    ClementineMessage *cMessage = [ClementineMessageFactory buildRepeat:mode];
    self.sendToServer(cMessage);
}

- (void)setTrackPosition:(NSInteger)position
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildTrackPosition:position];
    self.sendToServer(cMessage);
}

- (void)setTrackRate:(float)rating
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildRateTrack:rating];
    self.sendToServer(cMessage);
}

- (void)searchFor:(NSString *)query
{
    ClementineMessage *cMessage = [ClementineMessageFactory buildGlobalSearch:query];
    self.sendToServer(cMessage);
}

@end
