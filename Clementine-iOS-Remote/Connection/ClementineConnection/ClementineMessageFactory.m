//
//  ClementineMessageFactory.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 25.04.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementineMessageFactory.h"

@implementation ClementineMessageFactory

+ (ClementineMessage *)buildSongOfferResponse:(BOOL)accepted
{
    //TODO
    return nil;
}

+ (ClementineMessage *)buildDownloadSongMessage:(DownloadItem *)downloadItem
{
    //TODO
    return nil;
}

+ (ClementineMessage *)buildDownloadSongMessage:(DownloadItem *)downloadItem playlistId:(NSInteger)playlistId
{
    //TODO
    return nil;
}

+ (ClementineMessage *)buildDownloadSongMessage:(DownloadItem *)downloadItem playlistId:(NSInteger)playlistId urls:(NSArray *)urls
{
    //TODO
    return nil;
}

+ (ClementineMessage *)buildDownloadSongMessage:(DownloadItem *)downloadItem urls:(NSArray *)urls
{
    //TODO
    return nil;
}

+ (ClementineMessage*)buildConnectMessage:(NSString *)ip port:(NSInteger)port authCode:(NSNumber*)authCode getPlaylist:(BOOL)getPlaylist isDownloader:(BOOL)isDownloader
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeConnect];
    RequestConnectBuilder *requestConnectBuilder = [[RequestConnectBuilder alloc] init];
    if (authCode != nil)
    {
        [requestConnectBuilder setAuthCode:[authCode intValue]];
    }
    [requestConnectBuilder setSendPlaylistSongs:getPlaylist];
    [requestConnectBuilder setDownloader:isDownloader];
    
    [messageBuilder setRequestConnectBuilder:requestConnectBuilder];
    
    ClementineMessage *clementineMessage = [[ClementineMessage alloc] initWithMessage:[messageBuilder build]];
    
    clementineMessage.ip = ip;
    clementineMessage.port = port;
    
    return clementineMessage;
}

+ (ClementineMessage*)buildVolumeMessage:(NSInteger)volume
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeSetVolume];
    RequestSetVolumeBuilder *requestSetVolumeBuilder = [[RequestSetVolumeBuilder alloc] init];
    [requestSetVolumeBuilder setVolume:(int32_t)volume];
    
    [messageBuilder setRequestSetVolumeBuilder:requestSetVolumeBuilder];
    
    return [[ClementineMessage alloc] initWithMessage:[messageBuilder build]];
}

