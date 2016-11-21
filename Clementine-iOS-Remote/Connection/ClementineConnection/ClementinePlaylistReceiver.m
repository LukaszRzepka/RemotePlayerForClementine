//
//  ClementinePlaylistReceiver.m
//  Clementine-iOS-Remote
//
//  Created by Lukasz Rzepka on 08.06.2016.
//  Copyright © 2016 Lukasz Rzepka. All rights reserved.
//

#import "ClementinePlaylistReceiver.h"
#import "RemotePlaylist.h"

@implementation ClementinePlaylistReceiver

- (void)receiveFromData:(NSData *)data
{
    Message *message = [Message parseFromData:data];
    
    switch (message.type) {
        case MsgTypeActivePlaylistChanged:
        {
            [self activePlaylistChanged:message];
            break;
        }
        case MsgTypePlaylists:
        {
            [self playlists:message];
            break;
        }
        case MsgTypePlaylistSongs:
        {
            [self playlistSongs:message];
            break;
        }
        default:
            break;
    }
}

- (void)playlists:(Message*)message
{
    NSArray *playlists = message.responsePlaylists.playlist;
    NSMutableArray *newPlaylists = [[NSMutableArray alloc] init];
    
    for (Playlist *playlist in playlists)
    {
        RemotePlaylist *newPlaylist = [[RemotePlaylist alloc] initWithPlaylistMetadata:playlist];
        [newPlaylists addObject:newPlaylist];
    }
    
    [self.listenerPlaylistReceive currentPlaylistsDidChange:newPlaylists];
}

- (void)playlistSongs:(Message*)message
{
    NSArray *playlistSongs = message.responsePlaylistSongs.songs;
    NSMutableArray *newPlaylistSongs = [[NSMutableArray alloc] init];
    
    for (SongMetadata *song in playlistSongs)
    {
        RemoteSong *newSong = [[RemoteSong alloc] initWithSongMetadata:song];
        [newPlaylistSongs addObject:newSong];
    }
    
    [self.listenerPlaylistReceive currentPlaylistIdDidChange:message.responsePlaylistSongs.requestedPlaylist.id];
    [self.listenerPlaylistReceive currentPlaylistSongsDidChange:newPlaylistSongs];
}

- (void)activePlaylistChanged:(Message*)message
{
    NSInteger newId = message.responseActiveChanged.id;
    [self.listenerPlaylistReceive currentPlaylistIdDidChange:newId];
}

@end
