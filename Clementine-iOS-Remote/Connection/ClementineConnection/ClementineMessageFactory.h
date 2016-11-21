//
//  ClementineMessageFactory.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 25.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClementineMessage.h"
#import "RemoteSong.h"

@interface ClementineMessageFactory : NSObject
+ (ClementineMessage*)buildSongOfferResponse:(BOOL)accepted;
+ (ClementineMessage*)buildDownloadSongMessage:(DownloadItem*)downloadItem;
+ (ClementineMessage*)buildDownloadSongMessage:(DownloadItem *)downloadItem playlistId:(NSInteger)playlistId;
+ (ClementineMessage*)buildDownloadSongMessage:(DownloadItem *)downloadItem urls:(NSArray*)urls;
+ (ClementineMessage*)buildDownloadSongMessage:(DownloadItem *)downloadItem playlistId:(NSInteger)playlistId urls:(NSArray*)urls;
+ (ClementineMessage*)buildVolumeMessage:(NSInteger)volume;
+ (ClementineMessage*)buildConnectMessage:(NSString*)ip port:(NSInteger)port authCode:(NSNumber*)authCode getPlaylist:(BOOL)getPlaylist isDownloader:(BOOL)isDownloader;
+ (ClementineMessage*)buildShuffle:(ShuffleMode)mode;
+ (ClementineMessage*)buildRepeat:(RepeatMode)mode;
+ (ClementineMessage*)buildRequestPlaylistSongs:(NSInteger)playlisId;
+ (ClementineMessage*)buildRequestChangeSong:(NSInteger)songIndex playlistId:(NSInteger)playlistId;
+ (ClementineMessage*)buildTrackPosition:(NSInteger)position;
+ (ClementineMessage*)buildRateTrack:(float)rating;
+ (ClementineMessage*)buildInsertUrl:(NSInteger)playlistId urls:(NSArray*)urls;
+ (ClementineMessage*)buildInsertSongs:(NSInteger)playlistId songs:(NSArray<RemoteSong*>*)songs;
+ (ClementineMessage*)buildRemoveSongFromPlaylist:(NSInteger)playlistId song:(RemoteSong*)song;
+ (ClementineMessage*)buildRemoveMultipleSongsFromPlaylist:(NSInteger)playlistId songs:(NSArray<RemoteSong*>*)songs;
+ (ClementineMessage*)buildClosePlaylist:(NSInteger)playlistId;
+ (ClementineMessage*)buildGlobalSearch:(NSString*)query;
+ (ClementineMessage*)buildPlay;
+ (ClementineMessage*)buildPause;
+ (ClementineMessage*)buildNext;
+ (ClementineMessage*)buildPrevious;
+ (ClementineMessage*)buildRequestGetLibrary;
@end