+ (ClementineMessage*)buildShuffle:(ShuffleMode)mode
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeShuffle];
    ShuffleBuilder *requestSetShuffleBuilder = [[ShuffleBuilder alloc] init];
    
    [requestSetShuffleBuilder setShuffleMode:mode];
    [messageBuilder setShuffleBuilder:requestSetShuffleBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildRepeat:(RepeatMode)mode
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeRepeat];
    RepeatBuilder *requestSetRepeatBuilder = [[RepeatBuilder alloc] init];
    
    [requestSetRepeatBuilder setRepeatMode:mode];
    [messageBuilder setRepeatBuilder:requestSetRepeatBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildRequestPlaylistSongs:(NSInteger)playlisId
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeRequestPlaylistSongs];
    RequestPlaylistSongsBuilder *requestBuilder = [[RequestPlaylistSongsBuilder alloc] init];
    
    [requestBuilder setId:(SInt32)playlisId];
    [messageBuilder setRequestPlaylistSongsBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildRequestChangeSong:(NSInteger)songIndex playlistId:(NSInteger)playlistId
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeChangeSong];
    RequestChangeSongBuilder *requestBuilder = [[RequestChangeSongBuilder alloc] init];
    
    [requestBuilder setPlaylistId:(SInt32)playlistId];
    [requestBuilder setSongIndex:(SInt32)songIndex];
    [messageBuilder setRequestChangeSongBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildTrackPosition:(NSInteger)position
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeSetTrackPosition];
    RequestSetTrackPositionBuilder *requestBuilder = [[RequestSetTrackPositionBuilder alloc] init];
    
    [requestBuilder setPosition:(SInt32)position];
    [messageBuilder setRequestSetTrackPositionBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildRateTrack:(float)rating
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder: MsgTypeRateSong];
    RequestRateSongBuilder *requestBuilder = [[RequestRateSongBuilder alloc] init];
    
    [requestBuilder setRating:(Float32)rating];
    [messageBuilder setRequestRateSongBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildInsertUrl:(NSInteger)playlistId urls:(NSArray *)urls
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeInsertUrls];
    RequestInsertUrlsBuilder *requestBuilder = [[RequestInsertUrlsBuilder alloc] init];
    
    [requestBuilder setUrlsArray:urls];
    [requestBuilder setPlaylistId:(SInt32)playlistId];
    [messageBuilder setRequestInsertUrlsBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildInsertSongs:(NSInteger)playlistId songs:(NSArray<RemoteSong*>*)songs
{
    NSLog(@"buildInsertSongs NOT IMPLEMENTED");
    return [ClementineMessageFactory buildInsertUrl:playlistId urls:songs];
}

+ (ClementineMessage*)buildRemoveSongFromPlaylist:(NSInteger)playlistId song:(RemoteSong *)song
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeRemoveSongs];
    RequestRemoveSongsBuilder *requestBuilder = [[RequestRemoveSongsBuilder alloc] init];
    NSMutableArray *songs = [[NSMutableArray alloc] init];
    [songs addObject:@(song.index)];
    
    [requestBuilder setSongsArray:songs];
    [requestBuilder setPlaylistId:(SInt32)playlistId];
    [messageBuilder setRequestRemoveSongsBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildRemoveMultipleSongsFromPlaylist:(NSInteger)playlistId songs:(NSArray<RemoteSong *> *)songs
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeRemoveSongs];
    RequestRemoveSongsBuilder *requestBuilder = [[RequestRemoveSongsBuilder alloc] init];
    NSMutableArray *indexSongs = [[NSMutableArray alloc] init];
    
    for (RemoteSong *song in songs) {
        [indexSongs addObject:@(song.index)];
    }
    
    [requestBuilder setSongsArray:indexSongs];
    [requestBuilder setPlaylistId:(SInt32)playlistId];
    [messageBuilder setRequestRemoveSongsBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildClosePlaylist:(NSInteger)playlistId
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeClosePlaylist];
    RequestClosePlaylistBuilder *requestBuilder = [[RequestClosePlaylistBuilder alloc] init];
    
    [requestBuilder setPlaylistId:(SInt32)playlistId];
    [messageBuilder setRequestClosePlaylistBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildGlobalSearch:(NSString *)query
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeGlobalSearch];
    RequestGlobalSearchBuilder *requestBuilder = [[RequestGlobalSearchBuilder alloc] init];
    
    [requestBuilder setQuery:query];
    [messageBuilder setRequestGlobalSearchBuilder:requestBuilder];
    
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}

+ (ClementineMessage*)buildPlay
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypePlay];
    return [[ClementineMessage alloc] initWithMessageBuilder: messageBuilder];
}

+ (ClementineMessage*)buildPause
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypePause];
    return [[ClementineMessage alloc] initWithMessageBuilder: messageBuilder];
}

+ (ClementineMessage*)buildNext
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeNext];
    return [[ClementineMessage alloc] initWithMessageBuilder: messageBuilder];
}

+ (ClementineMessage*)buildPrevious
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypePrevious];
    return [[ClementineMessage alloc] initWithMessageBuilder: messageBuilder];
}

+ (ClementineMessage*)buildRequestGetLibrary
{
    MessageBuilder *messageBuilder = [ClementineMessage messageBuilder:MsgTypeGetLibrary];
    return [[ClementineMessage alloc] initWithMessageBuilder:messageBuilder];
}
@end
