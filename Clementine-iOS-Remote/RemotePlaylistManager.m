//
//  ClementinePlaylistManager.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 27.05.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "RemotePlaylistManager.h"
#import "RemotePlayer.h"

@interface RemotePlaylistManager () <PlaylistReceiverServiceListener>
@property (nonatomic, readwrite)NSInteger playingIndex;
@property (nonatomic, strong)RemotePlaylist *currentPlaylist;
@property (nonatomic, readwrite) id<PlaylistSenderServiceProtocol> playlistSenderService;
@property (nonatomic, strong) id<PlaylistReceiverServiceProtocol> playlistReceiverService;
@property (nonatomic, strong)NSMutableDictionary *dictionaryPlaylists;
@end

@implementation RemotePlaylistManager

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
        self.dictionaryPlaylists = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setSenderService:(id<PlaylistSenderServiceProtocol>)sender andReceiverService:(id<PlaylistReceiverServiceProtocol>)receiver
{
    self.playlistReceiverService = receiver;
    self.playlistSenderService = sender;
    self.playlistReceiverService.listenerPlaylistReceive = self;
}

- (void)setCurrentPlaylist:(RemotePlaylist *)currentPlaylist
{
    _currentPlaylist = currentPlaylist;
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerCurrentPlaylistDidChangeNotification
                                                        object:nil
                                                      userInfo:nil];
}

#pragma mark - PlaylistReceiverServiceListener

- (void)currentPlaylistIdDidChange:(NSInteger)playlistId
{
    self.currentPlaylist = [self.dictionaryPlaylists objectForKey:@(playlistId)];
}

- (void)currentPlaylistsDidChange:(NSArray<RemotePlaylist *> *)playlists
{
    [self.dictionaryPlaylists removeAllObjects];
    
    for (RemotePlaylist *playlist in playlists)
    {
        [self.dictionaryPlaylists setObject:playlist forKey:@(playlist.playlistId)];
    }
}

- (void)currentPlaylistSongsDidChange:(NSArray<RemoteSong *> *)playlistSongs
{
    [self.currentPlaylist setSongs:playlistSongs];
    [[NSNotificationCenter defaultCenter] postNotificationName:ClementinePlayerCurrentPlaylistSongsDidChangeNotification
                                                        object:nil
                                                      userInfo:nil];
}

@end
