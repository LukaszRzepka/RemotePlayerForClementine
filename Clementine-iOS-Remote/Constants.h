//
//  Constants.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 28.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ClementinePlayerState)
{
    ClementinePlayerStatePlay,
    ClementinePlayerStatePause,
    ClementinePlayerStateStop
};

typedef NS_ENUM(NSUInteger, ClementineRepeatMode)
{
    ClementineRepeatModeOff,
    ClementineRepeatModeTrack,
    ClementineRepeatModeAlbum,
    ClementineRepeatModePlaylist
};

typedef NS_ENUM(NSUInteger, ClementineShuffleMode)
{
    ClementineShuffleModeOff,
    ClementineShuffleModeAll,
    ClementineShuffleModeInsideAlbum,
    ClementineShuffleModeAlbums
};

typedef NS_ENUM(NSUInteger, ClementineServiceStatus)
{
    ClementineServiceStatusConnecting,
    ClementineServiceStatusConnected,
    ClementineServiceStatusDisconnected
};

typedef NS_ENUM(NSUInteger, ConnectionResponse)
{
    ConnectionResponseWrongIP,
    ConnectionResponseWrongPort,
    ConnectionResponseWrongAuth,
    ConnectionResponseConnected
};

typedef NS_ENUM(NSUInteger, ClementineConnectionStatus)
{
    ClementineConnectionStatusConnecting,
    ClementineConnectionStatusConnected,
    ClementineConnectionStatusClosed
};

extern NSString *const ClementinePlayerStateDidChangeNotification;
extern NSString *const ClementinePlayerVolumeDidChangeNotification;
extern NSString *const ClementinePlayerShuffleDidChangeNotification;
extern NSString *const ClementinePlayerRepeatDidChangeNotidication;
extern NSString *const ClementinePlayerCurrentSongDidChangeNotification;
extern NSString *const ClementinePlayerTrackPositionDidChangeNotification;
extern NSString *const ClementinePlayerTrackRateDidChangeNotification;
extern NSString *const ClementinePlayerCurrentPlaylistDidChangeNotification;
extern NSString *const ClementinePlayerCurrentPlaylistSongsDidChangeNotification;

extern NSString *const ClementineConnectionStatusChangeNotification;



@interface Constants : NSObject

@end
