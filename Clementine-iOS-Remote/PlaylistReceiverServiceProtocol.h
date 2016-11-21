//
//  PlaylistReceiverServiceProtocol.h
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 08.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemotePlaylist.h"


@protocol PlaylistReceiverServiceListener <NSObject>
- (void)currentPlaylistsDidChange:(NSArray<RemotePlaylist*>*)playlists;
- (void)currentPlaylistSongsDidChange:(NSArray<RemoteSong*>*)playlistSongs;
- (void)currentPlaylistIdDidChange:(NSInteger)playlistId;
@end

@protocol PlaylistReceiverServiceProtocol <NSObject>
- (void)receiveFromData:(NSData*)data;
@property (nonatomic, weak, readwrite) id <PlaylistReceiverServiceListener> listenerPlaylistReceive;
@end
