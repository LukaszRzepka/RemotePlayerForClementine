//
//  ClementineMessageParser.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementinePlayerReceiver.h"

@implementation ClementinePlayerReceiver

- (void)receiveFromData:(NSData *)data
{
    Message *message = [Message parseFromData:data];
    
    switch (message.type) {
        case MsgTypeCurrentMetainfo:
        {
            [self currentMetaInfo:message];
            break;
        }
        case MsgTypeEngineStateChanged:
        {
            [self engineStateChanged:message];
            break;
        }
        case MsgTypeInfo:
        {
            [self info:message];
            break;
        }
        case MsgTypePlay:
        {
            [self play:message];
            break;
        }
        case MsgTypePause:
        {
            [self pause:message];
            break;
        }
        case MsgTypeStop:
        {
            [self stop:message];
            break;
        }
        case MsgTypeSetVolume:
        {
            [self setVolume:message];
            break;
        }
        case MsgTypeShuffle:
        {
            [self shuffle:message];
            break;
        }
        case MsgTypeUpdateTrackPosition:
        {
            [self updateTrackPosition:message];
            break;
        }
        case MsgTypeRepeat:
        {
            [self repeat:message];
            break;
        }
        default:
            break;
    }
}

- (void)currentMetaInfo:(Message*)message
{
    RemoteSong *newSong = [[RemoteSong alloc] initWithSongMetadata:message.responseCurrentMetadata.songMetadata];
    NSInteger newPosition = 0;
    
    [self.listenerPlayerReceive currentSongDidChange:newSong];
    [self.listenerPlayerReceive currentSongPositionDidChange:newPosition];
}

- (void)engineStateChanged:(Message*)message
{
    EngineState newState = message.responseEngineStateChanged.state;
    
    switch (newState) {
        case EngineStateEmpty:
        case EngineStateIdle:
            [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStateStop];
            break;
        case EngineStatePaused:
            [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStatePause];
            break;
        case EngineStatePlaying:
            [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStatePlay];
            break;
        default:
            break;
    }
}

- (void)info:(Message*)message
{
    EngineState newState = message.responseClementineInfo.state;
    
    switch (newState) {
        case EngineStateEmpty:
        case EngineStateIdle:
            [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStateStop];
            break;
        case EngineStatePaused:
            [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStatePause];
            break;
        case EngineStatePlaying:
            [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStatePlay];
            break;
        default:
            break;
    }
}

- (void)play:(Message*)message
{
    [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStatePlay];
}

- (void)pause:(Message*)message
{
    [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStatePause];
}

- (void)stop:(Message*)message
{
    [self.listenerPlayerReceive currentPlayerStateDidChange:ClementinePlayerStateStop];
}

- (void)setVolume:(Message*)message
{
    NSInteger newVolume = message.requestSetVolume.volume;
    [self.listenerPlayerReceive currentVolumeDidChange:newVolume];
    
}

- (void)shuffle:(Message*)message
{
    ShuffleMode mode = message.shuffle.shuffleMode;
    
    switch (mode)
    {
        case ShuffleModeShuffleAlbums:
            [self.listenerPlayerReceive currentShuffleModeDidChange:ClementineShuffleModeAlbums];
            break;
        case ShuffleModeShuffleAll:
            [self.listenerPlayerReceive currentShuffleModeDidChange:ClementineShuffleModeAll];
            break;
        case ShuffleModeShuffleInsideAlbum:
            [self.listenerPlayerReceive currentShuffleModeDidChange:ClementineShuffleModeInsideAlbum];
            break;
        case ShuffleModeShuffleOff:
            [self.listenerPlayerReceive currentShuffleModeDidChange:ClementineShuffleModeOff];
            break;
        default:
            break;
    }
}

- (void)repeat:(Message*)message
{
    RepeatMode mode = message.repeat.repeatMode;
    
    switch (mode)
    {
        case RepeatModeRepeatAlbum:
            [self.listenerPlayerReceive currentRepeatModeDidChange:ClementineRepeatModeAlbum];
            break;
        case RepeatModeRepeatOff:
            [self.listenerPlayerReceive currentRepeatModeDidChange:ClementineRepeatModeOff];
            break;
        case RepeatModeRepeatPlaylist:
            [self.listenerPlayerReceive currentRepeatModeDidChange:ClementineRepeatModePlaylist];
            break;
        case RepeatModeRepeatTrack:
            [self.listenerPlayerReceive currentRepeatModeDidChange:ClementineRepeatModeTrack];
            break;
        default:
            break;
    }
}

- (void)updateTrackPosition:(Message*)message
{
    NSInteger position = message.responseUpdateTrackPosition.position;
    [self.listenerPlayerReceive currentSongPositionDidChange:position];
}


@end
